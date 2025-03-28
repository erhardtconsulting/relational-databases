---
theme: hftm
footer: 'Relationen und Beziehungstypen'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>Relationen und Beziehungstypen</h1>
  <p class="date-author">März 2025 | Autor: Simon Erhardt</p>
</div>

---
# Inhaltsverzeichnis
<!--
- Übersicht zum Ablauf der Vorlesung
- Diese Folien dienen als Einstieg für die praktischen Übungen
-->
1. Einführung in relationale Datenmodelle
2. Das Entity-Relationship-Modell
3. Beziehungstypen in Datenbanken
   - 1:1 Beziehungen
   - 1:n Beziehungen
   - n:m Beziehungen
4. Beispiele aus unserer Verein-Datenbank
5. Implementierung von Beziehungen
6. Best Practices für Datenbankdesign
7. Zusammenfassung

---
# Einführung in relationale Datenmodelle
<!--
- Historischer Kontext und Bedeutung des relationalen Modells
- WARUM-Ebene: Warum relationales Modell und nicht etwas anderes?
-->

- Entwickelt von Edgar F. Codd (IBM) in den 1970er Jahren
- Fundamentales Prinzip: Daten in **Relationen** (Tabellen) organisieren
- Jede Tabelle repräsentiert eine **Entität** oder **Beziehung**
- Tabellen bestehen aus:
  - **Attributen** (Spalten)
  - **Tupeln** (Zeilen)
- Jedes Tupel wird durch einen **Primärschlüssel** eindeutig identifiziert
- Verbindungen zwischen Tabellen über **Fremdschlüssel**

---
# Das Entity-Relationship-Modell
<!--
- Visualisierung der Datenbankstruktur
- Erklärung der Komponenten eines ER-Diagramms
-->

- Graphische Darstellung der Datenbankstruktur
- Bestandteile:
  - **Entitäten** (Rechtecke): Reale oder abstrakte Objekte
  - **Attribute** (Ovale/Listen): Eigenschaften von Entitäten
  - **Beziehungen** (Rauten/Linien): Verbindungen zwischen Entitäten
  - **Kardinalitäten** (Zahlensymbole/Notationen): Anzahlverhältnisse

![](img/er-diagram-verein.svg)

---
# Beziehungstypen in Datenbanken: 1:1
<!--
- Detaillierte Erklärung der verschiedenen Beziehungstypen
- Alltagsbeispiele für jeden Typ
-->

## 1:1 Beziehung (Eins-zu-Eins)
- Eine Entität der Tabelle A ist mit **genau einer** Entität der Tabelle B verknüpft
- Beispiele:
  - Person ↔ Personalausweis
  - Ehepartner ↔ Ehepartner
  - Land ↔ Hauptstadt

---
# Beziehungstypen in Datenbanken: 1:n
<!--
- Detaillierte Erklärung der verschiedenen Beziehungstypen
- Alltagsbeispiele für jeden Typ
-->

## 1:n Beziehung (Eins-zu-Viele)
- Eine Entität der Tabelle A kann mit **mehreren** Entitäten der Tabelle B verknüpft sein
- Jede Entität in B ist mit **genau einer** Entität in A verknüpft
- Beispiele:
  - Abteilung ↔ Mitarbeiter
  - Autor ↔ Bücher
  - Verein ↔ Mitglieder

---
# Beziehungstypen in Datenbanken: n:m
<!--
- Detaillierte Erklärung der verschiedenen Beziehungstypen
- Alltagsbeispiele für jeden Typ
-->

## n:m Beziehung (Viele-zu-Viele)
- Eine Entität der Tabelle A kann mit **mehreren** Entitäten der Tabelle B verknüpft sein
- Eine Entität der Tabelle B kann mit **mehreren** Entitäten der Tabelle A verknüpft sein
- Beispiele:
  - Studenten ↔ Kurse
  - Produkte ↔ Bestellungen
  - Schauspieler ↔ Filme

---
# Beispiele aus unserer Verein-Datenbank
<!--
- Konkrete Beispiele aus der Datenbank zeigen
- WIE-Ebene: Wie sind diese Beziehungen implementiert?
-->

- **1:n Beziehung**: Status ↔ Person
  ```sql
  -- Primärschlüssel in Status
  StatID UUID PRIMARY KEY
  
  -- Fremdschlüssel in Person
  StatID UUID REFERENCES Status(StatID)
  ```

- **n:m Beziehung**: Person ↔ Anlass (via Teilnehmer-Tabelle)
  ```sql
  -- Zwischentabelle Teilnehmer
  CREATE TABLE Teilnehmer (
      PersID UUID REFERENCES Person(PersID),
      AnlaID UUID REFERENCES Anlass(AnlaID),
      PRIMARY KEY (PersID, AnlaID)
  );
  ```

---
# Implementierung von Beziehungen: 1:1
<!--
- Konkrete SQL-Implementierung
- Best Practices
-->

```sql
-- Tabelle Mitarbeiter
CREATE TABLE Mitarbeiter (
    MitarbeiterID UUID PRIMARY KEY,
    Name VARCHAR(100),
    Vorname VARCHAR(100),
    Geburtsdatum DATE
);
-- Tabelle Arbeitsplatz (1:1 mit Mitarbeiter)
CREATE TABLE Arbeitsplatz (
    ArbeitsplatzID UUID PRIMARY KEY,
    Raumnummer VARCHAR(10),
    Telefonnummer VARCHAR(20),
    MitarbeiterID UUID UNIQUE REFERENCES Mitarbeiter(MitarbeiterID)
);
```

- UNIQUE-Constraint stellt die 1:1-Beziehung sicher

---
# Implementierung von Beziehungen: 1:n
<!--
- Konkrete SQL-Implementierung
- Best Practices
-->

```sql
-- Tabelle Abteilung
CREATE TABLE Abteilung (
    AbteilungID UUID PRIMARY KEY,
    Bezeichnung VARCHAR(100),
    Kostenstelle VARCHAR(20)
);

-- Tabelle Mitarbeiter (n Mitarbeiter in 1 Abteilung)
CREATE TABLE Mitarbeiter (
    MitarbeiterID UUID PRIMARY KEY,
    Name VARCHAR(100),
    Vorname VARCHAR(100),
    AbteilungID UUID REFERENCES Abteilung(AbteilungID)
);
```

- Fremdschlüssel in der "Viele"-Tabelle

---
# Implementierung von Beziehungen: n:m
<!--
- Konkrete SQL-Implementierung
- Best Practices
-->

<div class="container">
<div class="col">

```sql
-- Tabelle Projekt
CREATE TABLE Projekt (
    ProjektID UUID PRIMARY KEY,
    Bezeichnung VARCHAR(100),
    Startdatum DATE
);

-- Tabelle Mitarbeiter
CREATE TABLE Mitarbeiter (
    MitarbeiterID UUID PRIMARY KEY,
    Name VARCHAR(100),
    Vorname VARCHAR(100)
);
```

</div>
<div class="col">

```
-- Zwischentabelle für n:m Beziehung
CREATE TABLE ProjektMitarbeiter (
    ProjektID UUID REFERENCES Projekt(ProjektID),
    MitarbeiterID UUID REFERENCES Mitarbeiter(MitarbeiterID),
    Rolle VARCHAR(50),
    Stundenbudget INTEGER,
    PRIMARY KEY (ProjektID, MitarbeiterID)
);
```

</div>
</div>

---
# Best Practices für Datenbankdesign
<!--
- Wichtige Regeln für gutes Datenbankdesign
- Balance zwischen Normalisierung und Performance
-->

1. **Primärschlüssel sorgfältig wählen**
   - Stabile, unveränderliche Werte bevorzugen
   - UUID/GUID oder Surrogatschlüssel für bessere Flexibilität

2. **Beziehungstypen korrekt implementieren**
   - 1:1 mit UNIQUE-Constraint
   - 1:n mit einfachem Fremdschlüssel
   - n:m mit Zwischentabelle

3. **Konsistente Namenskonventionen**
   - Einheitliche Benennungsmuster für Tabellen und Spalten
   - Singular für Tabellennamen (Person statt Personen)
   - ID-Suffix für Schlüsselspalten (PersonID)

---
# Zusammenfassung: Relationen
<!--
- Hauptpunkte zusammenfassen
- Hinweis auf nächste Schritte und Übungen
-->

- **Beziehungstypen** bilden das Fundament relationaler Datenbanken:
  - **1:1 Beziehungen**: Eine Entität ist mit genau einer anderen verknüpft
  - **1:n Beziehungen**: Eine Entität kann mit mehreren anderen verknüpft sein
  - **n:m Beziehungen**: Mehrere Entitäten können mit mehreren anderen verknüpft sein

- **Implementierung** von Beziehungen:
  - Verwendung von Primär- und Fremdschlüsseln
  - UNIQUE-Constraints für 1:1 Beziehungen
  - Zwischentabellen für n:m Beziehungen

- **Entity-Relationship-Modell** zur Visualisierung der Datenbankstruktur
