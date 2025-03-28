# Der Normalisierungsprozess

## Warum Normalisierung?

Nachdem wir die Probleme bei schlecht strukturierten Datenbanken kennengelernt haben, betrachten wir nun den Lösungsansatz: die **Normalisierung**. Dieser systematische Prozess hilft uns, eine Datenbank so zu strukturieren, dass Redundanzen minimiert und Anomalien vermieden werden.

Die Normalisierung wurde in den 1970er Jahren von Edgar F. Codd als Teil seiner relationalen Datenbanktheorie entwickelt. Sie basiert auf dem Konzept der **funktionalen Abhängigkeiten** und definiert verschiedene **Normalformen**, die zunehmend strengere Anforderungen an die Struktur einer Datenbank stellen.

Der Normalisierungsprozess besteht aus mehreren Schritten, wobei jeder Schritt eine Tabelle in eine bestimmte Normalform überführt. Die am häufigsten verwendeten Normalformen sind:

1. Erste Normalform (1NF)
2. Zweite Normalform (2NF)
3. Dritte Normalform (3NF)

Es gibt weitere Normalformen (BCNF, 4NF, 5NF), aber für die meisten praktischen Anwendungen ist die dritte Normalform ausreichend.

## Funktionale Abhängigkeiten

Bevor wir uns mit den Normalformen befassen, müssen wir das Konzept der **funktionalen Abhängigkeit** verstehen, das die theoretische Grundlage für die Normalisierung bildet.

Eine funktionale Abhängigkeit besteht, wenn der Wert eines Attributs oder einer Attributmenge den Wert eines anderen Attributs oder einer Attributmenge eindeutig bestimmt.

Formell ausgedrückt: In einer Relation R determiniert ein Attribut A ein Attribut B (geschrieben als A → B), wenn zu jedem Wert von A genau ein Wert von B gehört.

### Beispiele für funktionale Abhängigkeiten:

- In einer Mitgliedertabelle determiniert die Mitglieder-ID alle anderen Attribute des Mitglieds: `MitgliedID → Name, Vorname, Adresse, ...`
- In einer Produkttabelle determiniert die Produkt-ID den Produktnamen und den Preis: `ProduktID → Produktname, Preis`
- In einer Tabelle mit Postleitzahlen determiniert die Postleitzahl den Ort: `PLZ → Ort`

### Arten von Abhängigkeiten

Für die Normalisierung sind besonders folgende Arten von Abhängigkeiten wichtig:

1. **Volle funktionale Abhängigkeit**: B ist voll funktional abhängig von A, wenn B von A abhängig ist, aber von keiner echten Teilmenge von A.
2. **Partielle Abhängigkeit**: B ist partiell abhängig von A, wenn B von einer echten Teilmenge von A abhängig ist.
3. **Transitive Abhängigkeit**: Wenn A → B und B → C, dann besteht eine transitive Abhängigkeit A → C.

Mit diesem Verständnis können wir nun die verschiedenen Normalformen betrachten.

## Erste Normalform (1NF)

Die **erste Normalform (1NF)** ist der grundlegendste Schritt im Normalisierungsprozess. Eine Relation ist in 1NF, wenn:

1. Alle Attribute atomar (nicht weiter zerlegbar) sind
2. Keine wiederholenden Gruppen oder Arrays existieren
3. Jede Zeile einen eindeutigen Identifikator (Primärschlüssel) hat

### Beispiel für die Verletzung der 1NF:

Betrachten wir folgende Tabelle, die Kurse und deren Teilnehmer auflistet:

| KursID | Kursname      | Teilnehmer                         |
|--------|---------------|-----------------------------------|
| K1     | Datenbanken   | Hans Müller, Anna Schmidt         |
| K2     | Webdesign     | Peter Meier, Lisa Weber, Max Kim  |

Diese Tabelle verletzt die 1NF, weil das Attribut "Teilnehmer" nicht atomar ist – es enthält mehrere Werte in einer Zelle.

### Überführung in die 1NF:

Um die Tabelle in 1NF zu überführen, müssen wir das nicht-atomare Attribut auflösen:

| KursID | Kursname      | Teilnehmer    |
|--------|---------------|---------------|
| K1     | Datenbanken   | Hans Müller   |
| K1     | Datenbanken   | Anna Schmidt  |
| K2     | Webdesign     | Peter Meier   |
| K2     | Webdesign     | Lisa Weber    |
| K2     | Webdesign     | Max Kim       |

Jetzt enthält jede Zelle nur einen atomaren Wert. Der Primärschlüssel könnte eine Kombination aus KursID und Teilnehmer sein oder ein neuer künstlicher Schlüssel.

## Zweite Normalform (2NF)

Die **zweite Normalform (2NF)** baut auf der 1NF auf und adressiert partielle Abhängigkeiten. Eine Relation ist in 2NF, wenn sie:

1. In 1NF ist
2. Alle Nicht-Schlüssel-Attribute voll funktional abhängig vom Primärschlüssel sind

Die 2NF betrifft nur Relationen mit zusammengesetztem Primärschlüssel. Wenn der Primärschlüssel aus nur einem Attribut besteht, ist die Relation automatisch in 2NF, wenn sie in 1NF ist.

### Beispiel für die Verletzung der 2NF:

Betrachten wir unsere Tabelle aus dem 1NF-Beispiel, wobei (KursID, Teilnehmer) der Primärschlüssel ist:

| KursID | Kursname      | Teilnehmer    | TeilnehmerEmail | Kursort                  |
|--------|---------------|---------------|-----------------|--------------------------|
| K1     | Datenbanken   | Hans Müller   | hans@mail.com   | Raum 101, Hauptgebäude  |
| K1     | Datenbanken   | Anna Schmidt  | anna@mail.com   | Raum 101, Hauptgebäude  |
| K2     | Webdesign     | Peter Meier   | peter@mail.com  | Raum 203, Nebengebäude  |
| K2     | Webdesign     | Lisa Weber    | lisa@mail.com   | Raum 203, Nebengebäude  |
| K2     | Webdesign     | Max Kim       | max@mail.com    | Raum 203, Nebengebäude  |

Hier verletzt die Tabelle die 2NF, weil:
- "Kursname" und "Kursort" hängen nur von "KursID" ab, nicht vom gesamten Primärschlüssel (KursID, Teilnehmer)
- "TeilnehmerEmail" hängt nur von "Teilnehmer" ab, nicht vom gesamten Primärschlüssel

### Überführung in die 2NF:

Um die Tabelle in 2NF zu überführen, müssen wir sie in mehrere Tabellen aufteilen, sodass jede Tabelle die partielle Abhängigkeit beseitigt:

**Kurs-Tabelle**:

| KursID | Kursname      | Kursort                 |
|--------|---------------|-------------------------|
| K1     | Datenbanken   | Raum 101, Hauptgebäude |
| K2     | Webdesign     | Raum 203, Nebengebäude |

**Teilnehmer-Tabelle**:

| Teilnehmer    | TeilnehmerEmail |
|---------------|-----------------|
| Hans Müller   | hans@mail.com   |
| Anna Schmidt  | anna@mail.com   |
| Peter Meier   | peter@mail.com  |
| Lisa Weber    | lisa@mail.com   |
| Max Kim       | max@mail.com    |

**Kurs-Teilnehmer-Tabelle**:

| KursID | Teilnehmer    |
|--------|---------------|
| K1     | Hans Müller   |
| K1     | Anna Schmidt  |
| K2     | Peter Meier   |
| K2     | Lisa Weber    |
| K2     | Max Kim       |

Jetzt sind in jeder Tabelle alle Nicht-Schlüssel-Attribute voll funktional abhängig vom Primärschlüssel.

## Dritte Normalform (3NF)

Die **dritte Normalform (3NF)** adressiert transitive Abhängigkeiten. Eine Relation ist in 3NF, wenn sie:

1. In 2NF ist
2. Keine transitiven Abhängigkeiten enthält

Eine transitive Abhängigkeit liegt vor, wenn ein Nicht-Schlüssel-Attribut von einem anderen Nicht-Schlüssel-Attribut abhängig ist.

### Beispiel für die Verletzung der 3NF:

Betrachten wir folgende Tabelle mit Mitgliedern eines Vereins:

| MitgliedID | Name   | Vorname | PLZ  | Ort    |
|------------|--------|---------|------|--------|
| 1          | Müller | Hans    | 3000 | Bern   |
| 2          | Weber  | Anna    | 3000 | Bern   |
| 3          | Meier  | Peter   | 8000 | Zürich |

Hier verletzt die Tabelle die 3NF, weil:
- "Ort" hängt transitiv von "MitgliedID" über "PLZ" ab: `MitgliedID → PLZ → Ort`
- Es besteht eine funktionale Abhängigkeit `PLZ → Ort`

### Überführung in die 3NF:

Um die Tabelle in 3NF zu überführen, müssen wir die transitive Abhängigkeit beseitigen:

**Mitglied-Tabelle**:

| MitgliedID | Name   | Vorname | PLZ  |
|------------|--------|---------|------|
| 1          | Müller | Hans    | 3000 |
| 2          | Weber  | Anna    | 3000 |
| 3          | Meier  | Peter   | 8000 |

**PLZ-Tabelle**:

| PLZ  | Ort    |
|------|--------|
| 3000 | Bern   |
| 8000 | Zürich |

Jetzt sind in beiden Tabellen alle Nicht-Schlüssel-Attribute direkt vom Primärschlüssel abhängig, und es gibt keine transitiven Abhängigkeiten mehr.

## Boyce-Codd-Normalform (BCNF)

Die **Boyce-Codd-Normalform (BCNF)** ist eine strengere Version der 3NF. Eine Relation ist in BCNF, wenn:

1. Sie in 3NF ist
2. Für jede funktionale Abhängigkeit X → Y (wobei Y kein Teil von X ist) ist X ein Superschlüssel

Einfacher ausgedrückt: Jedes Attribut, von dem andere Attribute abhängen, muss ein Kandidatenschlüssel sein.

Die BCNF wird in der Praxis seltener angewendet als die 3NF, ist aber in einigen Situationen nützlich, um weitere Anomalien zu beseitigen.

## Weiterführende Normalformen

Es gibt noch weitere Normalformen (4NF, 5NF/PJNF, 6NF), die sich mit spezielleren Arten von Abhängigkeiten befassen. Diese sind jedoch für die meisten praktischen Anwendungen weniger relevant und werden hier nur der Vollständigkeit halber erwähnt.

- Die **vierte Normalform (4NF)** behandelt mehrwertige Abhängigkeiten
- Die **fünfte Normalform (5NF)** oder **Projekt-Join-Normalform (PJNF)** behandelt Join-Abhängigkeiten
- Die **sechste Normalform (6NF)** ist die strengste Normalform und behandelt temporale Daten

## Fallstudie: Schrittweise Normalisierung einer denormalisierten Tabelle

Um den Normalisierungsprozess zu veranschaulichen, normalisieren wir schrittweise eine denormalisierte Tabelle für einen Sportverein:

### Ausgangstabelle (Denormalisiert):

| MitID| Name    | Vorname | Adresse     | StatusBez | StatusBeitrag | FunktionBez | Funktion_Seit | AnlassBez   | Anlass_Datum |
|------|---------|---------|-------------|-----------|---------------|-------------|---------------|-------------|--------------|
| 1    | Müller  | Hans    | Hauptstr. 1 | Aktiv     | 100           | Präsident   | 2020-01-01    | Sommerfest  | 2024-07-15   |
| 1    | Müller  | Hans    | Hauptstr. 1 | Aktiv     | 100           | Präsident   | 2020-01-01    | Jahresfeier | 2024-12-10   |
| 1    | Müller  | Hans    | Hauptstr. 1 | Aktiv     | 100           | Trainer     | 2018-06-15    | Sommerfest  | 2024-07-15   |
| 2    | Weber   | Anna    | Seeweg 5    | Aktiv     | 100           | Kassier     | 2019-03-10    | Sommerfest  | 2024-07-15   |
| 3    | Schmidt | Peter   | Bergstr. 12 | Passiv    | 50            | NULL        | NULL          | NULL        | NULL         |

### Schritt 1: Überführung in die 1NF

Die Tabelle ist bereits in 1NF, da:
- Alle Attribute atomar sind
- Keine wiederholenden Gruppen vorhanden sind
- Die Tabelle einen Primärschlüssel hat (z.B. könnte man (MitID, FunktionBez, AnlassBez) als zusammengesetzten Primärschlüssel verwenden)

### Schritt 2: Überführung in die 2NF

Wir identifizieren partielle Abhängigkeiten:
- Die Mitgliederdaten (Name, Vorname, Adresse) hängen nur von MitID ab
- Die Statusdaten (StatusBez, StatusBeitrag) hängen nur vom Status ab
- Die Funktionsdaten (FunktionBez) hängen nur von der Funktion ab
- Die Anlassdaten (AnlassBez, Anlass_Datum) hängen nur vom Anlass ab

Wir teilen die Tabelle entsprechend auf:

**Mitglied-Tabelle**:

| MitID | Name    | Vorname | Adresse     | StatusID |
|-------|---------|---------|-------------|----------|
| 1     | Müller  | Hans    | Hauptstr. 1 | 1        |
| 2     | Weber   | Anna    | Seeweg 5    | 1        |
| 3     | Schmidt | Peter   | Bergstr. 12 | 2        |

**Status-Tabelle**:

| StatusID | StatusBez | StatusBeitrag |
|----------|-----------|---------------|
| 1        | Aktiv     | 100           |
| 2        | Passiv    | 50            |

**Funktion-Tabelle**:

| FunktionID | FunktionBez |
|------------|-------------|
| 1          | Präsident   |
| 2          | Kassier     |
| 3          | Trainer     |

**Mitglied-Funktion-Tabelle**:

| MitID | FunktionID | Funktion_Seit |
|-------|------------|---------------|
| 1     | 1          | 2020-01-01    |
| 1     | 3          | 2018-06-15    |
| 2     | 2          | 2019-03-10    |

**Anlass-Tabelle**:

| AnlassID | AnlassBez    | Anlass_Datum |
|----------|--------------|--------------|
| 1        | Sommerfest   | 2024-07-15   |
| 2        | Jahresfeier  | 2024-12-10   |

**Mitglied-Anlass-Tabelle**:

| MitID | AnlassID |
|-------|----------|
| 1     | 1        |
| 1     | 2        |
| 2     | 1        |

### Schritt 3: Überführung in die 3NF

Wir prüfen auf transitive Abhängigkeiten. In diesem Beispiel gibt es keine offensichtlichen transitiven Abhängigkeiten in den bereits erstellten Tabellen. Alle Tabellen erfüllen somit bereits die Anforderungen der 3NF.

Wenn es beispielsweise eine Abhängigkeit `PLZ → Ort` gäbe, müssten wir diese in eine separate Tabelle auslagern, wie im vorherigen 3NF-Beispiel gezeigt.

## Praktische Überlegungen zur Normalisierung

Während der Normalisierungsprozess in der Theorie klar definiert ist, gibt es in der Praxis einige wichtige Überlegungen:

### Vorteile der Normalisierung

1. **Reduzierte Redundanz**: Jede Information wird nur einmal gespeichert
2. **Verbesserte Datenintegrität**: Weniger Risiko für Inkonsistenzen
3. **Flexiblere Datenstruktur**: Leichtere Erweiterbarkeit des Schemas
4. **Einfachere Updates**: Änderungen müssen nur an einer Stelle vorgenommen werden

### Nachteile der Normalisierung

1. **Komplexere Abfragen**: Joins zwischen mehreren Tabellen können notwendig sein
2. **Potenzielle Performance-Einbussen**: Joins können bei grossen Datenmengen langsamer sein
3. **Höhere Komplexität des Schemas**: Mehr Tabellen und Beziehungen zu verwalten

### Denormalisierung: Der bewusste Schritt zurück

In bestimmten Situationen kann es sinnvoll sein, eine vollständig normalisierte Datenbank teilweise zu **denormalisieren**, um die Performance zu verbessern. Denormalisierung bedeutet, bewusst Redundanz einzuführen, um bestimmte Abfragen zu optimieren.

#### Wann ist Denormalisierung sinnvoll?

1. **Leseintensive Anwendungen**: Wenn die Datenbank hauptsächlich für Abfragen verwendet wird
2. **Data Warehousing**: Bei analytischen Datenbanken, wo historische Daten selten geändert werden
3. **Performance-kritische Abfragen**: Wenn bestimmte Abfragen sehr häufig ausgeführt werden
4. **Vermeidung komplexer Joins**: Wenn zu viele Joins die Performance beeinträchtigen

#### Beispiele für Denormalisierung:

1. **Berechnete Spalten**: Speichern von vorberechneten Werten 
   ```sql
   -- Statt bei jeder Abfrage die Summe zu berechnen
   SELECT KundeID, SUM(Betrag) FROM Bestellungen GROUP BY KundeID;
   
   -- Könnte man eine berechnete Spalte "Gesamtumsatz" in der Kundentabelle pflegen
   ```

2. **Redundante Daten**: Speichern von Daten an mehreren Stellen
   ```sql
   -- Statt eines Joins
   SELECT Bestellung.*, Kunde.Name FROM Bestellung JOIN Kunde ON Bestellung.KundeID = Kunde.KundeID;
   
   -- Könnte man den Kundennamen direkt in der Bestellungstabelle speichern
   ```

Wichtig ist: Denormalisierung sollte ein **bewusster Designentscheid** sein, basierend auf gründlicher Analyse und mit Massnahmen, um Dateninkonsistenzen zu vermeiden.

## Fazit

Der Normalisierungsprozess ist ein systematischer Ansatz, um Datenbankschemas zu optimieren, indem Redundanzen eliminiert und Anomalien vermieden werden. Die wichtigsten Normalformen – 1NF, 2NF und 3NF – behandeln jeweils unterschiedliche Arten von Problemen.

In der Praxis ist es wichtig, eine Balance zwischen Normalisierung und Performance zu finden. Für die meisten Anwendungen ist die 3NF ein guter Kompromiss, der die meisten Anomalien beseitigt, ohne die Abfrageperformance zu stark zu beeinträchtigen.

Im nächsten Abschnitt werden wir uns mit der praktischen Umsetzung von Beziehungen in SQL befassen und sehen, wie wir die Erkenntnisse aus der Normalisierung in tatsächliche Datenbankschemas umsetzen können.
