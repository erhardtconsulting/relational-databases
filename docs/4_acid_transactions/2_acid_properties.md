# Die ACID-Eigenschaften im Detail

Das ACID-Paradigma ist die Grundlage für zuverlässige Transaktionen in Datenbanksystemen. Die vier Buchstaben stehen für die Kernprinzipien, die ein Datenbanksystem erfüllen sollte, um Datenintegrität zu gewährleisten. In diesem Abschnitt werden wir jede dieser Eigenschaften im Detail betrachten.

## Atomarität (Atomicity)

### Warum ist Atomarität wichtig?

Stell dir vor, du überweist Geld von deinem Konto an einen Freund. Dieser Vorgang besteht aus mindestens zwei Operationen: dem Abbuchen von deinem Konto und dem Gutschreiben auf dem Konto deines Freundes. Was würde passieren, wenn das System nach der ersten Operation, aber vor der zweiten abstürzt? Das Geld wäre "verschwunden" – von deinem Konto abgebucht, aber nie bei deinem Freund angekommen.

Atomarität verhindert solche Szenarien, indem sie garantiert, dass eine Transaktion entweder vollständig oder gar nicht ausgeführt wird. Es gibt kein "teilweise abgeschlossen" – eine Transaktion ist unteilbar (atomar).

### Was bedeutet Atomarität genau?

Atomarität bedeutet "Unteilbarkeit". Eine Transaktion wird als eine einzelne, unteilbare Einheit betrachtet, die entweder vollständig erfolgreich ist oder vollständig fehlschlägt. Die Datenbank muss sicherstellen, dass es keinen Zwischenzustand gibt, in dem nur ein Teil der Operationen ausgeführt wurde {cite}`bernstein_newcomer`.

```{mermaid}
graph TD
    A[Transaktion beginnt] --> B{Alle Operationen erfolgreich?}
    B -->|Ja| C[COMMIT: Alle Änderungen werden permanent]
    B -->|Nein| D[ROLLBACK: Alle Änderungen werden rückgängig gemacht]
    C --> E[Transaktion erfolgreich abgeschlossen]
    D --> F[Datenbank im ursprünglichen Zustand]
    style A fill:#d4f1f9
    style B fill:#ffe6cc
    style C fill:#d5e8d4
    style D fill:#f8cecc
    style E fill:#d5e8d4
    style F fill:#f8cecc
```

### Wie wird Atomarität implementiert?

Datenbanksysteme implementieren Atomarität typischerweise durch:

1. **Logging**: Bevor eine Änderung durchgeführt wird, wird sie in einem Transaktionslog festgehalten.
2. **Zweiphasen-Commit**: Bei verteilten Datenbanken wird ein zweiphasiger Commit-Prozess verwendet, um sicherzustellen, dass alle beteiligten Systeme bereit sind, die Änderungen zu übernehmen.
3. **Rollback-Mechanismen**: Bei Fehlern kann die Datenbank anhand des Logs alle bereits durchgeführten Änderungen rückgängig machen.

In SQL können wir Atomarität durch die Verwendung von `BEGIN TRANSACTION`, `COMMIT` und `ROLLBACK` steuern:

```sql
-- Beginne eine atomare Transaktion
BEGIN TRANSACTION;

-- Operation 1: Geld vom Konto abbuchen
UPDATE Konten SET Kontostand = Kontostand - 1000 WHERE KontoID = 12345;

-- Operation 2: Geld auf anderes Konto einzahlen
UPDATE Konten SET Kontostand = Kontostand + 1000 WHERE KontoID = 67890;

-- Wenn alles erfolgreich war: Änderungen permanent machen
COMMIT;

-- Bei Fehlern: Änderungen rückgängig machen
-- ROLLBACK;
```

### Was passiert, wenn Atomarität nicht gewährleistet ist?

Ohne Atomarität könnten folgende Probleme auftreten:

- **Geldverlust**: Bei Banküberweisung könnte Geld "verschwinden", wenn nur eine Teiloperation durchgeführt wird.
- **Inkonsistente Bestände**: Ein Warenwirtschaftssystem könnte Produkte als verkauft markieren, ohne die entsprechenden Rechnungsdatensätze zu erstellen.
- **Ungültige Referenzen**: Ein neuer Benutzer könnte in der Benutzertabelle angelegt werden, aber die zugehörigen Berechtigungen nicht.

## Konsistenz (Consistency)

### Warum ist Konsistenz wichtig?

Stell dir vor, ein Unternehmen hat festgelegt, dass jeder Mitarbeiter genau einer Abteilung zugeordnet sein muss. Was würde passieren, wenn ein neuer Mitarbeiter ohne Abteilungszuordnung hinzugefügt werden könnte? Die Datenbank wäre in einem inkonsistenten Zustand, der gegen die Geschäftsregeln verstösst.

Konsistenz stellt sicher, dass eine Transaktion die Datenbank von einem gültigen Zustand in einen anderen gültigen Zustand überführt. Alle definierten Regeln, Einschränkungen und Beziehungen werden respektiert.

### Was bedeutet Konsistenz genau?

Konsistenz bedeutet, dass eine Transaktion nur Ergebnisse erzeugen darf, die mit den definierten Regeln der Datenbank übereinstimmen. Diese Regeln umfassen:

- **Integritätsbedingungen**: z.B. Primärschlüssel, Fremdschlüssel, Eindeutigkeits-Constraints
- **Geschäftsregeln**: z.B. "Ein Bankkonto darf nicht überzogen werden" oder "Ein Student kann nicht gleichzeitig in zwei Vollzeitstudiengängen eingeschrieben sein"
- **Datentypen und Wertebereichsbeschränkungen**: z.B. "Alter muss positiv sein"

Im Gegensatz zu den anderen ACID-Eigenschaften liegt die Verantwortung für die Konsistenz teilweise beim Anwendungsentwickler, der sicherstellen muss, dass die Transaktionen korrekt programmiert sind {cite}`elmasri_navathe`.

```{mermaid}
graph LR
    A[Konsistenter<br>Zustand 1] -->|Transaktion| B[Konsistenter<br>Zustand 2]
    C[Konsistenter<br>Zustand 1] -->|"Transaktion (mit Fehler)"| D[Inkonsistenter<br>Zustand]
    D -->|"ROLLBACK"| C
    style A fill:#d5e8d4
    style B fill:#d5e8d4
    style C fill:#d5e8d4
    style D fill:#f8cecc
```

### Wie wird Konsistenz implementiert?

Konsistenz wird durch mehrere Mechanismen gewährleistet:

1. **Deklarative Integritätsbedingungen**: Primärschlüssel, Fremdschlüssel, CHECK-Constraints, UNIQUE-Constraints
2. **Trigger und Stored Procedures**: Automatisierte Prüfungen bei Datenänderungen
3. **Transaktionslogik in der Anwendung**: Geschäftsregeln, die in der Anwendungslogik implementiert sind

Beispiel für Konsistenzregeln in SQL:

```sql
-- Tabellendefinition mit Konsistenzregeln
CREATE TABLE Mitarbeiter (
    MitarbeiterID INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    AbteilungsID INTEGER NOT NULL,
    Gehalt DECIMAL(10,2) CHECK (Gehalt > 0),
    FOREIGN KEY (AbteilungsID) REFERENCES Abteilungen(AbteilungsID)
);

-- Transaktion, die Konsistenz wahrt
BEGIN TRANSACTION;
    INSERT INTO Abteilungen (AbteilungsID, Name) VALUES (42, 'Entwicklung');
    INSERT INTO Mitarbeiter (MitarbeiterID, Name, AbteilungsID, Gehalt) 
    VALUES (1001, 'Max Mustermann', 42, 5000.00);
COMMIT;
```

### Was passiert, wenn Konsistenz nicht gewährleistet ist?

Ohne Konsistenzprüfungen könnte die Datenbank in unerwünschte Zustände geraten:

- **Referentielle Integrität verletzt**: Mitarbeiter könnten nicht-existierenden Abteilungen zugeordnet werden
- **Geschäftsregeln verletzt**: Konten könnten über ihr Limit hinaus überzogen werden
- **Ungültige Daten**: Negative Altersangaben oder Preise könnten gespeichert werden

## Isolation (Isolation)

### Warum ist Isolation wichtig?

Stell dir vor, zwei Bankmitarbeiter bearbeiten gleichzeitig das gleiche Kundenkonto. Der erste prüft den Kontostand (1000 CHF) und beginnt eine Abbuchung von 800 CHF. Bevor er die Abbuchung abschliesst, prüft der zweite Mitarbeiter ebenfalls den Kontostand (noch immer 1000 CHF) und beginnt eine Abbuchung von 500 CHF. Wenn beide Transaktionen ohne geeignete Isolation durchgeführt werden, könnte das Konto am Ende 200 CHF statt -300 CHF enthalten – eine klare Inkonsistenz.

Isolation stellt sicher, dass gleichzeitig laufende Transaktionen sich nicht gegenseitig beeinflussen. Jede Transaktion sieht die Datenbank, als ob sie die einzige wäre, die gerade ausgeführt wird.

### Was bedeutet Isolation genau?

Isolation bedeutet, dass gleichzeitig ablaufende Transaktionen voneinander getrennt sind. Die Auswirkungen einer noch nicht abgeschlossenen Transaktion sind für andere Transaktionen nicht sichtbar. Dadurch werden Probleme wie "Dirty Reads", "Non-repeatable Reads" und "Phantom Reads" vermieden {cite}`microsoft_acid`.

```{mermaid}
sequenceDiagram
    participant A as Transaktion A
    participant DB as Datenbank
    participant B as Transaktion B
    
    A->>DB: BEGIN TRANSACTION
    B->>DB: BEGIN TRANSACTION
    A->>DB: UPDATE Konten SET Kontostand = Kontostand - 800 WHERE KontoID = 12345
    Note over DB: Kontostand intern auf 200 CHF gesetzt
    B->>DB: SELECT Kontostand FROM Konten WHERE KontoID = 12345
    DB-->>B: 1000 CHF (isolation verhindert Sichtbarkeit der Änderung aus Transaktion A)
    B->>DB: UPDATE Konten SET Kontostand = Kontostand - 500 WHERE KontoID = 12345
    Note over DB: Transaktion B sieht immer noch 1000 CHF, setzt also auf 500 CHF
    A->>DB: COMMIT
    Note over DB: Änderung von A wird permanent
    B->>DB: COMMIT
    Note over DB: Konflikterkennung verhindert Commit von B (oder setzt neuen Wert auf -300 CHF, je nach Isolationsebene)
```

### Wie wird Isolation implementiert?

Datenbanken implementieren Isolation durch verschiedene Mechanismen:

1. **Sperren (Locking)**: Daten können während einer Transaktion für andere gesperrt werden
2. **Multiversion Concurrency Control (MVCC)**: Mehrere Versionen eines Datensatzes werden vorgehalten
3. **Isolationsebenen**: Verschiedene Stufen der Isolation mit unterschiedlichen Garantien:
   - **READ UNCOMMITTED**: Niedrigste Stufe, erlaubt "Dirty Reads"
   - **READ COMMITTED**: Verhindert "Dirty Reads"
   - **REPEATABLE READ**: Verhindert "Non-repeatable Reads"
   - **SERIALIZABLE**: Höchste Stufe, verhindert auch "Phantom Reads"

In SQL können wir die Isolationsebene festlegen:

```sql
-- Isolation auf höchster Stufe setzen
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Transaktion starten
BEGIN TRANSACTION;
    -- Operationen...
COMMIT;
```

### Was passiert, wenn Isolation nicht gewährleistet ist?

Ohne ausreichende Isolation können folgende Probleme auftreten:

- **Dirty Reads**: Lesen von noch nicht festgeschriebenen (und potenziell zurückgerollten) Änderungen
- **Non-repeatable Reads**: Wiederholtes Lesen derselben Daten liefert unterschiedliche Ergebnisse
- **Phantom Reads**: Neue Datensätze erscheinen in wiederholten Abfragen
- **Lost Updates**: Eine Transaktion überschreibt Änderungen einer anderen Transaktion

## Dauerhaftigkeit (Durability)

### Warum ist Dauerhaftigkeit wichtig?

Stell dir vor, du tätigst eine wichtige Banküberweisung, erhältst eine Bestätigung und kurz darauf stürzt das System ab. Nach dem Neustart des Systems ist die Überweisung verschwunden. Dieses Szenario wäre inakzeptabel für ein zuverlässiges Datenbanksystem.

Dauerhaftigkeit garantiert, dass einmal festgeschriebene (committed) Transaktionen permanent sind und auch bei Systemausfällen nicht verloren gehen.

### Was bedeutet Dauerhaftigkeit genau?

Dauerhaftigkeit bedeutet, dass die Auswirkungen einer erfolgreich abgeschlossenen Transaktion dauerhaft in der Datenbank gespeichert werden – selbst bei Stromausfällen, Abstürzen oder Hardwarefehlern. Das System muss Mechanismen implementieren, die sicherstellen, dass Daten nach einem COMMIT nicht verloren gehen können {cite}`postgres_transactions`.

```{mermaid}
graph TD
    A[Transaktion] --> B{COMMIT}
    B -->|Erfolg| C[In Transaktionslog schreiben]
    C --> D[Daten auf Festplatte sichern]
    D --> E[Dauerhaft gespeichert]
    B -->|Fehler| F[Transaktion fehlgeschlagen]
    G[Systemabsturz] --> H[Wiederherstellung]
    H --> I[Transaktionslog lesen]
    I --> J[Commits wiederherstellen]
    I --> K[Unvollständige Transaktionen rückgängig machen]
    style A fill:#d4f1f9
    style B fill:#ffe6cc
    style C fill:#d5e8d4
    style D fill:#d5e8d4
    style E fill:#d5e8d4
    style F fill:#f8cecc
    style G fill:#f8cecc
    style H fill:#ffe6cc
    style I fill:#ffe6cc
    style J fill:#d5e8d4
    style K fill:#ffe6cc
```

### Wie wird Dauerhaftigkeit implementiert?

Datenbanksysteme setzen verschiedene Techniken ein, um Dauerhaftigkeit zu gewährleisten:

1. **Write-Ahead Logging (WAL)**: Änderungen werden zuerst in ein Log geschrieben, bevor sie in die eigentlichen Datendateien geschrieben werden
2. **Checkpoints**: Regelmässiges Schreiben von konsistenten Datenbankzuständen auf die Festplatte
3. **Transaktionslogs**: Detaillierte Aufzeichnung aller Änderungen für die Wiederherstellung
4. **Redundanz**: Mehrfache Speicherung wichtiger Informationen (z.B. durch Replikation oder RAID-Systeme)

Beispiel für PostgreSQL WAL-Konfiguration:

```sql
-- Konfigurieren der Write-Ahead Logging Einstellungen
ALTER SYSTEM SET wal_level = 'replica';  -- Höheres WAL-Level für Replikation
ALTER SYSTEM SET synchronous_commit = 'on';  -- Synchrones Committen für maximale Sicherheit
```

### Was passiert, wenn Dauerhaftigkeit nicht gewährleistet ist?

Ohne Dauerhaftigkeit könnten folgende Probleme auftreten:

- **Datenverlust**: Bei Systemabstürzen gehen Transaktionen verloren
- **Inkonsistente Wiederherstellung**: Das System kann nach einem Absturz nicht in einen konsistenten Zustand zurückkehren
- **Mangelnde Vertrauenswürdigkeit**: Benutzer können sich nicht auf die Persistenz ihrer Daten verlassen

## Zusammenfassung der ACID-Eigenschaften

Die vier ACID-Eigenschaften arbeiten zusammen, um die Zuverlässigkeit und Integrität von Datenbanktransaktionen zu gewährleisten:

| Eigenschaft | Bedeutung | Hauptprobleme ohne diese Eigenschaft |
|-------------|-----------|--------------------------------------|
| **A**tomarität | Transaktion ist unteilbar - ganz oder gar nicht | Teilweise durchgeführte Operationen, inkonsistente Daten |
| **C**onsistency (Konsistenz) | Datenbank bleibt in validem Zustand | Verletzung von Geschäftsregeln, ungültige Daten |
| **I**solation | Transaktionen beeinflussen sich nicht gegenseitig | Dirty Reads, Lost Updates, Race Conditions |
| **D**urability (Dauerhaftigkeit) | Gespeicherte Änderungen bleiben erhalten | Datenverlust bei Systemausfällen |

Das ACID-Paradigma ist besonders für geschäftskritische Anwendungen mit hohen Anforderungen an Datenkonsistenz und Zuverlässigkeit unverzichtbar. In unserem nächsten Abschnitt werden wir uns im Detail anschauen, wie Transaktionen in der Praxis umgesetzt werden und welche SQL-Befehle zur Transaktionssteuerung zur Verfügung stehen.
