# Übung 3: Nebenläufigkeitsprobleme und Lösungen

## Warum ist Nebenläufigkeitskontrolle wichtig?

In Mehrbenutzersystemen können ohne geeignete Kontrolle Probleme wie verlorene Updates, schmutzige Lesevorgänge und Deadlocks auftreten. Diese Übung demonstriert solche Probleme und zeigt Lösungsansätze.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen
3. Die Möglichkeit, mehrere Datenbankverbindungen gleichzeitig zu öffnen

Falls noch nicht vorhanden, erstelle die Testtabelle:

```sql
-- Diese Tabelle verwenden wir für unsere Transaktionsübungen
CREATE TABLE IF NOT EXISTS transaktions_test (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    kontostand DECIMAL(10,2) NOT NULL,
    version INTEGER DEFAULT 1
);

-- Fügen wir einige Testdaten ein
INSERT INTO transaktions_test (name, kontostand)
VALUES 
    ('Alice', 1000.00),
    ('Bob', 500.00),
    ('Charlie', 1500.00),
    ('Diana', 2000.00);
```

## Praktische Übung zu Nebenläufigkeitsproblemen

### a) Verlorenes Update (Lost Update)

**Sitzung 1:**
```sql
BEGIN;
-- Lese Alices Kontostand
SELECT kontostand FROM transaktions_test WHERE name = 'Alice';
-- Angenommen, der Kontostand ist 800
```

**Sitzung 2:**
```sql
BEGIN;
-- Lese den gleichen Kontostand
SELECT kontostand FROM transaktions_test WHERE name = 'Alice';
-- Auch hier ist der Kontostand 800

-- Aktualisiere den Kontostand (z.B. +200)
UPDATE transaktions_test SET kontostand = kontostand + 200 WHERE name = 'Alice';
COMMIT;
-- Jetzt ist der Kontostand 1000
```

**Sitzung 1:**
```sql
-- Ohne zu wissen, dass Sitzung 2 den Kontostand geändert hat
-- Aktualisiere basierend auf dem gelesenen Wert (800 - 100)
UPDATE transaktions_test SET kontostand = kontostand - 100 WHERE name = 'Alice';
COMMIT;
-- Der Kontostand ist jetzt 900, die +200 von Sitzung 2 wurden "verloren"
```

### b) Lösung: Zeilensperre mit SELECT FOR UPDATE

**Sitzung 1:**
```sql
BEGIN;
-- Sperre die Zeile für Updates
SELECT kontostand FROM transaktions_test WHERE name = 'Bob' FOR UPDATE;
-- Angenommen, der Kontostand ist 500
```

**Sitzung 2:**
```sql
BEGIN;
-- Diese Abfrage wird blockiert, bis Sitzung 1 committed oder rollback ausführt
SELECT kontostand FROM transaktions_test WHERE name = 'Bob' FOR UPDATE;
```

**Sitzung 1:**
```sql
-- Aktualisiere den Kontostand
UPDATE transaktions_test SET kontostand = kontostand - 50 WHERE name = 'Bob';
COMMIT;
-- Jetzt ist der Kontostand 450
```

**Sitzung 2:**
```sql
-- Jetzt wird diese Abfrage freigeschaltet und sieht den neuen Kontostand 450
-- Aktualisiere basierend auf dem aktuellen Wert
UPDATE transaktions_test SET kontostand = kontostand + 200 WHERE name = 'Bob';
COMMIT;
-- Der Kontostand ist korrekt 650
```

### c) Optimistische Sperrung mit Versionsnummern

```sql
-- Setze die Versionsnummer für alle Test-Datensätze zurück
UPDATE transaktions_test SET version = 1;
```

**Sitzung 1:**
```sql
BEGIN;
-- Lese Datensatz mit Versionsnummer
SELECT id, name, kontostand, version FROM transaktions_test WHERE name = 'Charlie';
-- Angenommen, kontostand=1500, version=1
```

**Sitzung 2:**
```sql
BEGIN;
-- Lese den gleichen Datensatz
SELECT id, name, kontostand, version FROM transaktions_test WHERE name = 'Charlie';
-- Auch hier kontostand=1500, version=1

-- Aktualisiere und erhöhe die Versionsnummer
UPDATE transaktions_test 
SET kontostand = kontostand + 300, version = version + 1 
WHERE name = 'Charlie' AND version = 1;
COMMIT;
-- Jetzt kontostand=1800, version=2
```

**Sitzung 1:**
```sql
-- Versuche zu aktualisieren, aber prüfe die Version
UPDATE transaktions_test 
SET kontostand = kontostand - 200, version = version + 1 
WHERE name = 'Charlie' AND version = 1;
-- Diese Aktualisierung betrifft 0 Zeilen, da die Version jetzt 2 ist

-- Prüfe, ob die Aktualisierung erfolgreich war
SELECT ROW_COUNT();
-- Wenn 0 zurückgegeben wird, müssen wir erneut lesen und es noch einmal versuchen

-- Lies den aktuellen Stand
SELECT id, name, kontostand, version FROM transaktions_test WHERE name = 'Charlie';
-- Jetzt kontostand=1800, version=2

-- Versuche es erneut mit der aktuellen Version
UPDATE transaktions_test 
SET kontostand = kontostand - 200, version = version + 1 
WHERE name = 'Charlie' AND version = 2;
COMMIT;
-- Jetzt kontostand=1600, version=3
```

## Aufgaben

1. Demonstriere ein Deadlock-Szenario, indem du in zwei Sitzungen Ressourcen in unterschiedlicher Reihenfolge sperrst.
2. Implementiere eine Retry-Logik für optimistische Sperrung mit einer maximalen Anzahl von Versuchen.
3. Vergleiche die Performance von pessimistischer Sperrung (SELECT FOR UPDATE) mit optimistischer Sperrung (Versionsnummern) in einem Szenario mit vielen konkurrierenden Transaktionen.
