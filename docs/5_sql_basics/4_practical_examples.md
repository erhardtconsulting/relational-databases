# Praxisbeispiele mit der Verein-Datenbank

## Realistische Anwendungsszenarien

In diesem Kapitel wenden wir die bisher gelernten SQL-Grundlagen auf realistische Szenarien an, die typischerweise in der Verwaltung eines Vereins vorkommen. Anhand der Verein-Datenbank werden wir konkrete Herausforderungen aus dem Vereinsalltag mit SQL-Befehlen lösen.

Diese praktischen Beispiele helfen dir, die Konzepte besser zu verstehen und zu sehen, wie die verschiedenen SQL-Befehle zusammenspielen, um reale Aufgaben zu bewältigen.

## Szenario 1: Mitgliederverwaltung

### Aufgabe: Neue Mitglieder aufnehmen

Ein Verein muss regelmässig neue Mitglieder aufnehmen. Hierfür müssen wir:
1. Das neue Mitglied in die Personen-Tabelle einfügen
2. Eine Standard-Funktion (z.B. "Mitglied") zuweisen
3. Später möglicherweise den Status ändern

```sql
-- Transaktion starten
BEGIN;

-- Neues Mitglied einfügen
INSERT INTO Person (
    PersID, Name, Vorname, Strasse_Nr, PLZ, Ort, 
    bezahlt, Bemerkungen, Eintritt, StatID
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Muster', 'Maria', 'Seeweg 15', '3000', 'Bern',
    'N',  -- Noch nicht bezahlt
    'Über Webformular beigetreten',
    CURRENT_DATE,  -- Heutiges Datum als Eintrittsdatum
    (SELECT StatID FROM Status WHERE Bezeichner = 'Aktivmitglied')
);

-- Letztes eingefügtes PersID abrufen (in PostgreSQL)
DO $$
DECLARE
    new_persid UUID;
BEGIN
    SELECT PersID INTO new_persid
    FROM Person
    WHERE Name = 'Muster' AND Vorname = 'Maria' AND Eintritt = CURRENT_DATE;
    
    -- Dem neuen Mitglied die Standard-Mitgliedsfunktion zuweisen
    INSERT INTO Funktionsbesetzung (FunkID, PersID, Antritt)
    VALUES (
        (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Mitglied'),
        new_persid,
        CURRENT_DATE
    );
END $$;

-- Transaktion abschliessen
COMMIT;
```

### Aufgabe: Mitgliederübersicht erstellen

Der Vorstand benötigt eine Übersicht aller aktiven Mitglieder mit ihrem Status:

```sql
-- Aktive Mitglieder (ohne Austrittsdatum) mit Statusbezeichnung
SELECT 
    p.Name, 
    p.Vorname, 
    p.Eintritt, 
    s.Bezeichner AS Status,
    s.Beitrag AS Jahresbeitrag,
    p.bezahlt,
    p.Ort
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.Austritt IS NULL
ORDER BY 
    p.Name, p.Vorname;
```

### Aufgabe: Säumige Zahler identifizieren

Vor der Hauptversammlung müssen alle Mitglieder identifiziert werden, die ihren Beitrag noch nicht bezahlt haben:

```sql
-- Mitglieder mit unbezahltem Beitrag
SELECT 
    p.Name, 
    p.Vorname, 
    p.Strasse_Nr,
    p.PLZ,
    p.Ort, 
    s.Beitrag,
    p.Eintritt
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.bezahlt = 'N'
    AND p.Austritt IS NULL
    AND s.Beitrag > 0  -- Nur Mitglieder, die tatsächlich einen Beitrag zahlen müssen
ORDER BY 
    p.Name, p.Vorname;

-- Gesamtbetrag der ausstehenden Zahlungen
SELECT 
    SUM(s.Beitrag) AS Gesamtausstehend
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.bezahlt = 'N'
    AND p.Austritt IS NULL
    AND s.Beitrag > 0;
```

### Aufgabe: Zahlungsstatus aktualisieren

Nach Eingang der Zahlungen müssen die entsprechenden Mitglieder als "bezahlt" markiert werden:

```sql
-- Beitragszahlung registrieren
UPDATE Person
SET bezahlt = 'J'
WHERE PersID = '123e4567-e89b-12d3-a456-426614174000';  -- UUID des Mitglieds

-- Oder mehrere Mitglieder mit einer Liste von IDs aktualisieren
UPDATE Person
SET bezahlt = 'J'
WHERE PersID IN (
    '123e4567-e89b-12d3-a456-426614174000',
    '234f5678-f90c-23e4-b567-537725285111',
    '345g6789-g01d-34f5-c678-648836396222'
);
```

## Szenario 2: Veranstaltungsmanagement

### Aufgabe: Veranstaltung planen

Ein neuer Vereinsanlass wird geplant:

```sql
-- Neuen Anlass einfügen
INSERT INTO Anlass (
    AnlaID, Bezeichner, Ort, Datum, Kosten, OrgID
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Sommerfest 2025',
    'Stadtpark Bern',
    '2025-07-20',  -- Datum im ISO-Format
    1500.00,  -- Geschätzte Kosten
    (SELECT PersID FROM Person WHERE Name = 'Schmidt' AND Vorname = 'Hans')  -- Organisator
);
```

### Aufgabe: Teilnehmer-Anmeldungen erfassen

Mitglieder melden sich für den Anlass an:

```sql
-- Teilnehmer für einen Anlass registrieren
INSERT INTO Teilnehmer (PersID, AnlaID)
VALUES (
    (SELECT PersID FROM Person WHERE Name = 'Müller' AND Vorname = 'Max'),
    (SELECT AnlaID FROM Anlass WHERE Bezeichner = 'Sommerfest 2025')
);

-- Mehrere Teilnehmer auf einmal registrieren
INSERT INTO Teilnehmer (PersID, AnlaID)
SELECT 
    p.PersID,
    (SELECT AnlaID FROM Anlass WHERE Bezeichner = 'Sommerfest 2025')
FROM 
    Person p
WHERE 
    p.Name IN ('Weber', 'Schneider', 'Fischer')
    AND p.Austritt IS NULL;
```

### Aufgabe: Teilnehmerliste erstellen

Vor der Veranstaltung wird eine Teilnehmerliste benötigt:

```sql
-- Teilnehmerliste für einen bestimmten Anlass
SELECT 
    p.Name, 
    p.Vorname, 
    p.Ort,
    s.Bezeichner AS Status
FROM 
    Person p
JOIN 
    Teilnehmer t ON p.PersID = t.PersID
JOIN 
    Status s ON p.StatID = s.StatID
JOIN 
    Anlass a ON t.AnlaID = a.AnlaID
WHERE 
    a.Bezeichner = 'Sommerfest 2025'
ORDER BY 
    p.Name, p.Vorname;

-- Anzahl der Teilnehmer
SELECT 
    COUNT(*) AS Teilnehmeranzahl
FROM 
    Teilnehmer t
JOIN 
    Anlass a ON t.AnlaID = a.AnlaID
WHERE 
    a.Bezeichner = 'Sommerfest 2025';
```

### Aufgabe: Veranstaltungsstatistik

Nach der Veranstaltung wird eine Statistik erstellt:

```sql
-- Teilnahmestatistik nach Status
SELECT 
    s.Bezeichner AS Status,
    COUNT(t.PersID) AS Anzahl,
    ROUND(COUNT(t.PersID) * 100.0 / (SELECT COUNT(*) FROM Teilnehmer WHERE AnlaID = a.AnlaID), 1) AS Prozent
FROM 
    Anlass a
JOIN 
    Teilnehmer t ON a.AnlaID = t.AnlaID
JOIN 
    Person p ON t.PersID = p.PersID
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    a.Bezeichner = 'Sommerfest 2025'
GROUP BY 
    s.Bezeichner, a.AnlaID
ORDER BY 
    Anzahl DESC;
```

## Szenario 3: Sponsorenverwaltung

### Aufgabe: Neuen Sponsor erfassen

Ein neuer Sponsor soll in die Datenbank aufgenommen werden:

```sql
-- Neuen Sponsor erfassen
INSERT INTO Sponsor (
    SponID, Name, Strasse_Nr, PLZ, Ort, Spendentotal
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Tech Solutions AG',
    'Industriestrasse 45',
    '3000',
    'Bern',
    0  -- Startwert für Spendentotal
);

-- Ansprechperson im Verein erfassen
INSERT INTO Sponsorenkontakt (PersID, SponID)
VALUES (
    (SELECT PersID FROM Person WHERE Name = 'Meier' AND Vorname = 'Thomas'),
    (SELECT SponID FROM Sponsor WHERE Name = 'Tech Solutions AG')
);
```

### Aufgabe: Spendeneingänge verbuchen

Eine neue Spende wird verbucht:

```sql
BEGIN;

-- Neue Spende erfassen
INSERT INTO Spende (
    SpenID, Bezeichner, Datum, Betrag, SponID, AnlaID
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Sponsoring Sommerfest',
    CURRENT_DATE,
    1000.00,
    (SELECT SponID FROM Sponsor WHERE Name = 'Tech Solutions AG'),
    (SELECT AnlaID FROM Anlass WHERE Bezeichner = 'Sommerfest 2025')
);

-- Spendentotal des Sponsors aktualisieren
UPDATE Sponsor
SET Spendentotal = Spendentotal + 1000.00
WHERE Name = 'Tech Solutions AG';

COMMIT;
```

### Aufgabe: Sponsorenauswertung

Für den Jahresbericht wird eine Sponsorenauswertung benötigt:

```sql
-- Top-Sponsoren nach Gesamtspenden
SELECT 
    s.Name AS Sponsor,
    s.Ort,
    s.Spendentotal AS Gesamtspenden,
    COUNT(sp.SpenID) AS Anzahl_Spenden,
    MAX(sp.Betrag) AS Grösste_Einzelspende,
    MIN(sp.Datum) AS Erste_Spende,
    MAX(sp.Datum) AS Letzte_Spende
FROM 
    Sponsor s
LEFT JOIN 
    Spende sp ON s.SponID = sp.SponID
GROUP BY 
    s.SponID, s.Name, s.Ort, s.Spendentotal
ORDER BY 
    s.Spendentotal DESC;

-- Sponsoren nach Anzahl der unterstützten Anlässe
SELECT 
    s.Name AS Sponsor,
    COUNT(DISTINCT sp.AnlaID) AS Unterstützte_Anlässe
FROM 
    Sponsor s
JOIN 
    Spende sp ON s.SponID = sp.SponID
WHERE 
    sp.AnlaID IS NOT NULL
GROUP BY 
    s.SponID, s.Name
ORDER BY 
    Unterstützte_Anlässe DESC, s.Name;
```

## Szenario 4: Funktionsbesetzung im Verein

### Aufgabe: Funktionsträger erfassen

Eine Person übernimmt eine neue Funktion im Verein:

```sql
-- Neue Funktionsbesetzung registrieren
INSERT INTO Funktionsbesetzung (
    FunkID, PersID, Antritt, Ruecktritt
)
VALUES (
    (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Kassier'),
    (SELECT PersID FROM Person WHERE Name = 'Huber' AND Vorname = 'Peter'),
    '2025-01-01',  -- Antritt
    NULL  -- Noch kein Rücktritt
);
```

### Aufgabe: Rücktritt registrieren

Ein Funktionsträger tritt zurück:

```sql
-- Rücktritt eines Funktionsträgers erfassen
UPDATE Funktionsbesetzung
SET Ruecktritt = '2025-12-31'
WHERE 
    FunkID = (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Präsident')
    AND PersID = (SELECT PersID FROM Person WHERE Name = 'Vogel' AND Vorname = 'Anna')
    AND Ruecktritt IS NULL;
```

### Aufgabe: Aktuelle Vereinsleitung anzeigen

Für die Webseite wird eine Liste der aktuellen Funktionsträger benötigt:

```sql
-- Aktuelle Funktionsträger
SELECT 
    f.Bezeichner AS Funktion,
    p.Name,
    p.Vorname,
    fb.Antritt,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, fb.Antritt)) AS Jahre_im_Amt
FROM 
    Funktion f
JOIN 
    Funktionsbesetzung fb ON f.FunkID = fb.FunkID
JOIN 
    Person p ON fb.PersID = p.PersID
WHERE 
    fb.Ruecktritt IS NULL  -- Nur aktuelle Funktionsträger
ORDER BY 
    CASE 
        WHEN f.Bezeichner = 'Präsident' THEN 1
        WHEN f.Bezeichner = 'Vizepräsident' THEN 2
        WHEN f.Bezeichner = 'Kassier' THEN 3
        WHEN f.Bezeichner = 'Aktuar' THEN 4
        ELSE 5
    END,  -- Benutzerdefinierte Sortierung nach Wichtigkeit
    f.Bezeichner;
```

## Szenario 5: Datenanalyse und Reporting

### Aufgabe: Mitgliederentwicklung analysieren

Für die Vorstandssitzung wird ein Bericht über die Mitgliederentwicklung benötigt:

```sql
-- Eintritte pro Jahr
SELECT 
    EXTRACT(YEAR FROM Eintritt) AS Jahr,
    COUNT(*) AS Neue_Mitglieder
FROM 
    Person
WHERE 
    Eintritt IS NOT NULL
GROUP BY 
    EXTRACT(YEAR FROM Eintritt)
ORDER BY 
    Jahr;

-- Austritte pro Jahr
SELECT 
    EXTRACT(YEAR FROM Austritt) AS Jahr,
    COUNT(*) AS Ausgetretene_Mitglieder
FROM 
    Person
WHERE 
    Austritt IS NOT NULL
GROUP BY 
    EXTRACT(YEAR FROM Austritt)
ORDER BY 
    Jahr;

-- Netto-Entwicklung pro Jahr
SELECT 
    jahre.jahr,
    COALESCE(eintritte.anzahl, 0) AS Eintritte,
    COALESCE(austritte.anzahl, 0) AS Austritte,
    COALESCE(eintritte.anzahl, 0) - COALESCE(austritte.anzahl, 0) AS Netto
FROM 
    (SELECT DISTINCT EXTRACT(YEAR FROM Eintritt) AS jahr FROM Person
     UNION
     SELECT DISTINCT EXTRACT(YEAR FROM Austritt) AS jahr FROM Person WHERE Austritt IS NOT NULL) jahre
LEFT JOIN 
    (SELECT EXTRACT(YEAR FROM Eintritt) AS jahr, COUNT(*) AS anzahl FROM Person GROUP BY EXTRACT(YEAR FROM Eintritt)) eintritte
    ON jahre.jahr = eintritte.jahr
LEFT JOIN 
    (SELECT EXTRACT(YEAR FROM Austritt) AS jahr, COUNT(*) AS anzahl FROM Person WHERE Austritt IS NOT NULL GROUP BY EXTRACT(YEAR FROM Austritt)) austritte
    ON jahre.jahr = austritte.jahr
ORDER BY 
    jahre.jahr;
```

### Aufgabe: Anlässe nach Beliebtheit analysieren

Um künftige Veranstaltungen besser zu planen:

```sql
-- Anlässe nach Teilnehmerzahl
SELECT 
    a.Bezeichner AS Anlass,
    a.Datum,
    COUNT(t.PersID) AS Teilnehmer,
    a.Kosten,
    CASE WHEN COUNT(t.PersID) > 0 THEN ROUND(a.Kosten / COUNT(t.PersID), 2) ELSE NULL END AS Kosten_pro_Teilnehmer
FROM 
    Anlass a
LEFT JOIN 
    Teilnehmer t ON a.AnlaID = t.AnlaID
GROUP BY 
    a.AnlaID, a.Bezeichner, a.Datum, a.Kosten
ORDER BY 
    a.Datum DESC;
```

## Zusammenfassung

In diesem Kapitel hast du gesehen, wie die SQL-Grundlagen in der Praxis angewendet werden, um typische Aufgaben in der Vereinsverwaltung zu lösen:

- Mitgliederverwaltung: Erfassung, Übersicht, Zahlungsverfolgung
- Veranstaltungsmanagement: Planung, Teilnehmerverwaltung, Statistik
- Sponsorenverwaltung: Erfassung, Spendenbuchhaltung, Auswertung
- Funktionsbesetzung: Zuweisung, Rücktritt, Übersicht
- Datenanalyse: Mitgliederentwicklung, Veranstaltungsauswertung

Diese Beispiele zeigen, wie die verschiedenen SQL-Befehle (SELECT, INSERT, UPDATE, DELETE) zusammenspielen, um reale Geschäftsprozesse abzubilden. Du hast auch gesehen, wie wichtig es ist, zusammengehörige Operationen in Transaktionen zusammenzufassen, um die Datenintegrität zu wahren.

In der Praxis würden viele dieser Operationen über eine Anwendungsoberfläche ausgeführt werden, aber ein Verständnis der zugrundeliegenden SQL-Befehle ist entscheidend für die Entwicklung und Wartung solcher Anwendungen.
