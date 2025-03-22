# Übung 3: SQL-Grundlagen für die Sponsorenverwaltung

## Lernziele
- Erfassung und Verwaltung von Sponsorendaten in einer relationalen Datenbank
- Dokumentation von Spenden und Aktualisierung von Spendentotalen
- Erstellung von aussagekräftigen Sponsorenauswertungen für Reporting-Zwecke

## Relevanz für die Praxis

Die Sponsorengewinnung und -pflege ist für viele Vereine und Non-Profit-Organisationen existenziell wichtig. Eine gut strukturierte Datenbank unterstützt dabei:

- Sponsoren können systematisch erfasst und verwaltet werden
- Spendeneingänge werden zuverlässig dokumentiert
- Sponsorenbeziehungen können durch Ansprechpersonen gepflegt werden
- Auswertungen helfen bei der strategischen Sponsorenentwicklung
- Jahresberichte und Sponsorenlisten können automatisiert erstellt werden

Die hier erlernten SQL-Techniken sind direkt übertragbar auf andere Bereiche des Spendenmanagements oder Customer Relationship Management (CRM) in kommerziellen Umgebungen.

## Theoretische Grundlagen

### Datenmodell Sponsorenverwaltung
In unserer Vereinsdatenbank werden Sponsoren und Spenden über folgende Tabellen verwaltet:
- `Sponsor`: Enthält Stammdaten der Sponsoren (Name, Adresse, Spendentotal)
- `Spende`: Dokumentiert einzelne Spendeneingänge mit Betrag und Datum
- `Anlass`: Verknüpft Spenden mit Veranstaltungen, falls zweckgebunden
- `Sponsorenkontakt`: Verknüpft Sponsoren mit internen Ansprechpersonen
- `Person`: Enthält Daten zu den internen Ansprechpersonen

### Schlüsselkonzepte
- **Transaktionen**: Sicherstellung der Datenintegrität bei zusammengehörenden Operationen
- **Aggregatfunktionen**: Zusammenfassung von Daten für Auswertungen (SUM, COUNT, MAX, MIN)
- **Referenzielle Integrität**: Korrekte Verknüpfung der Tabellen über Fremdschlüssel
- **Gruppierung und Sortierung**: Strukturierte Darstellung von Auswertungsergebnissen
- **DISTINCT und Unterabfragen**: Vermeidung von Duplikaten und komplexe Datenextraktion

## Praktische Übungen

### Aufgabe 1: Neuen Sponsor erfassen

Erfasse einen neuen Sponsor in der Datenbank und lege eine Ansprechperson fest.

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

**Übungsaufgabe**: Erfasse einen weiteren Sponsor deiner Wahl und weise ihm zwei verschiedene Ansprechpersonen zu.

### Aufgabe 2: Spendeneingänge verbuchen

Verbuche eine neue Spende und aktualisiere das Spendentotal des Sponsors.

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

**Übungsaufgabe**: Verbuche eine weitere Spende für einen bereits bestehenden Sponsor, diesmal ohne Zweckbindung an einen bestimmten Anlass (d.h. AnlaID = NULL).

### Aufgabe 3: Top-Sponsoren auswerten

Erstelle eine Auswertung der Sponsoren nach Gesamtspenden.

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
```

**Übungsaufgabe**: Modifiziere die Abfrage so, dass nur Sponsoren angezeigt werden, die im laufenden Jahr gespendet haben.

### Aufgabe 4: Auswertung nach unterstützten Anlässen

Erstelle eine Auswertung der Sponsoren nach Anzahl der unterstützten Anlässe.

```sql
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

**Übungsaufgabe**: Erweitere die Abfrage, sodass zusätzlich die Namen der unterstützten Anlässe als kommaseparierte Liste angezeigt werden. Hinweis: In PostgreSQL kannst du dafür die `string_agg`-Funktion verwenden.

## Herausforderungen und Erweiterungen

### Herausforderung 1: Mehrjahresverträge
Viele Sponsorenbeziehungen basieren auf Mehrjahresverträgen. Entwickle ein Konzept, wie solche Verträge in der Datenbank abgebildet werden könnten, inklusive:
1. Automatische Spendeneingänge zu festgelegten Zeitpunkten
2. Erinnerungsfunktion für auslaufende Verträge
3. Historisierung und Verlängerungsmanagement

### Herausforderung 2: Sponsorenkategorien
Entwirf ein System, das Sponsoren in verschiedene Kategorien einteilt (z.B. Bronze, Silber, Gold) basierend auf ihrem Spendentotal. Überlege:
1. Wie können die Kategoriegrenzen flexibel definiert werden?
2. Wie können Sponsoren automatisch hoch- oder zurückgestuft werden?
3. Welche zusätzlichen Benefits könnten pro Kategorie in der Datenbank erfasst werden?

### Herausforderung 3: Fundraising-Kampagnen
Die Vereinsleitung möchte gezielte Fundraising-Kampagnen durchführen. Entwickle ein Datenbankkonzept, das unterstützt:
1. Kampagnen mit Zielbetrag und Zeitraum erfassen
2. Zuordnung von Spenden zu Kampagnen
3. Fortschrittsberichte zur Zielerreichung generieren
4. Zielgruppenanalyse für künftige Kampagnen

### Erweiterung: Sponsorenmailing
Überlege, wie du mithilfe der Datenbank ein Sponsorenmailing umsetzen könntest, das personalisierte Informationen enthält wie:
1. Bisherige Spendenhistorie des Sponsors
2. Unterstützte Projekte und deren Erfolge
3. Passende Vorschläge für künftige Unterstützungsmöglichkeiten

Welche zusätzlichen Daten und Abfragen wären dafür notwendig?

## Reflexion

- Warum ist die Verwendung von Transaktionen bei der Verbuchung von Spenden besonders wichtig?
- Inwiefern hilft eine strukturierte Sponsorendatenbank bei der strategischen Entwicklung des Vereins?
- Welche Datenschutzaspekte müssen bei der Speicherung und Verarbeitung von Sponsorendaten beachtet werden?
- Wie könnten Datenbank-Triggers eingesetzt werden, um die Konsistenz zwischen Einzelspenden und Spendentotal zu gewährleisten?
