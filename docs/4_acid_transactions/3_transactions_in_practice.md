# Transaktionen in der Praxis

Nachdem wir die theoretischen Grundlagen des ACID-Paradigmas verstanden haben, wenden wir uns nun der praktischen Anwendung von Transaktionen zu. In diesem Abschnitt lernst du, wie Transaktionen in SQL definiert und gesteuert werden, welche Isolationsebenen zur Verfügung stehen und wie moderne Datenbanksysteme mit Nebenläufigkeit umgehen.

## Der Lebenszyklus einer Transaktion

### Warum ist das Verständnis des Transaktionslebenszyklus wichtig?

Als Datenbankentwickler musst du den Ablauf einer Transaktion genau verstehen, um robuste Anwendungen zu entwickeln. Stell dir vor, du implementierst ein Buchungssystem für ein Hotel: Wenn du nicht weisst, wie Transaktionen korrekt begonnen, verarbeitet und abgeschlossen werden, könntest du ungewollt Zimmer doppelt buchen oder Reservierungen verlieren.

Der Transaktionslebenszyklus bietet ein Modell, das hilft, den korrekten Ablauf zu gewährleisten und typische Fehler zu vermeiden.

### Was genau ist der Lebenszyklus einer Transaktion?

Eine Transaktion durchläuft typischerweise folgende Phasen {cite}`bernstein_newcomer`:

1. **Beginn (BEGIN)**: Die Transaktion wird gestartet und erhält eine eindeutige Transaktions-ID.
2. **Aktive Phase**: SQL-Anweisungen werden ausgeführt (SELECT, INSERT, UPDATE, DELETE).
3. **Teilweiser Commit**: Alle Operationen wurden ausgeführt, aber die Änderungen sind noch nicht permanent.
4. **Commit oder Rollback**:
   - **COMMIT**: Die Änderungen werden dauerhaft in der Datenbank gespeichert.
   - **ROLLBACK**: Die Änderungen werden rückgängig gemacht, die Datenbank bleibt im ursprünglichen Zustand.
5. **Beendigung**: Die Transaktion ist abgeschlossen, Ressourcen werden freigegeben.

```{mermaid}
stateDiagram-v2
    [*] --> BEGIN: Transaktion starten
    BEGIN --> AKTIV: SQL-Operationen ausführen
    AKTIV --> TEILCOMMIT: Alle Operationen abgeschlossen
    TEILCOMMIT --> COMMIT: Änderungen bestätigen
    AKTIV --> ROLLBACK: Fehler aufgetreten
    TEILCOMMIT --> ROLLBACK: Manuelle Entscheidung zum Abbruch
    COMMIT --> [*]: Transaktion erfolgreich beendet
    ROLLBACK --> [*]: Transaktion abgebrochen
```

### Wie wird der Transaktionslebenszyklus in der Praxis umgesetzt?

In SQL sieht die Umsetzung folgendermassen aus:

```sql
-- 1. Transaktion beginnen
BEGIN TRANSACTION;

-- 2. Aktive Phase: SQL-Anweisungen ausführen
UPDATE Konten SET Kontostand = Kontostand - 1000 WHERE KontoID = 12345;
UPDATE Konten SET Kontostand = Kontostand + 1000 WHERE KontoID = 67890;

-- 3. & 4. Teilweiser Commit und Entscheidung
-- Bei Erfolg: Änderungen permanent machen
COMMIT;

-- ODER bei Problemen: Änderungen zurückrollen
-- ROLLBACK;

-- 5. Transaktion ist beendet, Ressourcen werden freigegeben
```

Moderne Datenbanksysteme bieten zusätzliche Kontrollfunktionen:

- **SAVEPOINT**: Setzt einen Wiederherstellungspunkt innerhalb einer Transaktion
- **ROLLBACK TO SAVEPOINT**: Rollt die Transaktion bis zu einem bestimmten Savepoint zurück
- **SET TRANSACTION**: Legt Eigenschaften der Transaktion fest (z.B. Isolationsebene)

## Transaktionssteuerung mit SQL

### Warum sollte ich Transaktionen explizit steuern?

Bei einfachen SQL-Anweisungen werden Transaktionen oft implizit verwaltet (Auto-Commit). In komplexeren Szenarien ist jedoch eine explizite Steuerung unerlässlich:

- **Atomarität gewährleisten**: Mehrere zusammengehörige Operationen als Einheit behandeln
- **Fehlerbehandlung verbessern**: Bei Problemen kontrolliert zurückrollen
- **Performance optimieren**: Mehrere Operationen in einer Transaktion bündeln
- **Isolationsebene anpassen**: Je nach Anforderung die passende Isolationsebene wählen

### Transaktionsbefehle in SQL

PostgreSQL und die meisten anderen relationalen Datenbanksysteme unterstützen folgende Grundbefehle zur Transaktionssteuerung {cite}`postgres_transactions`:

#### Starten einer Transaktion

```sql
-- Variante 1 (Standard SQL)
BEGIN TRANSACTION;

-- Variante 2 (PostgreSQL-Kurzform)
BEGIN;

-- Variante 3 (In manchen Systemen)
START TRANSACTION;
```

#### Erfolgreiches Beenden einer Transaktion

```sql
-- Die Änderungen werden permanent in der Datenbank gespeichert
COMMIT;

-- Alternative Syntax
COMMIT TRANSACTION;
```

#### Abbrechen einer Transaktion

```sql
-- Alle Änderungen seit BEGIN werden verworfen
ROLLBACK;

-- Alternative Syntax
ROLLBACK TRANSACTION;
```

#### Verwendung von Savepoints

```sql
-- Setzen eines Savepoints
SAVEPOINT mein_savepoint;

-- Zurückrollen bis zu einem Savepoint
ROLLBACK TO SAVEPOINT mein_savepoint;

-- Löschen eines Savepoints
RELEASE SAVEPOINT mein_savepoint;
```

### Praktisches Beispiel: Eine Banküberweisung

```sql
BEGIN;

-- Prüfen, ob genügend Guthaben vorhanden ist
SELECT Kontostand FROM Konten WHERE KontoID = 12345;

-- Angenommen, das Ergebnis zeigt ausreichendes Guthaben...
-- Setzen eines Savepoints vor der kritischen Operation
SAVEPOINT vor_abbuchung;

-- Geld vom Senderkonto abbuchen
UPDATE Konten SET Kontostand = Kontostand - 1000 WHERE KontoID = 12345;

-- Prüfen, ob die Abbuchung erfolgreich war
SELECT Kontostand FROM Konten WHERE KontoID = 12345;

-- Wenn das Ergebnis negativ ist und dies nicht erlaubt sein soll:
-- ROLLBACK TO SAVEPOINT vor_abbuchung;
-- ROLLBACK;
-- RETURN 'Nicht genügend Guthaben';

-- Geld dem Empfängerkonto gutschreiben
UPDATE Konten SET Kontostand = Kontostand + 1000 WHERE KontoID = 67890;

-- Transaktion erfolgreich abschliessen
COMMIT;
```

### Besonderheiten in verschiedenen Datenbanksystemen

Obwohl die grundlegende Transaktionssteuerung in SQL standardisiert ist, gibt es Unterschiede zwischen den Datenbanksystemen:

| Datenbanksystem | Besonderheiten |
|-----------------|----------------|
| **PostgreSQL** | Unterstützt alle Standard-Transaktionsbefehle; Automatische Rollbacks bei Fehlern innerhalb einer Transaktion |
| **MySQL/MariaDB** | In MyISAM-Tabellen keine Transaktionsunterstützung; InnoDB-Tabellen bieten volle Transaktionsunterstützung |
| **Oracle** | Verwendet zusätzlich SET TRANSACTION für spezielle Eigenschaften; Unterstützt autonome Transaktionen |
| **SQL Server** | Erweiterte Transaktionsoptionen mit \@\@TRANCOUNT; Verschachtelte Transaktionen mit spezieller Semantik |
| **SQLite** | Einfacheres Transaktionsmodell; Standardmässig im Auto-Commit-Modus |

## Isolationsebenen und ihre Auswirkungen

### Warum sind verschiedene Isolationsebenen wichtig?

Stell dir vor, du entwickelst ein Online-Ticketverkaufssystem für ein grosses Konzert. Hunderte von Benutzern versuchen gleichzeitig, Tickets zu kaufen. Hier ist die Wahl der richtigen Isolationsebene entscheidend:

- Eine zu strenge Isolation könnte die Performance dramatisch beeinträchtigen und zu langen Wartezeiten führen
- Eine zu lockere Isolation könnte dazu führen, dass Tickets doppelt verkauft werden
- Die richtige Balance zu finden ist entscheidend für die Funktionalität und Benutzererfahrung

### Die vier Standard-Isolationsebenen

Der SQL-Standard definiert vier Isolationsebenen, die unterschiedliche Kompromisse zwischen Konsistenz und Performance bieten {cite}`microsoft_acid`:

#### 1. READ UNCOMMITTED (niedrigste Isolation)

- **Eigenschaften**: Transaktionen können nicht-festgeschriebene Änderungen anderer Transaktionen sehen
- **Probleme**: Erlaubt Dirty Reads, Non-repeatable Reads und Phantom Reads
- **Vorteile**: Höchste Performance, geringster Overhead
- **Einsatzgebiete**: Nur für unkritische Daten geeignet, z.B. vorläufige Berichte, bei denen Genauigkeit nicht entscheidend ist

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN;
-- Operationen...
COMMIT;
```

#### 2. READ COMMITTED

- **Eigenschaften**: Transaktionen sehen nur festgeschriebene Änderungen anderer Transaktionen
- **Probleme**: Verhindert Dirty Reads, erlaubt aber Non-repeatable Reads und Phantom Reads
- **Vorteile**: Gute Performance bei angemessener Isolation
- **Einsatzgebiete**: Standardeinstellung in vielen Datenbanksystemen (PostgreSQL, Oracle, SQL Server)

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
-- Operationen...
COMMIT;
```

#### 3. REPEATABLE READ

- **Eigenschaften**: Transaktionen sehen während ihrer gesamten Laufzeit den gleichen Zustand der Daten, die sie lesen
- **Probleme**: Verhindert Dirty Reads und Non-repeatable Reads, erlaubt aber Phantom Reads
- **Vorteile**: Höhere Konsistenz für Leseoperationen
- **Einsatzgebiete**: Berichte und Analysen, die konsistente Sichten auf die Daten benötigen

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
-- Operationen...
COMMIT;
```

#### 4. SERIALIZABLE (höchste Isolation)

- **Eigenschaften**: Transaktionen werden so ausgeführt, als würden sie sequentiell (nicht parallel) ablaufen
- **Probleme**: Verhindert alle Anomalien (Dirty Reads, Non-repeatable Reads, Phantom Reads)
- **Vorteile**: Höchste Konsistenz und Isolation
- **Einsatzgebiete**: Kritische Finanztransaktionen, wo absolute Datenintegrität erforderlich ist

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
-- Operationen...
COMMIT;
```

### Übersicht der Isolationsebenen und Anomalien

| Isolationsebene | Dirty Read | Non-repeatable Read | Phantom Read |
|-----------------|------------|---------------------|--------------|
| READ UNCOMMITTED | Möglich | Möglich | Möglich |
| READ COMMITTED | Verhindert | Möglich | Möglich |
| REPEATABLE READ | Verhindert | Verhindert | Möglich |
| SERIALIZABLE | Verhindert | Verhindert | Verhindert |

```{mermaid}
graph TD
    A[Isolationsebenen] --> B[READ UNCOMMITTED]
    A --> C[READ COMMITTED]
    A --> D[REPEATABLE READ]
    A --> E[SERIALIZABLE]
    
    B --> F["Performanz +++ / Konsistenz -"]
    C --> G["Performanz ++ / Konsistenz +"]
    D --> H["Performanz + / Konsistenz ++"]
    E --> I["Performanz - / Konsistenz +++"]
    
    style A fill:#d4f1f9
    style B fill:#f8cecc
    style C fill:#ffe6cc
    style D fill:#d5e8d4
    style E fill:#d5e8d4
    style F fill:#f8cecc
    style G fill:#ffe6cc
    style H fill:#d5e8d4
    style I fill:#d5e8d4
```

### Isolation in PostgreSQL

PostgreSQL implementiert alle vier Standard-Isolationsebenen, hat aber einige Besonderheiten {cite}`postgres_transactions`:

- **READ UNCOMMITTED**: In PostgreSQL intern identisch mit READ COMMITTED
- **READ COMMITTED**: Standardeinstellung
- **REPEATABLE READ**: Implementiert durch Snapshot Isolation
- **SERIALIZABLE**: Implementiert durch Serializable Snapshot Isolation (SSI)

## Nebenläufigkeitskontrolle

### Warum ist Nebenläufigkeitskontrolle wichtig?

In modernen Datenbanksystemen führen viele Benutzer gleichzeitig Transaktionen durch. Ohne geeignete Mechanismen zur Nebenläufigkeitskontrolle könnten:

- Transaktionen inkonsistente Daten lesen oder schreiben
- Updates verloren gehen, wenn mehrere Transaktionen die gleichen Daten ändern
- Deadlocks auftreten, die das System blockieren
- Die Performance durch zu viele Sperren drastisch reduziert werden

### Hauptansätze zur Nebenläufigkeitskontrolle

Es gibt zwei grundlegende Ansätze zur Nebenläufigkeitskontrolle in Datenbanksystemen {cite}`elmasri_navathe`:

#### 1. Sperrbasiert (Pessimistisch)

Bei dieser Methode werden Daten gesperrt, bevor sie gelesen oder geändert werden.

- **Sperrmodi**:
  - **Shared Lock (S)**: Mehrere Transaktionen können gleichzeitig lesen
  - **Exclusive Lock (X)**: Nur eine Transaktion kann schreiben, keine andere kann lesen oder schreiben
- **Sperreinheiten**: 
  - Datenbankweite Sperren (sehr restriktiv)
  - Tabellensperren
  - Seitensperren
  - Zeilensperren (feingranular)
- **Vor- und Nachteile**:
  - ✅ Hohe Konsistenz
  - ✅ Gute Kontrolle
  - ❌ Potenzielle Deadlocks
  - ❌ Performance-Einbussen bei hoher Last

```sql
-- Beispiel für explizites Sperren in PostgreSQL
BEGIN;
-- Tabellensperren anfordern
LOCK TABLE konten IN EXCLUSIVE MODE;
-- Operationen...
COMMIT;
```

#### 2. Mehrversionen-Parallelitätskontrolle (MVCC, Optimistisch)

Bei MVCC werden keine Sperren für lesende Zugriffe verwendet. Stattdessen sieht jede Transaktion eine "Momentaufnahme" (Snapshot) der Datenbank zu einem bestimmten Zeitpunkt.

- **Funktionsweise**:
  - Für jede Änderung wird eine neue Version eines Datensatzes erstellt
  - Transaktionen sehen nur die Versionen, die zu ihrem Startzeitpunkt bereits festgeschrieben waren
  - Alte Versionen werden durch einen Aufräumprozess (Vacuum) entfernt
- **Vor- und Nachteile**:
  - ✅ Hoher Durchsatz, besonders bei leseintensiven Workloads
  - ✅ Keine Blockierung von Leseoperationen
  - ✅ Keine Deadlocks bei Lesevorgängen
  - ❌ Höherer Speicherverbrauch
  - ❌ Aufwändigere Implementierung

PostgreSQL verwendet MVCC als primären Mechanismus zur Nebenläufigkeitskontrolle, kombiniert mit Sperren für bestimmte Operationen.

### Deadlocks erkennen und vermeiden

Ein Deadlock entsteht, wenn zwei oder mehr Transaktionen gegenseitig auf Sperren warten, die die jeweils andere Transaktion hält:

```
Transaktion A hält Sperre auf Ressource 1 und wartet auf Sperre auf Ressource 2
Transaktion B hält Sperre auf Ressource 2 und wartet auf Sperre auf Ressource 1
```

Datenbanksysteme verwenden verschiedene Strategien, um mit Deadlocks umzugehen:

1. **Deadlock-Erkennung**: Das System sucht periodisch nach Zyklen im Wartegrafen und bricht im Deadlock-Fall eine der beteiligten Transaktionen ab
2. **Deadlock-Vermeidung**: Transaktionen müssen alle benötigten Ressourcen vorab anfordern oder werden in einer festgelegten Reihenfolge ausgeführt
3. **Timeouts**: Transaktionen werden abgebrochen, wenn sie zu lange auf eine Sperre warten

PostgreSQL verwendet primär Deadlock-Erkennung und Timeouts:

```sql
-- Timeout für Sperren festlegen (in Millisekunden)
SET lock_timeout = 5000; -- 5 Sekunden

BEGIN;
-- Operationen...
COMMIT;
```

### Optimistische vs. Pessimistische Nebenläufigkeitskontrolle

Die Wahl zwischen optimistischer und pessimistischer Nebenläufigkeitskontrolle hängt vom Anwendungsfall ab:

| Eigenschaft | Pessimistisch (Sperren) | Optimistisch (MVCC) |
|-------------|--------------------------|---------------------|
| **Konfliktwahrscheinlichkeit** | Gut bei hoher Konfliktwahrscheinlichkeit | Gut bei niedriger Konfliktwahrscheinlichkeit |
| **Lesevorgänge** | Blockiert bei Schreibsperren | Nicht blockiert durch Schreibvorgänge |
| **Schreibvorgänge** | Wartet auf Sperren | Prüft auf Konflikte vor dem Commit |
| **Speicherverbrauch** | Geringer | Höher durch Mehrversionen |
| **Typische Anwendungen** | Finanztransaktionen | Webanwendungen mit vielen Lesevorgängen |

## Zusammenfassung

Transaktionen sind das Herzstück moderner Datenbanksysteme und ermöglichen die sichere und konsistente Verarbeitung von Daten, selbst in hochparallelen Umgebungen. In diesem Abschnitt haben wir gelernt:

- Der Lebenszyklus einer Transaktion umfasst Beginn, aktive Phase, teilweisen Commit, Commit/Rollback und Beendigung
- SQL bietet umfangreiche Befehle zur Transaktionssteuerung (BEGIN, COMMIT, ROLLBACK, SAVEPOINT)
- Isolationsebenen bieten unterschiedliche Kompromisse zwischen Konsistenz und Performance
- Moderne Datenbanksysteme verwenden ausgeklügelte Mechanismen zur Nebenläufigkeitskontrolle, um Konflikte zu vermeiden und hohen Durchsatz zu ermöglichen

Im nächsten Abschnitt werden wir auf Herausforderungen und Lösungsansätze eingehen, die bei der Arbeit mit Transaktionen auftreten können, sowie die Grenzen des ACID-Paradigmas in verteilten Systemen betrachten.
