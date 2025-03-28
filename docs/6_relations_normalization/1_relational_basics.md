# Grundlagen des relationalen Modells

## Warum relationale Datenmodelle?

Wenn wir über relationale Datenbanken sprechen, ist es wichtig, die grundlegenden Konzepte und Terminologie zu verstehen, die das mathematische Fundament dieses Modells bilden. Das relationale Datenbankmodell wurde 1970 von Dr. Edgar F. Codd entwickelt und hat seither die Art und Weise, wie wir Daten speichern und verwalten, revolutioniert. Doch warum hat sich dieses Modell so erfolgreich durchgesetzt?

Die Stärke des relationalen Modells liegt in seiner klaren mathematischen Grundlage und der einfachen tabellarischen Darstellung von Daten. Es ermöglicht:

- **Konsistenz und Integrität**: Durch definierte Regeln und Beziehungen wird die Qualität der Daten gesichert
- **Flexibilität**: Daten können auf vielfältige Weise abgefragt und kombiniert werden
- **Unabhängigkeit**: Die physische Speicherung der Daten ist von ihrer logischen Struktur getrennt
- **Vermeidung von Redundanz**: Durch Normalisierung werden unnötige Wiederholungen vermieden

Bevor wir uns mit komplexeren Konzepten wie der Normalisierung befassen, müssen wir zunächst die grundlegenden Bausteine des relationalen Modells verstehen.

## Die Sprache des relationalen Modells

### Relation (Tabelle)

Eine **Relation** ist die mathematische Bezeichnung für das, was wir in der Praxis als Tabelle kennen. Sie repräsentiert eine Sammlung von Informationen über eine bestimmte Entität (z.B. Person, Produkt, Ereignis). Jede Relation hat einen eindeutigen Namen und besteht aus Zeilen und Spalten.

Im Gegensatz zum allgemeinen Sprachgebrauch hat eine Relation im mathematischen Sinne besondere Eigenschaften:
- Die Reihenfolge der Zeilen (Tupel) ist nicht relevant
- Jede Zeile ist eindeutig (keine Duplikate)
- Die Werte in den Zellen sind atomar (nicht weiter zerlegbar)

### Tupel (Zeile)

Ein **Tupel** entspricht einer Zeile in einer Tabelle und repräsentiert einen einzelnen Datensatz oder eine Instanz der Entität. Zum Beispiel würde in einer Relation "Person" jedes Tupel die Daten einer bestimmten Person enthalten.

### Attribut (Spalte)

Ein **Attribut** entspricht einer Spalte in einer Tabelle und repräsentiert eine bestimmte Eigenschaft oder ein Merkmal der Entität. Beispiele für Attribute in einer "Person"-Relation könnten "Name", "Geburtsdatum" oder "Adresse" sein.

### Domäne (Wertebereich)

Eine **Domäne** definiert den zulässigen Wertebereich für ein Attribut. Sie kann als die Menge aller möglichen Werte verstanden werden, die ein Attribut annehmen kann. In SQL wird die Domäne hauptsächlich durch Datentypen und Constraints definiert.

## Beispiel aus der Praxis

Betrachten wir die Relation "Person" aus unserer Verein-Datenbank:

| PersID   | Name   | Vorname | Strasse_Nr  | PLZ  | Ort  | bezahlt | Eintritt   | Austritt   | StatID   | MentorID  |
|----------|--------|---------|-------------|------|-------|--------|------------|------------|----------|-----------|
| 123e4567 | Müller | Hans    | Hauptstr. 1 | 3000 | Bern  | J      | 2020-01-15 | NULL       | abc12345 | NULL      |
| 234f6789 | Weber  | Anna    | Bahnweg 5   | 8000 | Zürich| J      | 2019-06-01 | NULL       | abc12345 | 123e4567  |

In diesem Beispiel:
- "Person" ist die **Relation** (Tabelle)
- Die Zeilen sind **Tupel** (Datensätze) - jede Zeile repräsentiert eine individuelle Person
- Die Spaltenüberschriften sind **Attribute** (Eigenschaften der Entität)
- Die Domäne des Attributs "PLZ" wären alle gültigen Schweizer Postleitzahlen

## Schlüsselkonzepte

Im relationalen Modell spielen Schlüssel eine zentrale Rolle für die Identifikation von Tupeln und die Herstellung von Beziehungen zwischen Relationen.

### Primärschlüssel

Ein **Primärschlüssel** ist ein Attribut (oder eine Kombination von Attributen), das jeden Datensatz in einer Relation eindeutig identifiziert. In unserem Beispiel ist "PersID" der Primärschlüssel der Person-Relation. Primärschlüssel müssen folgende Eigenschaften haben:

- **Eindeutigkeit**: Jeder Wert muss innerhalb der Relation einzigartig sein
- **Nicht-Nullwerte**: Ein Primärschlüssel darf keine NULL-Werte enthalten
- **Unveränderlichkeit**: Der Wert sollte sich idealerweise nicht ändern (Stabilität)

### Fremdschlüssel

Ein **Fremdschlüssel** ist ein Attribut (oder eine Kombination von Attributen), das auf den Primärschlüssel einer anderen (oder derselben) Relation verweist. Fremdschlüssel stellen Beziehungen zwischen Relationen her und sind entscheidend für die Datenintegrität.

In unserem Beispiel ist "StatID" ein Fremdschlüssel, der auf die Relation "Status" verweist, während "MentorID" ein selbstreferenzierender Fremdschlüssel ist, der auf dieselbe Relation "Person" verweist.

### Kandidatenschlüssel

Ein **Kandidatenschlüssel** ist ein Attribut (oder eine Kombination von Attributen), das als Primärschlüssel dienen könnte, da es die Eigenschaften der Eindeutigkeit und Nicht-Nullwerte erfüllt. Eine Relation kann mehrere Kandidatenschlüssel haben, aber nur einer wird als Primärschlüssel ausgewählt.

### Zusammengesetzter Schlüssel

Ein **zusammengesetzter Schlüssel** besteht aus mehreren Attributen, die gemeinsam als Primär- oder Fremdschlüssel fungieren. Dies wird oft verwendet, wenn kein einzelnes Attribut eindeutig ist.

Ein Beispiel aus unserer Verein-Datenbank wäre die Teilnehmer-Tabelle, in der die Kombination aus "PersID" und "AnlaID" den Primärschlüssel bildet:

| PersID   | AnlaID   | Anmeldung  |
|----------|----------|------------|
| 123e4567 | a987654  | 2020-01-10 |
| 234f6789 | a987654  | 2020-01-12 |
| 123e4567 | b765432  | 2020-02-01 |


## Constraints (Integritätsbedingungen)

Constraints sind Regeln, die sicherstellen, dass die in der Datenbank gespeicherten Daten den definierten Geschäftsregeln entsprechen. Sie sind entscheidend für die Wahrung der Datenintegrität.

### Entitätsintegrität

**Entitätsintegrität** stellt sicher, dass jedes Tupel in einer Relation eindeutig identifizierbar ist. Dies wird hauptsächlich durch die Primärschlüsselbedingung erreicht:

```sql
CREATE TABLE Person (
    PersID UUID PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    ...
);
```

### Referenzielle Integrität

**Referenzielle Integrität** gewährleistet, dass Beziehungen zwischen Relationen konsistent bleiben. Wenn ein Fremdschlüssel auf einen Primärschlüssel verweist, muss sichergestellt werden, dass der referenzierte Wert tatsächlich existiert:

```sql
CREATE TABLE Person (
    ...
    -- Kurznotation
    StatID UUID NOT NULL REFERENCES Status (StatID),
    -- Langnotation
    StatID UUID NOT NULL,
    CONSTRAINT fk_Person_StatID FOREIGN KEY (StatID) REFERENCES Status (StatID),
    ...
);
```

### Domänenintegrität

**Domänenintegrität** stellt sicher, dass alle Werte in einer Spalte den definierten Einschränkungen entsprechen. Dies umfasst Datentypen, CHECK-Constraints, NOT NULL-Constraints und mehr:

```sql
CREATE TABLE Person (
    ...
    -- Kurznotation
    Preis NUMERIC CHECK (Preis > 0),
    -- Langnotation
    bezahlt CHAR(1) NOT NULL DEFAULT 'N',
    CONSTRAINT ck_Person_bezahlt CHECK (bezahlt = 'N' OR bezahlt = 'J'),
    Eintritt DATE,
    Austritt DATE,
    CONSTRAINT ck_Person_Austritt CHECK (Austritt IS NULL OR (Eintritt <= Austritt))
    ...
);
```

## Das relationale Modell in der Praxis

In der praktischen Anwendung werden die mathematischen Konzepte des relationalen Modells durch SQL-Datenbanksysteme wie PostgreSQL implementiert. Dabei entsprechen:

- Relationen → Tabellen
- Tupel → Zeilen
- Attribute → Spalten
- Domänen → Datentypen + Constraints

Die SQL-Befehle, die wir im vorherigen Kapitel kennengelernt haben, operieren auf diesen Strukturen. Zum Beispiel:

- `SELECT` wählt bestimmte Attribute (Spalten) und Tupel (Zeilen) aus einer Relation (Tabelle) aus
- `INSERT` fügt ein neues Tupel (Zeile) in eine Relation (Tabelle) ein
- `UPDATE` ändert die Werte von Attributen (Spalten) in bestimmten Tupeln (Zeilen)
- `DELETE` entfernt Tupel (Zeilen) aus einer Relation (Tabelle)

## Fazit

Das Verständnis des relationalen Modells und seiner Terminologie bildet die Grundlage für effektives Datenbankdesign. Indem wir Daten in Relationen organisieren und durch Schlüssel miteinander verbinden, können wir komplexe Informationsstrukturen auf eine logische und effiziente Weise darstellen.

Im nächsten Abschnitt werden wir uns mit den verschiedenen Arten von Beziehungen zwischen Relationen befassen und lernen, wie wir diese im Entity-Relationship-Modell darstellen und in SQL implementieren können.
