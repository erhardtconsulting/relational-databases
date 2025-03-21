# Ursprünge und Gründe für das ACID-Paradigma

## Warum benötigen wir ACID und Transaktionen?

Stell dir folgendes Szenario vor: Ein Banksystem führt eine Überweisung zwischen zwei Konten durch. Dabei muss zunächst ein Betrag vom Senderkonto abgezogen und anschliessend dem Empfängerkonto gutgeschrieben werden. Was passiert, wenn zwischen diesen beiden Schritten ein Systemabsturz auftritt? Oder wenn gleichzeitig mehrere Überweisungen vom selben Konto stattfinden und der Kontostand plötzlich inkonsistent wird?

Solche Probleme können schwerwiegende Folgen haben:
- Finanzverluste durch verlorene oder doppelt ausgeführte Transaktionen
- Rechtliche Konsequenzen durch fehlerhafte Datenzustände
- Verlust des Kundenvertrauens durch unzuverlässige Systeme

Genau diese Probleme adressieren das ACID-Paradigma und das Konzept der Transaktionen in Datenbanksystemen. Sie sind entscheidend für:
- Die **Zuverlässigkeit** von geschäftskritischen Anwendungen
- Die **Datenkonsistenz** bei Mehrbenutzerzugriff
- Die **Wiederherstellbarkeit** bei Systemfehlern

## Die historische Entwicklung

Die Notwendigkeit für ein zuverlässiges Transaktionsmodell wurde bereits in den frühen 1970er Jahren erkannt, als Datenbanksysteme zunehmend in geschäftskritischen Anwendungen eingesetzt wurden {cite}`elmasri_navathe`.

In den 1960er und frühen 1970er Jahren beherrschten hierarchische Datenbanksysteme wie IBM's IMS den Markt. Diese frühen Systeme boten jedoch nur rudimentäre Mechanismen zur Wahrung der Datenintegrität. Mit dem Aufkommen relationaler Datenbanken, angestossen durch Edgar F. Codds bahnbrechendes Paper von 1970 {cite}`codd_relational`, wurde der Grundstein für ausgereiftere Konzepte gelegt.

Die Notwendigkeit für konsistente Datenbankoperationen, selbst bei Systemausfällen, wurde besonders in Banken, Flugbuchungssystemen und anderen kritischen Anwendungen deutlich, wo inkonsistente Daten katastrophale Folgen haben konnten. Die ersten formalen Konzepte zu Transaktionen entstanden bei IBM im System R Projekt, einem der ersten relationalen Datenbanksysteme {cite}`bernstein_newcomer`.

```{mermaid}
timeline
    title Entwicklung des ACID-Konzepts
    1970 : E.F. Codd's Relationenmodell
    1975 : IBM System R beginnt mit Transaktionskonzepten
    1976 : Jim Gray's Paper über Transaktionsverarbeitung
    1981 : Erste kommerzielle RDBMS mit Transaktionsunterstützung
    1983 : ANSI SQL-Standard mit Transaktionsunterstützung
    1983 : Theo Härder & Andreas Reuter prägen den Begriff ACID
```

Der Begriff "ACID" selbst wurde erst 1983 von Theo Härder und Andreas Reuter in ihrem einflussreichen Paper "Principles of Transaction-Oriented Database Recovery" {cite}`haerder_reuter` geprägt. Sie fassten damit die wesentlichen Eigenschaften zusammen, die ein zuverlässiges Datenbanksystem benötigt. ACID steht für Atomarität (Atomicity), Konsistenz (Consistency), Isolation (Isolation) und Dauerhaftigkeit (Durability).

## Fundamentale Probleme bei gleichzeitigem Datenbankzugriff

In einer Multi-User-Umgebung treten ohne geeignete Mechanismen typischerweise drei Hauptprobleme auf:

### Dirty Read (Unreine Lesevorgänge)
Wenn ein Benutzer Daten liest, die ein anderer Benutzer gerade ändert, aber noch nicht festgeschrieben hat.

```{mermaid}
sequenceDiagram
    actor B1 as Benutzer 1
    participant DB as Datenbank
    actor B2 as Benutzer 2
    
    Note over B1, B2: Kontostand beträgt 1000 CHF
    
    B1->>DB: SELECT Kontostand FROM Konto
    DB-->>B1: Ergebnis: 1000 CHF
    
    B2->>DB: UPDATE Konto SET Kontostand = 800
    Note right of DB: Änderung noch nicht committed!
    
    B1->>DB: SELECT Kontostand FROM Konto
    DB-->>B1: Ergebnis: 800 CHF
    Note left of DB: Liest ungesicherte Daten!
    
    B2->>DB: ROLLBACK
    Note right of DB: Änderung zurückgesetzt
    
    Note over B1: Arbeitet mit Wert (800 CHF),<br>der nie gültig war!
```

### Lost Update (Verlorene Aktualisierungen)
Wenn zwei Benutzer dieselben Daten gleichzeitig aktualisieren und eine Änderung die andere überschreibt.

```{mermaid}
sequenceDiagram
    actor B1 as Benutzer 1
    participant DB as Datenbank
    actor B2 as Benutzer 2
    
    Note over B1, B2: Kontostand beträgt 1000 CHF
    
    B1->>DB: SELECT Kontostand FROM Konto
    DB-->>B1: Ergebnis: 1000 CHF
    B2->>DB: SELECT Kontostand FROM Konto
    DB-->>B2: Ergebnis: 1000 CHF
    
    Note over B1: Berechne: 1000 - 200 = 800
    Note over B2: Berechne: 1000 + 500 = 1500
    
    B1->>DB: UPDATE Konto SET Kontostand = 800
    Note left of DB: Zwischenstand: 800 CHF
    
    B2->>DB: UPDATE Konto SET Kontostand = 1500
    Note right of DB: Endstand: 1500 CHF
    
    Note over B1: Die Abbuchung von 200 CHF<br>wurde überschrieben!
```

### Phantom Read (Phantomlesevorgänge)
Wenn ein Benutzer eine Abfrage mehrmals ausführt und verschiedene Ergebnisse erhält, weil ein anderer Benutzer Datensätze hinzugefügt oder entfernt hat.

```{mermaid}
sequenceDiagram
    actor B1 as Benutzer 1
    participant DB as Datenbank
    actor B2 as Benutzer 2
    
    Note over B1, B2: Abfrage von Benutzer 1 startet
    
    B1->>DB: SELECT COUNT(*) FROM Kunde
    DB-->>B1: Ergebnis: 10 Datensätze
    
    B2->>DB: INSERT INTO Kunde VALUES (...)
    DB-->>B2: 1 Datensatz eingefügt
    
    B1->>DB: SELECT COUNT(*) FROM Kunde
    DB-->>B1: Ergebnis: 11 Datensätze
    Note left of DB: Phantom Read:<br>Plötzlich ein Datensatz mehr!
    
    Note over B1: Inkonsistenz: Die Anzahl der Datensätze<br>hat sich während der Abfrage geändert!
```

## Notwendigkeit einer Lösung

Diese Probleme führten zur Entwicklung des Transaktionskonzepts und der ACID-Eigenschaften als Lösung. Es wurde klar, dass Datenbanksysteme Mechanismen benötigen, die:

1. Operationen als unteilbare Einheiten behandeln (Atomarität)
2. Die Datenbank von einem konsistenten Zustand in einen anderen überführen (Konsistenz)
3. Gleichzeitige Transaktionen voneinander isolieren (Isolation)
4. Einmal festgeschriebene Änderungen dauerhaft speichern (Dauerhaftigkeit)

Das ACID-Paradigma hat sich seither als Goldstandard für transaktionale Systeme etabliert und ist besonders in relationalen Datenbanksystemen wie PostgreSQL, Oracle, MySQL und SQL Server fest verankert. Es bildet die Grundlage für zuverlässige Datenverarbeitung in kritischen Anwendungen und ist ein wesentlicher Grund für den anhaltenden Erfolg relationaler Datenbanken in Unternehmensumgebungen {cite}`metisdata_acid`.

Im nächsten Abschnitt werden wir die vier ACID-Eigenschaften im Detail betrachten und verstehen, wie sie zusammenwirken, um die Datenintegrität zu gewährleisten.
