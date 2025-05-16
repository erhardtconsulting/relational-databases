---
title: "ORM / Aufgabe 1: Transfer-Projekt Datenbankdesign"
author: 
    - Simon Erhardt
date: "16.05.2025"
keywords:
    - ORM
    - Datenbankdesign
    - ER-Diagramm
    - Normalisierung
    - SQL
---

# Fachübergreifendes Transfer-Projekt "Datenbankgestütztes Anwendungssystem"

## Übersicht
In diesem Projekt wendest Du Dein Wissen aus verschiedenen Fachbereichen (Datenbanken, Programmierung, Projektmanagement) an, um ein ganzheitliches datenbankgestütztes System zu konzipieren. Der Fokus liegt auf dem Entwurf eines soliden Datenbankschemas und dessen Visualisierung durch ein ER-Diagramm.

## Ausgangssituation
Die moderne Softwareentwicklung erfordert die Integration verschiedener Technologien. Eine zentrale Rolle spielen dabei Datenbanken, die das Fundament jeder datenintensiven Anwendung bilden. Ein gut durchdachtes Datenbankdesign ist entscheidend für die erfolgreiche Umsetzung des Gesamtsystems.

## Aufgabenstellung
Entwickle ein vollständiges Datenbankschema für eine Anwendung Deiner Wahl. Das Schema soll als Grundlage für eine spätere Implementierung dienen.

Du kannst zwischen folgenden Anwendungsdomänen wählen ODER ein eigenes Thema vorschlagen:
- Projektmanagementsystem (mit Projekten, Aufgaben, Ressourcen, Zeiterfassung)
- E-Commerce-Plattform (mit Produkten, Bestellungen, Kunden, Bewertungen)
- Bildungsmanagementsystem (mit Kursen, Studierenden, Dozenten, Bewertungen)
- Eventmanagementsystem (mit Veranstaltungen, Teilnehmern, Räumen, Buchungen)
- Bibliotheksverwaltung (mit Büchern, Ausleihvorgängen, Mitgliedern, Kategorien)

## Konkrete Teilaufgaben

### 1. Anforderungsanalyse (25%)
- Definiere 5-10 funktionale Anforderungen an dein System
- Beschreibe die Hauptentitäten und deren wichtigste Attribute
- Identifiziere die Beziehungen zwischen den Entitäten und deren Kardinalitäten (1:1, 1:n, n:m)
- Beschreibe Geschäftsregeln, die durch das Datenbankschema abgebildet werden müssen

### 2. Konzeptionelles Datenbankdesign (35%)
- Erstelle ein ER-Diagramm mit allen Entitäten, Attributen und Beziehungen
- Verwende eine standardisierte Notation (Chen, Crow's Foot oder UML)
- Kennzeichne Primärschlüssel, Fremdschlüssel und wichtige Constraints
- Achte auf die korrekte Darstellung der Kardinalitäten
- Verwende aussagekräftige Entitäts- und Attributnamen

### 3. Logisches Datenbankdesign (25%)
- Überführe das ER-Diagramm in ein relationales Datenbankschema
- Normalisiere dein Schema bis zur dritten Normalform (3NF)
- Definiere geeignete Datentypen für alle Attribute
- Dokumentiere Primär- und Fremdschlüssel-Beziehungen
- Beschreibe, wie n:m-Beziehungen durch Zwischentabellen aufgelöst werden

### 4. SQL-Implementierung (15%)
- Erstelle SQL-CREATE-Statements für alle Tabellen
- Definiere Constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK)
- Implementiere Referentielle Integrität durch entsprechende Constraints
- Achte auf die korrekte Reihenfolge der Tabellenerstellung (wegen Fremdschlüssel-Abhängigkeiten)

## Bewertungskriterien

### Anforderungsanalyse (25%)
- **Vollständigkeit der Anforderungen** (0-3 Punkte)
  - 0: Unzureichende Anforderungen, wesentliche Aspekte fehlen
  - 1: Grundlegende Anforderungen vorhanden, aber wichtige Aspekte fehlen
  - 2: Gute Abdeckung der wichtigsten Anforderungen mit kleineren Lücken
  - 3: Umfassende, detaillierte Anforderungen mit klarem Bezug zur Anwendungsdomäne

- **Beschreibung der Entitäten und Attribute** (0-3 Punkte)
  - 0: Entitäten unzureichend beschrieben, wesentliche Attribute fehlen
  - 1: Grundlegende Entitäten identifiziert, aber viele wichtige Attribute fehlen
  - 2: Gute Beschreibung der Entitäten mit den meisten relevanten Attributen
  - 3: Vollständige, präzise Beschreibung aller Entitäten und ihrer Attribute

- **Beziehungen und Kardinalitäten** (0-3 Punkte)
  - 0: Beziehungen nicht oder überwiegend falsch definiert
  - 1: Grundlegende Beziehungen identifiziert, aber viele Fehler bei Kardinalitäten
  - 2: Meiste Beziehungen korrekt mit einigen Fehlern bei Kardinalitäten
  - 3: Alle Beziehungen korrekt identifiziert mit präzisen Kardinalitäten

- **Geschäftsregeln und Konsistenz** (0-3 Punkte)
  - 0: Keine oder unrealistische Geschäftsregeln
  - 1: Wenige grundlegende Geschäftsregeln definiert, teilweise inkonsistent
  - 2: Gute Definition der wichtigsten Geschäftsregeln mit kleineren Inkonsistenzen
  - 3: Umfassende, konsistente Geschäftsregeln mit klarem Praxisbezug

### Konzeptionelles Datenbankdesign (35%)
- **Vollständigkeit des ER-Diagramms** (0-3 Punkte)
  - 0: Unvollständiges Diagramm mit fehlenden wesentlichen Elementen
  - 1: Grundlegendes Diagramm mit mehreren fehlenden Elementen
  - 2: Nahezu vollständiges Diagramm mit wenigen fehlenden Elementen
  - 3: Vollständiges Diagramm mit allen Entitäten, Attributen und Beziehungen

- **Korrektheit und Verständlichkeit der Notation** (0-3 Punkte)
  - 0: Falsche oder inkonsistente Notation, schwer verständlich
  - 1: Grundlegende Notationsregeln befolgt, Verständlichkeit eingeschränkt
  - 2: Korrekte Notation mit guter Verständlichkeit trotz kleinerer Inkonsistenzen
  - 3: Präzise, konsistente und leicht verständliche Anwendung der gewählten Notation

- **Primär- und Fremdschlüssel** (0-3 Punkte)
  - 0: Schlüssel fehlen oder sind durchgehend falsch definiert
  - 1: Grundlegende Schlüsseldefinition mit mehreren Fehlern
  - 2: Meiste Schlüssel korrekt definiert mit wenigen Fehlern
  - 3: Alle Schlüssel korrekt und sinnvoll definiert

- **Darstellung der Kardinalitäten** (0-3 Punkte)
  - 0: Kardinalitäten fehlen oder sind überwiegend falsch
  - 1: Grundlegende Kardinalitäten definiert, aber viele Fehler
  - 2: Meiste Kardinalitäten korrekt mit wenigen Fehlern
  - 3: Alle Kardinalitäten präzise und korrekt dargestellt

- **Entitäts- und Attributnamen** (0-3 Punkte)
  - 0: Verwirrende, inkonsistente oder irreführende Namen
  - 1: Grundlegende Namenskonventionen mit Inkonsistenzen
  - 2: Gute, überwiegend aussagekräftige Namen mit kleineren Inkonsistenzen
  - 3: Durchgehend klare, präzise und konsistente Benennung

### Logisches Datenbankdesign (25%)
- **Überführung in relationales Schema** (0-3 Punkte)
  - 0: Falsche oder unvollständige Überführung
  - 1: Grundlegende Überführung mit mehreren Fehlern
  - 2: Gute Überführung mit kleineren Ungenauigkeiten
  - 3: Korrekte und vollständige Überführung aller Elemente

- **Normalisierungsgrad** (0-3 Punkte)
  - 0: Keine erkennbare Normalisierung oder schwerwiegende Fehler
  - 1: Ansätze zur Normalisierung mit mehreren Problemen
  - 2: Gute Normalisierung (ca. 3NF) mit kleineren Schwächen
  - 3: Vollständige Normalisierung (3NF) mit optimaler Balance zur Praktikabilität

- **Datentypen** (0-3 Punkte)
  - 0: Ungeeignete oder fehlende Datentypen
  - 1: Grundlegende Datentypen, aber häufig suboptimal
  - 2: Gute Datentypwahl mit wenigen Optimierungsmöglichkeiten
  - 3: Optimale Datentypen für alle Attribute

- **Auflösung von n:m-Beziehungen** (0-3 Punkte)
  - 0: n:m-Beziehungen nicht oder falsch aufgelöst
  - 1: Grundlegende Auflösung mit mehreren Problemen
  - 2: Korrekte Auflösung mit kleineren Mängeln
  - 3: Perfekte Auflösung aller n:m-Beziehungen mit Zwischentabellen

### SQL-Implementierung (15%)
- **Korrektheit der CREATE-Statements** (0-3 Punkte)
  - 0: Falsche Syntax oder unvollständige Statements
  - 1: Grundlegende Syntax, aber mehrere Fehler
  - 2: Korrekte Statements mit kleineren Optimierungsmöglichkeiten
  - 3: Fehlerfreie, optimale CREATE-Statements für alle Tabellen

- **Definition von Constraints** (0-3 Punkte)
  - 0: Fehlende oder überwiegend falsche Constraints
  - 1: Grundlegende Constraints definiert, wichtige fehlen
  - 2: Gute Constraints mit wenigen fehlenden Elementen
  - 3: Vollständige, sinnvolle Constraints für alle relevanten Elemente

- **Referentielle Integrität** (0-3 Punkte)
  - 0: Keine oder falsch implementierte referentielle Integrität
  - 1: Grundlegende Implementierung mit mehreren Fehlern
  - 2: Gute Implementierung mit kleineren Mängeln
  - 3: Vollständige, korrekte Definition aller Fremdschlüsselbeziehungen

- **Reihenfolge der Tabellenerstellung** (0-3 Punkte)
  - 0: Falsche Reihenfolge, die nicht ausführbar wäre
  - 1: Teilweise korrekte Reihenfolge mit mehreren Problemen
  - 2: Weitgehend korrekte Reihenfolge mit kleineren Mängeln
  - 3: Perfekte Reihenfolge unter Berücksichtigung aller Abhängigkeiten

## Abgabeformat

Deine Abgabe soll folgende Dokumente enthalten:

1. **Anforderungsdokument** (PDF, 2-3 Seiten)
   - Liste der funktionalen Anforderungen
   - Beschreibung der Hauptentitäten und ihrer Beziehungen
   - Erläuterung der Geschäftsregeln

2. **ER-Diagramm** (PDF oder Bild-Format)
   - Vollständiges Diagramm in standardisierter Notation
   - Legende zur verwendeten Notation (falls nötig)

3. **Datenbankschema-Dokumentation** (PDF, 2-3 Seiten)
   - Beschreibung aller Tabellen und ihrer Attribute
   - Erläuterung zur Normalisierung
   - Dokumentation der Beziehungen

4. **SQL-Skript** (SQL-Datei)
   - CREATE TABLE-Statements für alle Tabellen
   - Mit Kommentaren zur Erklärung komplexerer Konstrukte

## Abgabetermin
Die vollständige Projektdokumentation ist bis zum **7.6.2025** einzureichen.
