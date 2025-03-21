# Daten verändern

## Warum ist sichere Datenmanipulation wichtig?

Das Abfragen von Daten ist nur eine Seite der Datenbankarbeit – ebenso wichtig ist die Fähigkeit, Daten in der Datenbank zu verändern. Dabei geht es um drei grundlegende Operationen:

- **Einfügen** neuer Datensätze (INSERT)
- **Aktualisieren** bestehender Datensätze (UPDATE)
- **Löschen** nicht mehr benötigter Datensätze (DELETE)

Diese Operationen werden oft als "DML" (Data Manipulation Language) bezeichnet und bilden das Fundament für jede Anwendung, die mit einer Datenbank interagiert.

Eine sorgfältige und präzise Datenmanipulation ist entscheidend, denn:

- Einmal gelöschte Daten sind möglicherweise unwiederbringlich verloren
- Fehlerhafte Aktualisierungen können die Datenintegrität gefährden
- Inkonsistente Einfügungen können Geschäftsregeln verletzen
- Unachtsame Änderungsoperationen können sich auf viele abhängige Datensätze auswirken

In diesem Kapitel lernst du, wie du diese Operationen sicher und effektiv einsetzen kannst.

## INSERT: Neue Datensätze einfügen

Der INSERT-Befehl fügt neue Zeilen in eine Tabelle ein. Es gibt zwei Hauptsyntaxvarianten:

### Einzelnen Datensatz einfügen

```sql
INSERT INTO tabellenname (spalte1, spalte2, ...) 
VALUES (wert1, wert2, ...);
```

Beispiel aus der Verein-Datenbank:

```sql
-- Einen neuen Status "Ehrenmitglied" einfügen
INSERT INTO Status (StatID, Bezeichner, Beitrag)
VALUES ('8f7d8f68-7562-4cf0-94b1-685c8540122a', 'Ehrenmitglied', 0);
```

Dabei gilt:
- Du musst für jeden `NOT NULL`-Wert ohne Standardwert einen Wert angeben
- Die Reihenfolge der Spalten in der Spaltenliste muss mit der Reihenfolge der Werte übereinstimmen
- Spalten, die nicht angegeben werden, erhalten ihren Standardwert oder NULL

### Mehrere Datensätze gleichzeitig einfügen

Du kannst auch mehrere Datensätze mit einem einzigen INSERT-Befehl einfügen:

```sql
INSERT INTO tabellenname (spalte1, spalte2, ...)
VALUES 
    (wert1_1, wert1_2, ...),
    (wert2_1, wert2_2, ...),
    (wert3_1, wert3_2, ...);
```

Beispiel:

```sql
-- Mehrere Funktionen auf einmal einfügen
INSERT INTO Funktion (FunkID, Bezeichner)
VALUES 
    ('a1b2c3d4-e5f6-a7b8-c9d0-123456789abc', 'Webmaster'),
    ('b2c3d4e5-f6a7-b8c9-d0e1-234567890abc', 'Social Media'),
    ('c3d4e5f6-a7b8-c9d0-e1f2-345678901abc', 'Event-Planer');
```

### Daten aus einer Abfrage einfügen

Eine besonders nützliche Variante ist das Einfügen von Daten, die aus einer SELECT-Abfrage stammen:

```sql
INSERT INTO zieltabelle (spalte1, spalte2, ...)
SELECT spalteA, spalteB, ...
FROM quelltabelle
WHERE bedingung;
```

Beispiel:

```sql
-- Kopiere alle aktiven Mitglieder in eine temporäre Tabelle für eine Mailingaktion
INSERT INTO Mailingliste (PersID, Email, Name, Vorname)
SELECT PersID, Email, Name, Vorname
FROM Person
WHERE Austritt IS NULL;
```

Diese Methode ist sehr leistungsfähig für Datenmigrationen, das Erstellen von Zusammenfassungstabellen oder das Kopieren von Daten zwischen Tabellen.

### Umgang mit Identifikatoren

Bei UUIDs ist zu beachten, dass du diese selbst generieren musst. In PostgreSQL kannst du dafür die `gen_random_uuid()` Funktion verwenden:

```sql
INSERT INTO Funktion (FunkID, Bezeichner)
VALUES (gen_random_uuid(), 'Revisor');
```

Bei Tabellen mit SERIAL/IDENTITY-Spalten kannst du diese Spalte weglassen oder NULL angeben, und der Wert wird automatisch generiert:

```sql
-- Angenommen, AnlaID wäre eine SERIAL-Spalte
INSERT INTO Anlass (Bezeichner, Ort, Datum, OrgID)
VALUES ('Sommerfest', 'Stadtpark', '2025-07-15', '123e4567-e89b-12d3-a456-426614174000');
```

## UPDATE: Bestehende Datensätze aktualisieren

Der UPDATE-Befehl ändert Werte in bereits existierenden Datensätzen:

```sql
UPDATE tabellenname
SET spalte1 = wert1, spalte2 = wert2, ...
WHERE bedingung;
```

Beispiele:

```sql
-- Den Mitgliedsbeitrag für Aktivmitglieder erhöhen
UPDATE Status
SET Beitrag = Beitrag * 1.05  -- 5% Erhöhung
WHERE Bezeichner = 'Aktivmitglied';

-- Adressaktualisierung einer bestimmten Person
UPDATE Person
SET Strasse_Nr = 'Musterweg 42', PLZ = '3000', Ort = 'Bern'
WHERE PersID = '123e4567-e89b-12d3-a456-426614174000';
```

### Wichtig: Verwende immer WHERE

Wenn du die WHERE-Klausel weglässt, wird der UPDATE auf **alle** Zeilen in der Tabelle angewendet! Dies kann zu schwerwiegenden Datenverlusten führen.

```sql
-- GEFÄHRLICH: Setzt den Beitrag für ALLE Status auf 100!
UPDATE Status
SET Beitrag = 100;
```

Es ist daher gute Praxis, UPDATE-Befehle zuerst mit einer entsprechenden SELECT-Abfrage zu testen, um sicherzustellen, dass nur die gewünschten Zeilen betroffen sind:

```sql
-- Teste zuerst, welche Zeilen betroffen wären:
SELECT *
FROM Status
WHERE Bezeichner = 'Aktivmitglied';

-- Dann führe den Update durch, wenn das Ergebnis stimmt:
UPDATE Status
SET Beitrag = Beitrag * 1.05
WHERE Bezeichner = 'Aktivmitglied';
```

### UPDATE mit Werten aus anderen Tabellen

Du kannst auch Werte aus anderen Tabellen verwenden, um Aktualisierungen durchzuführen:

```sql
-- Aktualisiere die Spendentotal-Spalte in der Sponsor-Tabelle
-- basierend auf der Summe aller Spenden des Sponsors
UPDATE Sponsor s
SET Spendentotal = subquery.gesamtbetrag
FROM (
    SELECT SponID, SUM(Betrag) AS gesamtbetrag
    FROM Spende
    GROUP BY SponID
) AS subquery
WHERE s.SponID = subquery.SponID;
```

Diese Art von UPDATE ist besonders nützlich, um abgeleitete oder aggregierte Daten zu aktualisieren.

## DELETE: Datensätze löschen

Der DELETE-Befehl entfernt Zeilen aus einer Tabelle:

```sql
DELETE FROM tabellenname
WHERE bedingung;
```

Beispiele:

```sql
-- Lösche einen bestimmten Anlass
DELETE FROM Anlass
WHERE AnlaID = '123e4567-e89b-12d3-a456-426614174000';

-- Lösche alle vergangenen Anlässe
DELETE FROM Anlass
WHERE Datum < CURRENT_DATE;
```

### Wichtig: Verwende immer WHERE (auch hier!)

Wie beim UPDATE gilt: Ohne WHERE-Klausel werden **alle** Zeilen in der Tabelle gelöscht!

```sql
-- GEFÄHRLICH: Löscht ALLE Anlässe!
DELETE FROM Anlass;
```

Auch hier empfiehlt es sich, zuerst mit SELECT zu prüfen, welche Datensätze betroffen wären:

```sql
-- Teste zuerst, welche Zeilen gelöscht würden:
SELECT *
FROM Anlass
WHERE Datum < CURRENT_DATE;

-- Dann führe den DELETE durch, wenn das Ergebnis stimmt:
DELETE FROM Anlass
WHERE Datum < CURRENT_DATE;
```

### Fremdschlüsselbeziehungen beachten

Beim Löschen von Datensätzen musst du Fremdschlüsselbeziehungen berücksichtigen. Versuchst du, einen Datensatz zu löschen, auf den andere Tabellen über Fremdschlüssel verweisen, gibt es verschiedene Möglichkeiten:

1. Die Operation schlägt fehl (Standard)
2. Die abhängigen Datensätze werden ebenfalls gelöscht (CASCADE)
3. Die Fremdschlüssel werden auf NULL gesetzt (SET NULL)

Beispiel für eine Situation, in der das Löschen fehlschlägt:

```sql
-- Dieses Löschen würde fehlschlagen, wenn es Teilnehmer für diesen Anlass gibt
DELETE FROM Anlass
WHERE AnlaID = '123e4567-e89b-12d3-a456-426614174000';
```

In diesem Fall müsstest du zuerst die abhängigen Datensätze löschen:

```sql
-- Zuerst abhängige Datensätze löschen
DELETE FROM Teilnehmer
WHERE AnlaID = '123e4567-e89b-12d3-a456-426614174000';

-- Dann den Anlass selbst löschen
DELETE FROM Anlass
WHERE AnlaID = '123e4567-e89b-12d3-a456-426614174000';
```

## Transaktionen für sichere Datenmanipulation

Wenn du mehrere abhängige Änderungen durchführen musst, ist es wichtig, diese in einer Transaktion zusammenzufassen. Eine Transaktion stellt sicher, dass entweder alle Änderungen durchgeführt werden oder keine, falls ein Fehler auftritt.

```sql
-- Transaktion starten
BEGIN;

-- Beitrag erhöhen
UPDATE Status
SET Beitrag = Beitrag * 1.05
WHERE Bezeichner = 'Aktivmitglied';

-- Neue Notiz für alle betroffenen Mitglieder einfügen
INSERT INTO Mitteilung (PersID, Text, Datum)
SELECT p.PersID, 'Beitragserhöhung um 5% ab nächstem Jahr', CURRENT_DATE
FROM Person p
JOIN Status s ON p.StatID = s.StatID
WHERE s.Bezeichner = 'Aktivmitglied';

-- Wenn alles ok ist: Transaktion abschliessen
COMMIT;

-- Falls etwas schief geht: Änderungen rückgängig machen
-- ROLLBACK;
```

Mehr zu Transaktionen haben wir bereits im Kapitel "ACID und Transaktionen" behandelt.

## Kombination von DML-Befehlen in praktischen Szenarien

In der Praxis werden DML-Befehle oft in komplexen Szenarien kombiniert. Hier sind einige Beispiele:

### Szenario 1: Mitgliederstatus-Änderung

```sql
-- Transaktion starten
BEGIN;

-- Status für alle Mitglieder ändern, die seit mehr als 5 Jahren dabei sind
UPDATE Person
SET StatID = (SELECT StatID FROM Status WHERE Bezeichner = 'Ehrenmitglied')
WHERE Eintritt < CURRENT_DATE - INTERVAL '5 years'
AND StatID = (SELECT StatID FROM Status WHERE Bezeichner = 'Aktivmitglied');

-- Neue Einträge in der Funktionsbesetzung für die neuen Ehrenmitglieder
INSERT INTO Funktionsbesetzung (FunkID, PersID, Antritt)
SELECT 
    (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Ehrenrat'),
    PersID,
    CURRENT_DATE
FROM Person
WHERE StatID = (SELECT StatID FROM Status WHERE Bezeichner = 'Ehrenmitglied')
AND NOT EXISTS (
    SELECT 1 FROM Funktionsbesetzung 
    WHERE Funktionsbesetzung.PersID = Person.PersID
    AND Funktionsbesetzung.FunkID = (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Ehrenrat')
);

-- Transaktion abschliessen
COMMIT;
```

### Szenario 2: Archivierung alter Anlässe

```sql
-- Transaktion starten
BEGIN;

-- Zuerst alte Anlässe in Archivtabelle kopieren
INSERT INTO AnlassArchiv (AnlaID, Bezeichner, Ort, Datum, Kosten, OrgID)
SELECT AnlaID, Bezeichner, Ort, Datum, Kosten, OrgID
FROM Anlass
WHERE Datum < CURRENT_DATE - INTERVAL '1 year';

-- Dann Teilnehmer der archivierten Anlässe kopieren
INSERT INTO TeilnehmerArchiv (AnlaID, PersID)
SELECT t.AnlaID, t.PersID
FROM Teilnehmer t
JOIN Anlass a ON t.AnlaID = a.AnlaID
WHERE a.Datum < CURRENT_DATE - INTERVAL '1 year';

-- Nun die Originaldaten löschen (in umgekehrter Reihenfolge der Abhängigkeiten)
DELETE FROM Teilnehmer
WHERE AnlaID IN (
    SELECT AnlaID
    FROM Anlass
    WHERE Datum < CURRENT_DATE - INTERVAL '1 year'
);

DELETE FROM Anlass
WHERE Datum < CURRENT_DATE - INTERVAL '1 year';

-- Transaktion abschliessen
COMMIT;
```

## Best Practices für Datenmanipulation

Abschliessend einige wichtige Tipps für die sichere und effektive Arbeit mit DML-Befehlen:

1. **Teste immer zuerst mit SELECT**
   - Bevor du UPDATE oder DELETE ausführst, teste mit einer entsprechenden SELECT-Abfrage, welche Datensätze betroffen wären

2. **Verwende Transaktionen für zusammenhängende Änderungen**
   - Stelle sicher, dass komplexe Änderungen entweder vollständig oder gar nicht durchgeführt werden

3. **Achte auf Fremdschlüsselbeziehungen**
   - Berücksichtige die Auswirkungen auf abhängige Tabellen

4. **Setze spezifische WHERE-Klauseln ein**
   - Je präziser deine WHERE-Klausel, desto geringer das Risiko unbeabsichtigter Änderungen

5. **Validiere Eingabedaten**
   - Stelle sicher, dass Daten korrekt formatiert sind und Geschäftsregeln entsprechen

6. **Nutze Constraints in der Datenbank**
   - Lass die Datenbank selbst die Datenintegrität sicherstellen durch CHECK-Constraints, NOT NULL usw.

7. **Dokumentiere komplexe DML-Operationen**
   - Besonders bei komplexen Änderungen hilft eine klare Dokumentation dir und anderen, die Absicht zu verstehen

## Zusammenfassung

Die DML-Befehle INSERT, UPDATE und DELETE bilden das Rückgrat jeder Datenbankinteraktion, bei der Daten verändert werden. Mit diesen Befehlen kannst du:

- Neue Datensätze in die Datenbank einfügen (INSERT)
- Bestehende Datensätze aktualisieren (UPDATE)
- Nicht mehr benötigte Datensätze entfernen (DELETE)

Die sichere Verwendung dieser Befehle, insbesondere in Kombination mit Transaktionen, ist entscheidend für die Integrität deiner Daten.
