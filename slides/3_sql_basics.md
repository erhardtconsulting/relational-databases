---
theme: hftm
footer: 'SQL-Grundlagen'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>SQL-Grundlagen</h1>
  <p class="date-author">März 2025 | Autor: Simon Erhardt</p>
</div>

---
# Inhaltsverzeichnis
<!--
- Übersicht zum Ablauf der Vorlesung
- Diese Folien dienen als Einstieg für die praktischen Übungen
-->
1. SQL – Wozu brauchen wir es?
2. Datentypen in PostgreSQL
3. Daten abfragen mit SELECT
4. Daten filtern und sortieren
5. Aggregatfunktionen und Gruppierung
6. Datenmanipulation: INSERT, UPDATE, DELETE
7. Transaktionen in der Praxis
8. Übungsaufgaben und Praxisbeispiele
9. Zusammenfassung

---
# Warum benötigen wir SQL?
<!--
- Motivation und Relevanz betonen
- Praktische Bedeutung hervorheben
-->
- SQL = Structured Query Language (sprich: "Es-Ku-El" oder "Sequel")
- Seit den 1970er Jahren der Standard für relationale Datenbanken
- Deklarative Sprache: Du sagst WAS, nicht WIE
- Unabhängig vom Datenbanksystem (mit dialektspezifischen Unterschieden)
- Für 90% aller Datenbankoperationen unersetzlich:
  - Daten speichern, abrufen, ändern und analysieren
  - Grundlage fast jeder Business-Anwendung
  - Von der Vereinsverwaltung bis zur Banktransaktion
  - Optimiert für strukturierte Daten mit Beziehungen

---
# SQL im Kontext unserer Verein-Datenbank
<!--
- Konkreten Anwendungsfall zeigen
- ER-Diagramm oder Tabellenstruktur skizzieren
-->
![](img/er-diagram-verein.svg)
- Beispielanwendung: Vereinsverwaltung mit Mitgliedern, Funktionen, Anlässen und Sponsoren
- Ermöglicht das Speichern, Abfragen und Analysieren aller Vereinsdaten
- Grundlage für typische Operationen: Mitgliederverwaltung, Anlässe planen, Finanzen verwalten

---
# Datentypen: Die Grundbausteine (1)
<!--
- Grundlegende Datentypen erklären
- Typische Anwendungsfälle nennen
-->
- **Zeichenketten**
  - `CHAR(n)`: Feste Länge, z.B. `PLZ CHAR(4)` für Schweizer PLZ
  - `VARCHAR(n)`: Variable Länge, z.B. `Name VARCHAR(20)`
  - `TEXT`: Unbegrenzte Länge, z.B. für Beschreibungen

- **Numerische Typen**
  - `INTEGER`: Ganzzahlen, z.B. für Zählungen
  - `NUMERIC(p,s)`: Dezimalzahlen, z.B. `Beitrag NUMERIC(10,2)` für Geldbeträge

---
# Datentypen: Die Grundbausteine (2)
- **Datum und Zeit**
  - `DATE`: Nur Datum, z.B. `Eintritt DATE`
  - `TIME`: Nur Uhrzeit
  - `TIMESTAMP`: Datum und Uhrzeit

- **Andere wichtige Typen**
  - `BOOLEAN`: Ja/Nein-Werte
  - `UUID`: Universelle eindeutige IDs

---
# Datentypen: Best Practices
<!--
- Praktische Tipps zur Auswahl der richtigen Datentypen
- Performance-Aspekte kurz erwähnen
-->
- **Wähle passende Datentypen für optimale Performance und Integrität**
  - Für Primärschlüssel: UUID oder SERIAL/IDENTITY
  - Für Geldbeträge: NUMERIC(p,2) statt FLOAT (Rundungsprobleme!)
  - Für feste Zeichenlängen: CHAR statt VARCHAR
  - Für Namen und Texte: VARCHAR mit realistischer Längenbegrenzung

- **Warum ist die richtige Wahl wichtig?**
  - Datenintegrität: Unzulässige Werte werden abgewiesen
  - Speichereffizienz: Passende Typen sparen Platz
  - Performance: Optimierte Zugriffsmethoden je nach Datentyp
  - Funktionalität: Typenspezifische Operationen und Funktionen

---
# SELECT: Daten abfragen
<!--
- Die wichtigsten Komponenten einer SELECT-Anweisung
- Einfache Beispiele
-->
## Grundstruktur einer SELECT-Anweisung

```sql
SELECT [DISTINCT] spalten           -- Was soll angezeigt werden?
FROM tabelle                        -- Woher kommen die Daten?
[WHERE bedingung]                   -- Welche Zeilen?
[GROUP BY spalten]                  -- Wie gruppieren?
[HAVING gruppenbedingung]           -- Welche Gruppen?
[ORDER BY spalten [ASC|DESC]]       -- Wie sortieren?
[LIMIT anzahl [OFFSET start]];      -- Wie viele Zeilen?
```

---
## Einfache Beispiele
```sql
-- Alle Spalten aller Personen
SELECT * FROM Person;

-- Nur bestimmte Spalten
SELECT Name, Vorname, Ort FROM Person;

-- Mit Spaltenalias
SELECT Name AS Nachname, Vorname AS Rufname FROM Person;
```

---
# Daten filtern mit WHERE (2)
<!--
- Verschiedene Filterkriterien zeigen
- Logische Operatoren erklären
-->
```sql
-- Einfache Gleichheit
SELECT Name, Vorname FROM Person WHERE Ort = 'Bern';

-- Numerischer Vergleich
SELECT Name, Vorname FROM Person WHERE Eintritt >= '2020-01-01';
```

---
# Daten filtern mit WHERE (2)

```sql
-- Mehrere Bedingungen kombinieren
SELECT Name, Vorname FROM Person 
WHERE Ort = 'Zürich' AND Austritt IS NULL;

-- Alternativbedingungen
SELECT Name, Vorname FROM Person 
WHERE Ort = 'Bern' OR Ort = 'Zürich';

-- Textmuster mit LIKE
SELECT Name, Vorname FROM Person WHERE Name LIKE 'M%';
```
<br>

**Wichtigste Operatoren**: `=`, `<>`, `<`, `>`, `<=`, `>=`, `LIKE`, `IS NULL`, `IN`  
**Logische Verknüpfungen**: `AND`, `OR`, `NOT`

---
# Ergebnisse sortieren und begrenzen (1)
<!--
- ORDER BY, LIMIT und OFFSET erklären
- Praxisrelevante Beispiele
-->
## Sortierung mit ORDER BY
```sql
-- Aufsteigende Sortierung (Standard)
SELECT Name, Vorname FROM Person ORDER BY Name;

-- Absteigende Sortierung
SELECT Name, Vorname, Eintritt FROM Person ORDER BY Eintritt DESC;

-- Mehrere Sortierkriterien
SELECT Name, Vorname, Ort FROM Person ORDER BY Ort, Name;
```

---
# Ergebnisse sortieren und begrenzen (2)

## Begrenzung mit LIMIT
```sql
-- Nur die ersten 5 Zeilen
SELECT Name, Vorname FROM Person LIMIT 5;

-- Zeilen 11-15 (für Paginierung)
SELECT Name, Vorname FROM Person ORDER BY Name LIMIT 5 OFFSET 10;
```

---
# Daten aggregieren und gruppieren (1)
<!--
- Aggregatfunktionen und GROUP BY erklären
- Unterschied zwischen WHERE und HAVING erläutern
-->
## Aggregatfunktionen
```sql
-- Anzahl Personen
SELECT COUNT(*) AS Anzahl FROM Person;

-- Statistiken über Beiträge
SELECT 
    MIN(Beitrag) AS Minimum,
    MAX(Beitrag) AS Maximum,
    AVG(Beitrag) AS Durchschnitt,
    SUM(Beitrag) AS Gesamtsumme
FROM Status;
```

---
# Daten aggregieren und gruppieren (2)

## Gruppierung mit GROUP BY
```sql
-- Anzahl Personen pro Ort
SELECT Ort, COUNT(*) AS Anzahl 
FROM Person 
GROUP BY Ort
ORDER BY Anzahl DESC;
```

## Gruppen filtern mit HAVING
```sql
-- Nur Orte mit mehr als 5 Personen
SELECT Ort, COUNT(*) AS Anzahl 
FROM Person 
GROUP BY Ort
HAVING COUNT(*) > 5
ORDER BY Anzahl DESC;
```

---
# Daten einfügen mit INSERT
<!--
- Verschiedene INSERT-Varianten
- Praktische Beispiele
-->
## Einzelne Zeile einfügen
```sql
INSERT INTO Status (StatID, Bezeichner, Beitrag)
VALUES (gen_random_uuid(), 'Ehrenmitglied', 0);
```

## Mehrere Zeilen gleichzeitig einfügen
```sql
INSERT INTO Funktion (FunkID, Bezeichner)
VALUES 
    (gen_random_uuid(), 'Webmaster'),
    (gen_random_uuid(), 'Social Media'),
    (gen_random_uuid(), 'Event-Planer');
```

## Daten aus einer Abfrage einfügen
```sql
INSERT INTO Mailingliste (PersID, Email, Name, Vorname)
SELECT PersID, Email, Name, Vorname
FROM Person
WHERE Austritt IS NULL;
```

---
# Daten aktualisieren mit UPDATE (1)
<!--
- UPDATE-Syntax
- Wichtige Hinweise zur Verwendung von WHERE
-->
## Syntax und einfache Beispiele
```sql
-- Beitragserhöhung für eine Mitgliederkategorie
UPDATE Status
SET Beitrag = Beitrag * 1.05  -- 5% Erhöhung
WHERE Bezeichner = 'Aktivmitglied';

-- Mehrere Felder gleichzeitig aktualisieren
UPDATE Person
SET Strasse_Nr = 'Seeweg 10', 
    PLZ = '8000', 
    Ort = 'Zürich'
WHERE PersID = '123e4567-e89b-12d3-a456-426614174000';
```

- **WICHTIG**: Verwende immer WHERE-Klauseln, sonst werden **ALLE** Zeilen geändert!

---
# Daten aktualisieren mit UPDATE (2)


## Praxis-Tipp
Teste zuerst mit SELECT, welche Zeilen betroffen wären:
```sql
SELECT * FROM Status WHERE Bezeichner = 'Aktivmitglied';
```

---
# Daten löschen mit DELETE
<!--
- DELETE-Syntax
- Vorsichtsmassnahmen und Fallstricke
-->
## Syntax und einfache Beispiele
```sql
-- Einzelnen Anlass löschen
DELETE FROM Anlass
WHERE AnlaID = '123e4567-e89b-12d3-a456-426614174000';

-- Alte Anlässe löschen
DELETE FROM Anlass
WHERE Datum < CURRENT_DATE - INTERVAL '1 year';
```

**WICHTIG**:
- Verwende immer WHERE-Klauseln, sonst werden **ALLE** Zeilen gelöscht!
- Beachte Fremdschlüsselbeziehungen (Löschen kann fehlschlagen)
- Teste vorher mit SELECT, welche Zeilen betroffen wären

---
# Übungsaufgaben: Mitgliederverwaltung
<!--
- Kurzer Überblick über die praktischen Übungen
- Was erwartet die Studierenden?
-->
## Übungsstruktur: 5 praktische Aufgaben
1. **Mitgliederverwaltung**: Neue Mitglieder einfügen, Status verwalten
2. **Veranstaltungsmanagement**: Anlässe und Teilnehmer verwalten
3. **Sponsorenverwaltung**: Sponsoren und Spenden verwalten
4. **Funktionsbesetzung**: Funktionen zuweisen und auswerten
5. **Datenanalyse**: Komplexe Auswertungen und Berichte

---
# Zusammenfassung
<!--
- Hauptpunkte zusammenfassen
- Ausblick auf kommende Themen geben
-->
- SQL ist die Standardsprache für relationale Datenbanken
- Datentypen bilden das Fundament für strukturierte Datenspeicherung
- SELECT-Anweisungen erlauben vielfältige Datenabfragen
- Filterung, Sortierung und Gruppierung ermöglichen präzise Ergebnisse
- INSERT, UPDATE und DELETE manipulieren die gespeicherten Daten
- Transaktionen gewährleisten die Datenintegrität bei zusammenhängenden Operationen
