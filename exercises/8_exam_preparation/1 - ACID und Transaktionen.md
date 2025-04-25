---
title: "Prüfungsvorbereitung: ACID & Transaktionen"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - ACID
    - Transaktionen
    - Deadlocks
    - Isolationsebenen
---

# Prüfungsvorbereitung: ACID & Transaktionen

## Übungsziele

In diesem Übungsblatt werden die Konzepte von ACID-Eigenschaften und Transaktionen wiederholt und vertieft. Nach Bearbeitung dieser Übungen solltest du:

- Die ACID-Eigenschaften präzise erklären können
- Verstehen, wann und warum Transaktionen eingesetzt werden
- Transaktionen in SQL korrekt implementieren können
- Die Auswirkungen verschiedener Isolationsebenen einschätzen können
- Lösungsansätze für typische Probleme wie Deadlocks kennen

## Theoretische Fragen

### 1.1 ACID-Eigenschaften

Erkläre kurz, was die folgenden ACID-Eigenschaften bedeuten und gib jeweils ein konkretes Beispiel an, welches Problem sie verhindern:

a) **Atomarität (Atomicity)**: 
b) **Konsistenz (Consistency)**: 
c) **Isolation (Isolation)**:
d) **Dauerhaftigkeit (Durability)**:

### 1.2 Anomalien bei Nebenläufigkeit

Beschreibe die folgenden Anomalien bei gleichzeitigem Datenbankzugriff:

a) **Dirty Read**:
b) **Non-repeatable Read**:
c) **Phantom Read**:

### 1.3 Isolationsebenen

Ordne die folgenden Isolationsebenen nach ihrem Schutzniveau (von niedrig nach hoch) und gib an, welche Anomalien sie jeweils verhindern:

- SERIALIZABLE
- READ UNCOMMITTED
- REPEATABLE READ
- READ COMMITTED

## Praktische Übungen

### 2.1 Grundlegende Transaktionssteuerung

Schreibe ein SQL-Skript, das eine Transaktion ausführt, welche folgende Aktionen umfasst:

1. Erhöht den Betrag aller Spenden des Sponsors mit der ID '3c36866d-0e65-42e2-847a-18a64582dd24' um 10%.
2. Aktualisiert das Spendentotal des betreffenden Sponsors entsprechend.
3. Fügt in einer imaginären Tabelle `protokoll` einen Eintrag hinzu, der diese Änderung dokumentiert.

Achte darauf, die Transaktion korrekt zu beginnen und entweder zu bestätigen oder bei Fehlern zurückzurollen.

### 2.2 Verwendung von Savepoints

Erweitere dein Skript aus Aufgabe 2.1, um die Verwendung von Savepoints zu demonstrieren:

1. Setze nach der Erhöhung der Spendenbeträge einen Savepoint namens `after_spende_update`.
2. Führe danach die Aktualisierung des Spendentotals durch.
3. Demonstriere, wie man zu dem Savepoint zurückrollen kann (unabhängig von irgendwelchen Bedingungen).
4. Füge abschliessend einen Protokolleintrag hinzu, der den Vorgang dokumentiert.

Hinweis: In einer realen Anwendung würde die Prüfung, ob Grenzwerte überschritten sind, oft in der Anwendungslogik (z.B. Java, PHP) durchgeführt, die dann entsprechende SQL-Befehle ausführt. Für diese Übung konzentriere dich auf die reine SQL-Syntax für Savepoints.

### 2.3 Implementierung eines Vier-Augen-Prinzips

Entwirf ein SQL-Schema und einfache Transaktionen für ein System, das das Vier-Augen-Prinzip bei Überweisungen implementiert:

1. Erstelle eine Tabelle `ueberweisungsantrag` mit allen nötigen Feldern für Betrag, Quelle, Ziel, Antragsteller, Genehmiger, Status und Zeitstempel.
2. Schreibe eine INSERT-Anweisung für die Erstellung eines neuen Überweisungsantrags (Status "ausstehend").
3. Schreibe eine UPDATE-Anweisung, die einen bestimmten Antrag auf "genehmigt" setzt und den Genehmiger einträgt.

Hinweis: In einer realen Anwendung würde die Prüfung, ob der Genehmiger mit dem Antragsteller identisch ist, normalerweise in der Anwendungslogik oder durch Datenbank-Trigger erfolgen. Für diese Übung reicht es, die grundlegenden SQL-Strukturen zu implementieren.

### 2.4 Analyse von Isolationsebenen

Die folgende Tabelle zeigt Kontostände:

```sql
CREATE TABLE konto (
    konto_id INTEGER PRIMARY KEY,
    inhaber VARCHAR(100) NOT NULL,
    kontostand DECIMAL(10,2) NOT NULL
);

INSERT INTO konto VALUES (1, 'Alice', 1000.00);
INSERT INTO konto VALUES (2, 'Bob', 500.00);
```

Beschreibe, was in den folgenden Szenarien passieren würde und welche Isolationsebene jeweils das Problem verhindern würde:

a) **Szenario 1**: Transaktion A liest den Kontostand von Alice. Transaktion B erhöht den Kontostand um 500 und führt ein COMMIT durch. Transaktion A liest den Kontostand erneut.

b) **Szenario 2**: Transaktion A beginnt eine Überweisung von Alice zu Bob, zieht 200 von Alices Konto ab, aber führt noch kein COMMIT durch. Transaktion B liest Alices Kontostand.

c) **Szenario 3**: Transaktion A liest alle Konten mit einem Kontostand über 700. Transaktion B fügt ein neues Konto mit Kontostand 800 ein und führt ein COMMIT durch. Transaktion A liest erneut alle Konten mit einem Kontostand über 700.

### 2.5 Deadlock-Szenarien und -Vermeidung

Betrachte das folgende Szenario:

```sql
-- Transaktion 1
BEGIN;
UPDATE person SET name = 'Neuer Name' WHERE persid = 'id1';
-- ... einige Zeit vergeht
UPDATE status SET beitrag = 100 WHERE statid = 'id2';
COMMIT;

-- Transaktion 2 (gleichzeitig gestartet)
BEGIN;
UPDATE status SET beitrag = 200 WHERE statid = 'id2';
-- ... einige Zeit vergeht
UPDATE person SET name = 'Anderer Name' WHERE persid = 'id1';
COMMIT;
```

a) Erkläre, warum hier ein Deadlock entstehen kann.

b) Schreibe die beiden Transaktionen so um, dass ein Deadlock vermieden wird.

---

Denke daran, die Lösungen auf einem separaten Blatt oder in einer Datei zu notieren, damit du später deine Antworten mit den Musterlösungen vergleichen kannst.
