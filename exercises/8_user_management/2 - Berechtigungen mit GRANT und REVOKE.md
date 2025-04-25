---
title: "Benutzerverwaltung / Übung 2: Berechtigungen mit GRANT und REVOKE"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DCL
    - GRANT
    - REVOKE
    - Berechtigungen
---

# Übung 2: Berechtigungen mit GRANT und REVOKE

## Lernziele

In dieser Übung wirst du:
- Verschiedene Arten von Objektberechtigungen (SELECT, INSERT, UPDATE, DELETE) erteilen und entziehen
- Berechtigungen auf Schemaebene verwalten
- Das Prinzip der geringsten Berechtigung (Least Privilege) anwenden
- Die Option `WITH GRANT OPTION` kennenlernen und nutzen

## Aufgabenszenario

Du arbeitest weiterhin als Datenbankadministrator und sollst nun Berechtigungen für die bereits erstellten Benutzer und Rollen konfigurieren. Du nutzt dafür die `verein`-Datenbank (oder eine andere Testdatenbank, falls vorhanden).

## Vorbereitung

Erstelle zunächst die benötigten Benutzer und Rollen (falls noch nicht vorhanden):

```sql
-- Benutzer erstellen
CREATE USER app_user WITH PASSWORD 'app123';
CREATE USER reporting_user WITH PASSWORD 'report123';
CREATE USER admin_user WITH PASSWORD 'admin123';

-- Rollen erstellen
CREATE ROLE read_only NOLOGIN;
CREATE ROLE read_write NOLOGIN;
CREATE ROLE admin_role NOLOGIN;

-- Rollenhierarchie aufbauen
GRANT read_only TO read_write;
GRANT read_write TO admin_role;

-- Rollen den Benutzern zuweisen
GRANT read_only TO reporting_user;
GRANT read_write TO app_user;
GRANT admin_role TO admin_user;
```

## Teil 1: Grundlegende Berechtigungen

### Aufgabe 1.1: Leseberechtigungen
1. Erteile der Rolle `read_only` Leserechte (SELECT) auf die Tabellen `anlass`, `person` und `teilnehmer`.
2. Überprüfe, ob der Benutzer `reporting_user` diese Tabellen abfragen kann.
3. Versuche als `reporting_user`, Daten in diese Tabellen einzufügen (dies sollte fehlschlagen).

```sql
-- Beispiellösung für Aufgabe 1.1:
GRANT SELECT ON TABLE anlass, person, teilnehmer TO read_only;

-- Als reporting_user testen:
-- 1. Mit reporting_user verbinden
-- 2. Dann ausführen:
SELECT * FROM anlass LIMIT 5;
INSERT INTO anlass (Bezeichner, Datum) VALUES ('Test', CURRENT_DATE); -- Sollte fehlschlagen
```

### Aufgabe 1.2: Schreibberechtigungen
1. Erteile der Rolle `read_write` Einfüge- und Aktualisierungsrechte (INSERT, UPDATE) auf die Tabelle `teilnehmer`.
2. Behalte die Leseberechtigung für diese Rolle bei (sie sollte von `read_only` vererbt sein).
3. Teste als `app_user`, ob du Datensätze in `teilnehmer` einfügen und aktualisieren kannst.

```sql
-- Beispiel für Aufgabe 1.2:
GRANT INSERT, UPDATE ON TABLE teilnehmer TO read_write;

-- Als app_user testen:
INSERT INTO teilnehmer (AnlaID, PersID) 
VALUES (1, 1); -- IDs müssen existieren

UPDATE teilnehmer SET Bemerkung = 'Test' 
WHERE AnlaID = 1 AND PersID = 1;
```

## Teil 2: Berechtigungen auf Schemaebene

### Aufgabe 2.1: Schema-Berechtigungen
1. Gewähre der Rolle `read_only` Leserechte auf **alle** Tabellen im Schema `public`.
2. Teste als `reporting_user`, ob du auch nicht explizit genannte Tabellen wie `sponsor` und `spende` abfragen kannst.

```sql
-- Beispiellösung für Aufgabe 2.1:
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only;

-- Als reporting_user testen:
SELECT * FROM sponsor LIMIT 5;
SELECT * FROM spende LIMIT 5;
```

### Aufgabe 2.2: Zukünftige Tabellen
1. Gewähre der Rolle `read_only` Leserechte auf **zukünftige** Tabellen im Schema `public`.
2. Erstelle als `admin_user` eine neue Testtabelle.
3. Überprüfe als `reporting_user`, ob du die neue Tabelle abfragen kannst.

```sql
-- Beispiel für Aufgabe 2.2:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT SELECT ON TABLES TO read_only;

-- Als admin_user:
CREATE TABLE test_tabelle (id SERIAL PRIMARY KEY, beschreibung TEXT);
INSERT INTO test_tabelle (beschreibung) VALUES ('Test');

-- Als reporting_user:
SELECT * FROM test_tabelle;
```

## Teil 3: Granulare Berechtigungen

### Aufgabe 3.1: Spaltenspezifische Berechtigungen
1. Entziehe der Rolle `read_only` die Leserechte auf die Tabelle `person`.
2. Gewähre der Rolle `read_only` Leserechte nur auf die Spalten `PersID`, `Name`, `Vorname` und `Ort` der Tabelle `person`.
3. Teste als `reporting_user`, ob du nur auf diese Spalten zugreifen kannst und nicht auf andere wie `Geburtsdatum` oder `Eintritt`.

```sql
-- Beispiellösung für Aufgabe 3.1:
REVOKE SELECT ON TABLE person FROM read_only;
GRANT SELECT (PersID, Name, Vorname, Ort) ON TABLE person TO read_only;

-- Als reporting_user testen:
SELECT PersID, Name, Vorname, Ort FROM person LIMIT 5;
SELECT * FROM person LIMIT 5; -- Sollte einen Fehler für geschützte Spalten geben
```

### Aufgabe 3.2: Spezifische UPDATE-Berechtigungen
1. Erlaube der Rolle `read_write`, nur die Spalte `Bemerkung` in der Tabelle `teilnehmer` zu aktualisieren.
2. Teste als `app_user`, ob du die Bemerkungen aktualisieren kannst, aber keine anderen Felder.

```sql
-- Beispiel für Aufgabe 3.2:
REVOKE UPDATE ON TABLE teilnehmer FROM read_write;
GRANT UPDATE (Bemerkung) ON TABLE teilnehmer TO read_write;

-- Als app_user testen:
UPDATE teilnehmer SET Bemerkung = 'Neue Bemerkung' 
WHERE AnlaID = 1 AND PersID = 1;

UPDATE teilnehmer SET AnlaID = 2 
WHERE AnlaID = 1 AND PersID = 1; -- Sollte fehlschlagen
```

## Teil 4: WITH GRANT OPTION und REVOKE

### Aufgabe 4.1: Berechtigungsweitergabe
1. Erstelle einen neuen Benutzer `power_user` mit Passwort.
2. Erteile diesem Benutzer SELECT-Rechte auf die Tabelle `anlass` mit der Option `WITH GRANT OPTION`.
3. Wechsle zur Rolle `power_user` und erteile SELECT-Rechte auf die Tabelle `anlass` an den Benutzer `app_user`.
4. Teste, ob `app_user` auf die Tabelle `anlass` zugreifen kann.

```sql
-- Beispiellösung für Aufgabe 4.1:
CREATE USER power_user WITH PASSWORD 'power123';
GRANT SELECT ON TABLE anlass TO power_user WITH GRANT OPTION;

-- Als power_user:
GRANT SELECT ON TABLE anlass TO app_user;

-- Als app_user testen:
SELECT * FROM anlass LIMIT 5;
```

### Aufgabe 4.2: Kaskadierende Widerrufung
1. Widerrufe die SELECT-Rechte von `power_user` auf die Tabelle `anlass` mit der Option `CASCADE`.
2. Teste als `app_user`, ob du noch auf die Tabelle `anlass` zugreifen kannst (sollte nicht mehr möglich sein).

```sql
-- Beispiel für Aufgabe 4.2:
REVOKE SELECT ON TABLE anlass FROM power_user CASCADE;

-- Als app_user testen:
SELECT * FROM anlass LIMIT 5; -- Sollte fehlschlagen
```

## Teil 5: Praktisches Szenario - Prinzip der geringsten Berechtigung

### Aufgabe 5.1: Anwendungsbenutzer konfigurieren
Konfiguriere die Berechtigungen so, dass:
1. `app_user` kann:
   - Alle Tabellen lesen
   - In die Tabellen `teilnehmer` und `anlass` einfügen
   - Die Tabelle `teilnehmer` aktualisieren (nur die Spalte `Bemerkung`)
   - Keine Daten löschen

2. `reporting_user` kann:
   - Alle Tabellen lesen, ausser `spende` (sensible Finanzdaten)
   - Keine Daten einfügen, aktualisieren oder löschen

3. `admin_user` kann:
   - Alle Operationen auf allen Tabellen durchführen

```sql
-- Komplexes Beispiel für differenzierte Berechtigungen
-- Zuerst alle Berechtigungen zurücksetzen
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM read_only, read_write, admin_role;

-- Berechtigungen für read_only (reporting_user)
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only;
REVOKE SELECT ON TABLE spende FROM read_only;

-- Berechtigungen für read_write (app_user)
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_write;
GRANT INSERT ON TABLE teilnehmer, anlass TO read_write;
GRANT UPDATE (Bemerkung) ON TABLE teilnehmer TO read_write;

-- Berechtigungen für admin_role (admin_user)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
```

## Hinweise zur Bearbeitung

- Teste alle Berechtigungen, indem du dich als entsprechender Benutzer anmeldest
- Dokumentiere fehlgeschlagene Operationen und deren Fehlermeldungen
- Beachte die Rollenhierarchie und die Vererbung von Berechtigungen
- Setze das Prinzip der geringsten Berechtigung konsequent um
- Am Ende der Übung solltest du alle erstellten Benutzer, Rollen und Testdaten wieder löschen

## Zusatzaufgabe (optional)

Erstelle ein Testszenario für die Rechte eines Auditors, der:
1. Alle Daten lesen darf (ausser sensible personenbezogene Daten)
2. Keine Änderungen vornehmen darf (keine INSERT/UPDATE/DELETE)
3. Nur bis zu einem bestimmten Datum Zugriff haben soll
4. Die Datenbank nur zu bestimmten Zeiten nutzen darf (z.B. nur während der Bürozeiten)

Recherchiere, wie der letzte Punkt in PostgreSQL umgesetzt werden kann (Hinweis: Verbindungsbeschränkungen können in pg_hba.conf oder mit zusätzlichen Tools konfiguriert werden).
