# Daten abfragen mit SELECT

## Warum sind Abfragen so wichtig?

Daten in einer Datenbank zu speichern ist nur der erste Schritt – der wahre Wert liegt darin, diese Daten wieder abzurufen und zu analysieren. Die SELECT-Anweisung ist das Herzstück von SQL und ermöglicht es dir:

- Genau die Informationen zu erhalten, die du benötigst
- Daten nach bestimmten Kriterien zu filtern
- Ergebnisse in einer sinnvollen Reihenfolge zu präsentieren
- Berechnungen und Transformationen durchzuführen
- Daten zu gruppieren und zu aggregieren
- Erkenntnisse aus grossen Datenmengen zu gewinnen

Ob du eine einfache Liste von Vereinsmitgliedern abrufen oder komplexe statistische Auswertungen durchführen möchtest – die SELECT-Anweisung ist dein wichtigstes Werkzeug.

## Grundstruktur einer SELECT-Anweisung

Eine vollständige SELECT-Anweisung kann sehr komplex sein, aber die Grundstruktur lässt sich in folgende Komponenten unterteilen:

```sql
SELECT [DISTINCT] spaltenliste           -- Welche Spalten sollen angezeigt werden?
FROM tabelle                             -- Aus welcher Tabelle?
[WHERE bedingung]                        -- Welche Zeilen sollen gefiltert werden?
[GROUP BY gruppierungsspalten]           -- Wie sollen die Daten gruppiert werden?
[HAVING gruppierungsbedingung]           -- Welche Gruppen sollen gefiltert werden?
[ORDER BY sortierspalten [ASC|DESC]]     -- Wie sollen die Ergebnisse sortiert werden?
[LIMIT anzahl [OFFSET startposition]];   -- Wie viele Ergebnisse sollen angezeigt werden?
```

Die eckigen Klammern kennzeichnen optionale Komponenten. Nur die Teile `SELECT` und `FROM` sind obligatorisch.

## Einfache SELECT-Anweisungen

Die grundlegendste Form einer Abfrage wählt alle Spalten aus einer Tabelle aus:

```sql
-- Alle Spalten und alle Zeilen aus der Tabelle 'Person' auswählen
SELECT * FROM Person;
```

Das Sternchen `*` ist ein Platzhalter für "alle Spalten". In der Praxis ist es jedoch oft besser, nur die benötigten Spalten explizit anzugeben:

```sql
-- Nur Namen und Vornamen aller Personen auswählen
SELECT Name, Vorname FROM Person;
```

Dies verbessert die Lesbarkeit, reduziert die Datenmenge und kann die Abfragegeschwindigkeit erhöhen.

### Spaltenaliase

Du kannst Spalten in den Ergebnissen umbenennen, indem du Aliase verwendest:

```sql
-- Spalten mit benutzerfreundlicheren Namen anzeigen
SELECT 
    Name AS Nachname,
    Vorname AS Rufname
FROM Person;
```

In den Ergebnissen erscheinen die Spalten nun als "Nachname" und "Rufname", was besonders nützlich ist, wenn du die Ergebnisse an eine Anwendung weitergibst oder für Berichte verwendest.

## Filtern mit WHERE

Die meisten Abfragen müssen die Ergebnisse auf bestimmte Zeilen beschränken. Die WHERE-Klausel erlaubt es dir, Bedingungen zu definieren, die jede zurückgegebene Zeile erfüllen muss:

```sql
-- Alle aktiven Personen auswählen (ohne Austrittsdatum)
SELECT Name, Vorname, Eintritt 
FROM Person
WHERE Austritt IS NULL;

-- Alle Personen, die nach dem 1.1.2020 eingetreten sind
SELECT Name, Vorname, Eintritt 
FROM Person
WHERE Eintritt >= '2020-01-01';
```

### Vergleichsoperatoren in WHERE

Die häufigsten Vergleichsoperatoren sind:

- `=` (gleich)
- `<>` oder `!=` (ungleich)
- `<` (kleiner als)
- `>` (grösser als)
- `<=` (kleiner oder gleich)
- `>=` (grösser oder gleich)
- `IS NULL` (ist nicht gesetzt)
- `IS NOT NULL` (ist gesetzt)

### Logische Operatoren in WHERE

Mit logischen Operatoren kannst du mehrere Bedingungen kombinieren:

```sql
-- Personen aus Bern, die 2020 eingetreten sind
SELECT Name, Vorname, Eintritt, Ort
FROM Person
WHERE Ort = 'Bern' AND Eintritt >= '2020-01-01' AND Eintritt < '2021-01-01';

-- Personen aus Bern oder Zürich
SELECT Name, Vorname, Ort
FROM Person
WHERE Ort = 'Bern' OR Ort = 'Zürich';

-- Alle Personen ausser denen aus Bern
SELECT Name, Vorname, Ort
FROM Person
WHERE NOT Ort = 'Bern';  -- alternativ: WHERE Ort <> 'Bern'
```

Die logischen Operatoren sind:
- `AND` (beide Bedingungen müssen erfüllt sein)
- `OR` (mindestens eine Bedingung muss erfüllt sein)
- `NOT` (die Bedingung darf nicht erfüllt sein)

### Mustervergleich mit LIKE

Für Textsuchen kannst du den LIKE-Operator verwenden:

```sql
-- Alle Personen, deren Name mit 'M' beginnt
SELECT Name, Vorname
FROM Person
WHERE Name LIKE 'M%';

-- Alle Personen mit 'er' irgendwo im Namen
SELECT Name, Vorname
FROM Person
WHERE Name LIKE '%er%';
```

Die Platzhalter sind:
- `%` für beliebig viele (auch keine) Zeichen
- `_` für genau ein Zeichen

## Ergebnisse sortieren mit ORDER BY

Mit der ORDER BY-Klausel kannst du die Reihenfolge der Ergebnisse festlegen:

```sql
-- Personen alphabetisch nach Namen sortieren
SELECT Name, Vorname, Eintritt
FROM Person
ORDER BY Name;

-- Personen nach Eintrittsdatum absteigend sortieren (neueste zuerst)
SELECT Name, Vorname, Eintritt
FROM Person
ORDER BY Eintritt DESC;

-- Personen nach Ort und innerhalb des Ortes nach Namen sortieren
SELECT Name, Vorname, Ort
FROM Person
ORDER BY Ort, Name;
```

Du kannst jeweils `ASC` (aufsteigend, Standard) oder `DESC` (absteigend) angeben und nach mehreren Spalten sortieren.

## Ergebnisse begrenzen mit LIMIT

Wenn du nur eine bestimmte Anzahl von Zeilen zurückgeben möchtest, kannst du LIMIT verwenden:

```sql
-- Die 5 neuesten Mitglieder
SELECT Name, Vorname, Eintritt
FROM Person
ORDER BY Eintritt DESC
LIMIT 5;
```

Mit OFFSET kannst du auch einen Startpunkt festlegen, was für Paginierung nützlich ist:

```sql
-- Zeige Personen 11-20 in der alphabetischen Reihenfolge
SELECT Name, Vorname
FROM Person
ORDER BY Name, Vorname
LIMIT 10 OFFSET 10;  -- Überspringe die ersten 10, zeige die nächsten 10
```

## Aggregatfunktionen

SQL bietet verschiedene Funktionen, um Berechnungen auf Datengruppen durchzuführen:

- `COUNT()`: Zählt die Anzahl der Zeilen oder Werte
- `SUM()`: Berechnet die Summe von Werten
- `AVG()`: Berechnet den Durchschnitt von Werten
- `MIN()`: Findet den kleinsten Wert
- `MAX()`: Findet den grössten Wert

### Einfache Aggregationen

```sql
-- Gesamtzahl der Personen in der Datenbank
SELECT COUNT(*) AS Anzahl_Personen
FROM Person;

-- Höchster, niedrigster und durchschnittlicher Mitgliedsbeitrag
SELECT 
    MIN(Beitrag) AS Min_Beitrag,
    MAX(Beitrag) AS Max_Beitrag,
    AVG(Beitrag) AS Durchschnitt_Beitrag
FROM Status;

-- Summe aller Spenden
SELECT SUM(Betrag) AS Gesamtspenden
FROM Spende;
```

Diese Funktionen reduzieren eine ganze Spalte auf einen einzelnen Wert.

## Daten gruppieren mit GROUP BY

Mit GROUP BY kannst du Zeilen nach bestimmten Kriterien gruppieren und dann Aggregatfunktionen auf jede Gruppe anwenden:

```sql
-- Anzahl der Personen pro Ort
SELECT Ort, COUNT(*) AS Anzahl
FROM Person
GROUP BY Ort
ORDER BY Anzahl DESC;

-- Durchschnittliche Spende pro Sponsor
SELECT SponID, AVG(Betrag) AS Durchschnittsbetrag
FROM Spende
GROUP BY SponID
ORDER BY Durchschnittsbetrag DESC;
```

### Gruppierte Daten filtern mit HAVING

Während WHERE vor der Gruppierung filtert, erlaubt HAVING die Filterung auf Basis von Aggregatfunktionen nach der Gruppierung:

```sql
-- Orte mit mehr als 5 Mitgliedern
SELECT Ort, COUNT(*) AS Anzahl
FROM Person
GROUP BY Ort
HAVING COUNT(*) > 5
ORDER BY Anzahl DESC;

-- Sponsoren mit Gesamtspenden über 1000 CHF
SELECT SponID, SUM(Betrag) AS Gesamtspende
FROM Spende
GROUP BY SponID
HAVING SUM(Betrag) > 1000
ORDER BY Gesamtspende DESC;
```

Der Unterschied zwischen WHERE und HAVING ist wichtig:
- **WHERE**: Filtert einzelne Zeilen vor der Gruppierung
- **HAVING**: Filtert Gruppen nach der Aggregation

## Datum- und Zeit-Funktionen

SQL bietet verschiedene Funktionen zur Arbeit mit Datums- und Zeitwerten:

```sql
-- Personen, die im Jahr 2020 eingetreten sind
SELECT Name, Vorname, Eintritt
FROM Person
WHERE EXTRACT(YEAR FROM Eintritt) = 2020;

-- Anzahl der Eintritte pro Monat
SELECT 
    EXTRACT(MONTH FROM Eintritt) AS Monat,
    COUNT(*) AS Anzahl
FROM Person
WHERE Eintritt IS NOT NULL
GROUP BY EXTRACT(MONTH FROM Eintritt)
ORDER BY Monat;
```

### Die Funktion TO_DATE

Mit `TO_DATE` (in PostgreSQL) kannst du Zeichenketten in Datumswerte umwandeln:

```sql
-- Alle Eintritte nach dem 15. März 2020
SELECT Name, Vorname, Eintritt
FROM Person
WHERE Eintritt > TO_DATE('15.03.2020', 'DD.MM.YYYY');
```

Der zweite Parameter gibt das Format an, in dem das Datum in der Zeichenkette vorliegt.

## Praktische Beispiele mit der Verein-Datenbank

Hier sind einige komplexere Beispiele, die verschiedene SELECT-Funktionen kombinieren:

```sql
-- Anzahl der Personen pro Status mit Statusbezeichnung
SELECT 
    s.Bezeichner AS Status,
    COUNT(p.PersID) AS Anzahl
FROM Person p
JOIN Status s ON p.StatID = s.StatID
GROUP BY s.StatID, s.Bezeichner
ORDER BY Anzahl DESC;

-- Durchschnittliche Anzahl Teilnehmer pro Anlass
SELECT 
    AVG(teilnehmer_count) AS Durchschnitt_Teilnehmer
FROM (
    SELECT 
        a.AnlaID,
        COUNT(t.PersID) AS teilnehmer_count
    FROM Anlass a
    LEFT JOIN Teilnehmer t ON a.AnlaID = t.AnlaID
    GROUP BY a.AnlaID
) AS anlass_stats;
```

## Zusammenfassung

Die SELECT-Anweisung ist das vielseitigste Werkzeug in SQL und erlaubt es dir, genau die Daten zu extrahieren, die du benötigst. Durch die Kombination von Filterung (WHERE), Sortierung (ORDER BY), Begrenzung (LIMIT), Aggregation und Gruppierung (GROUP BY, HAVING) kannst du selbst komplexe Analysen durchführen.

In diesem Kapitel haben wir die grundlegenden Möglichkeiten von SELECT kennengelernt. In späteren Kapiteln werden wir fortgeschrittenere Techniken wie Joins (Verknüpfung mehrerer Tabellen) und Unterabfragen behandeln, die die Mächtigkeit von SQL noch weiter erhöhen.
