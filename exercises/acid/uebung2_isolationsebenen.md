# Übung 2: Isolationsebenen und Konkurrenz

## Warum sind Isolationsebenen wichtig?

Isolationsebenen bestimmen, wie Transaktionen die Änderungen anderer gleichzeitiger Transaktionen sehen. Die Wahl der richtigen Isolationsebene ist ein Kompromiss zwischen Konsistenz und Performance und hängt von den Anforderungen der Anwendung ab.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen
3. Die Möglichkeit, mehrere Datenbankverbindungen gleichzeitig zu öffnen, um Nebenläufigkeitseffekte zu demonstrieren

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

## Praktische Übung zu Isolationsebenen

Für diese Übung benötigst du zwei separate Verbindungen zur Datenbank, die wir als "Sitzung 1" und "Sitzung 2" bezeichnen.

### a) READ COMMITTED (Standard in PostgreSQL)

**Sitzung 1:**
```sql
BEGIN;
SELECT name, kontostand FROM transaktions_test WHERE name = 'Alice';
-- Sollte den aktuellen Kontostand zeigen
```

**Sitzung 2:**
```sql
BEGIN;
UPDATE transaktions_test SET kontostand = kontostand + 100 WHERE name = 'Alice';
COMMIT;
```

**Sitzung 1:**
```sql
-- Nach dem Commit in Sitzung 2
SELECT name, kontostand FROM transaktions_test WHERE name = 'Alice';
-- In READ COMMITTED sieht man jetzt den aktualisierten Kontostand
COMMIT;
```

### b) REPEATABLE READ

**Sitzung 1:**
```sql
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT name, kontostand FROM transaktions_test WHERE name = 'Bob';
-- Merke dir den Kontostand
```

**Sitzung 2:**
```sql
BEGIN;
UPDATE transaktions_test SET kontostand = kontostand + 100 WHERE name = 'Bob';
COMMIT;
```

**Sitzung 1:**
```sql
-- Nach dem Commit in Sitzung 2
SELECT name, kontostand FROM transaktions_test WHERE name = 'Bob';
-- In REPEATABLE READ sieht man immer noch den alten Kontostand
COMMIT;

-- Nach dem eigenen Commit sieht man die Änderungen
SELECT name, kontostand FROM transaktions_test WHERE name = 'Bob';
```

### c) SERIALIZABLE

**Sitzung 1:**
```sql
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT SUM(kontostand) FROM transaktions_test;
-- Berechne die Summe aller Kontostände
```

**Sitzung 2:**
```sql
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE transaktions_test SET kontostand = kontostand + 100 WHERE name = 'Charlie';
COMMIT;
```

**Sitzung 1:**
```sql
-- Versuche eine Änderung, die von der Summe abhängt
UPDATE transaktions_test SET kontostand = kontostand * 1.1;
-- Dies sollte einen Serialisierungsfehler auslösen
COMMIT;
-- Dieser Commit schlägt fehl mit "could not serialize access due to concurrent update"
```

## Aufgaben

1. Experimentiere mit den verschiedenen Isolationsebenen und beobachte, wie sie sich auf die Sichtbarkeit von Änderungen auswirken.
2. Versuche, ein "Phantom Read"-Problem zu erzeugen und zu lösen.
3. Teste, wie sich die Wahl der Isolationsebene auf die Performance auswirkt, indem du mehrere gleichzeitige Transaktionen ausführst.
