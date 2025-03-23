---
title: "ACID und Transaktionen / Übung 1: Atomarität demonstrieren"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - ACID
    - Transaktion
---
# Übung 1: Atomarität demonstrieren

## Warum ist Atomarität wichtig?

Die Atomarität von Transaktionen stellt sicher, dass entweder alle Änderungen einer Transaktion übernommen werden oder keine davon. Dies ist besonders wichtig, wenn zusammengehörige Operationen durchgeführt werden, wie zum Beispiel Überweisungen zwischen Konten.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen

Um sicherzustellen, dass alle Übungen reproduzierbar sind, erstellen wir zunächst eine temporäre Tabelle für unsere Tests:

```sql
-- Lösche Transaktionsübungstabelle, wenn sie existiert
DROP TABLE IF EXISTS transaktions_test;

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

## Praktische Übung zur Atomarität

In dieser Übung simulieren wir eine Banküberweisung zwischen zwei Konten und demonstrieren, wie die Atomarität die Datenintegrität schützt:

### a) Erfolgreiche Transaktion

Öffne eine neue SQL-Abfrage in DBeaver und führe den folgenden Code aus:

```sql
-- Zeige den ursprünglichen Kontostand
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Alice', 'Bob');

BEGIN;

-- Abheben von Alices Konto
UPDATE transaktions_test 
    SET kontostand = kontostand - 200 
    WHERE name = 'Alice';

-- Einzahlen auf Bobs Konto
UPDATE transaktions_test 
    SET kontostand = kontostand + 200 
    WHERE name = 'Bob';

-- Prüfen der Zwischenstände (nur innerhalb dieser Transaktion sichtbar)
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Alice', 'Bob');

-- Transaktion erfolgreich abschliessen
COMMIT;

-- Zeige die neuen Kontostände nach dem Commit
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Alice', 'Bob');
```

### b) Rollback demonstrieren

Öffne eine neue SQL-Abfrage und führe den folgenden Code aus:

```sql
-- Zeige den aktuellen Kontostand
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Bob', 'Charlie');

BEGIN;

-- Abheben von Bobs Konto
UPDATE transaktions_test 
    SET kontostand = kontostand - 300 
    WHERE name = 'Bob';

-- Einzahlen auf Charlies Konto
UPDATE transaktions_test 
    SET kontostand = kontostand + 300 
    WHERE name = 'Charlie';

-- Prüfen der Zwischenstände
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Bob', 'Charlie');

-- Angenommen, wir entdecken ein Problem und möchten die Transaktion abbrechen
ROLLBACK;

-- Zeige die Kontostände nach dem Rollback - sie sollten unverändert sein
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Bob', 'Charlie');
```

### c) Fehler innerhalb einer Transaktion

```sql
BEGIN;

-- Abheben von Charlies Konto
UPDATE transaktions_test 
    SET kontostand = kontostand - 200 
    WHERE name = 'Charlie';

-- Versuche eine ungültige Operation, die einen Fehler auslöst
-- (z.B. Division durch Null)
SELECT 1/0;

-- Diese Anweisung wird nicht erreicht, da der obige Fehler die Transaktion abbricht
UPDATE transaktions_test 
    SET kontostand = kontostand + 200 
    WHERE name = 'Diana';

-- Versuche zu committen (wird nicht ausgeführt wegen des Fehlers)
COMMIT;

-- Überprüfe, dass keine Änderungen vorgenommen wurden
SELECT name, kontostand 
    FROM transaktions_test 
    WHERE name IN ('Charlie', 'Diana');
```

## Aufgaben

1. Versuche eine Transaktion mit mehreren Schritten zu erstellen und gezielt mit `ROLLBACK` abzubrechen.
2. Was passiert, wenn du einen Fehler (z.B. Verletzung einer CHECK-Constraint) innerhalb einer Transaktion erzeugst?
3. Experimentiere mit `SAVEPOINT` und `ROLLBACK TO SAVEPOINT` innerhalb einer Transaktion.
