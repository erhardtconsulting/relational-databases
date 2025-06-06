---
title: "Relationen und Normalisierung / Übung 1a: Normalisierung einer Datenbank"
author: 
    - Simon Erhardt
date: "28.03.2025"
keywords:
    - Relationen
    - Normalisierung
---
# Übung 1a: Normalisierung einer Datenbank

## Lernziele

- Probleme in denormalisierten Datenbanktabellen erkennen
- Die ersten drei Normalformen (1NF, 2NF, 3NF) anwenden können
- Eine Datenstruktur schrittweise normalisieren
- Ein Entity-Relationship-Diagramm erstellen

## Einführung

Normalisierung ist ein fundamentaler Prozess im Datenbankdesign, der dazu dient, Redundanzen zu eliminieren und Anomalien zu vermeiden. In dieser Übung wirst du eine denormalisierte Bibliotheksdatenbank schrittweise in die dritte Normalform (3NF) überführen.

## Ausgangssituation: Bibliothek

Die Bibliothek einer Hochschule verwendet folgende denormalisierte Tabelle, um Bücher, Autoren und Ausleihen zu verwalten. Die Tabelle ist hier in drei thematisch zusammengehörige Teile aufgeteilt:

**Tabelle 1: Buchdetails**

| BuchID | Titel                        | ISBN          | Kategorie  | Erscheinungsjahr | Regal |
|--------|------------------------------|---------------|------------|------------------|-------|
| 1      | Database Systems             | 978-0321197849| Informatik | 2003             | A12   |
| 2      | Database Systems             | 978-0321197849| Informatik | 2003             | A12   |
| 3      | Clean Code                   | 978-0132350884| Informatik | 2008             | B45   |
| 4      | The Art of Computer Programming| 978-0201896831| Informatik | 1997          | C23   |
| 5      | Introduction to Algorithms   | 978-0262033848| Informatik | 2009             | B46   |
| 5      | Introduction to Algorithms   | 978-0262033848| Informatik | 2009             | B46   |
| 6      | Physics for Scientists       | 978-0136139263| Physik     | 2007             | D31   |
| 7      | Organic Chemistry            | 978-0471756149| Chemie     | 2006             | E14   |

**Tabelle 2: Autordetails**

| BuchID | Autor                  | AutorEmail           |
|--------|------------------------|----------------------|
| 1      | Thomas Connolly        | t.connolly@edu.com   |
| 2      | Thomas Connolly        | t.connolly@edu.com   |
| 3      | Robert Martin          | r.martin@clean.com   |
| 4      | Donald Knuth           | d.knuth@stanford.edu |
| 5      | Thomas Cormen          | t.cormen@algo.edu    |
| 5      | Charles Leiserson      | c.leiserson@mit.edu  |
| 6      | Paul Tipler            | p.tipler@physics.org |
| 7      | T.W. Graham Solomons   | g.solomons@chem.org  |

**Tabelle 3: Ausleihdetails**

| BuchID | Ausgeliehen_von | Ausleih_Datum | Rückgabe_bis  |
|--------|----------------|---------------|---------------|
| 1      | Anna Schmidt   | 2025-03-15    | 2025-04-05    |
| 2      | Max Müller     | 2025-02-10    | 2025-03-03    |
| 3      | NULL           | NULL          | NULL          |
| 4      | Peter Meier    | 2025-03-20    | 2025-04-10    |
| 5      | Anna Schmidt   | 2025-03-01    | 2025-03-22    |
| 5      | Anna Schmidt   | 2025-03-01    | 2025-03-22    |
| 6      | NULL           | NULL          | NULL          |
| 7      | Lisa Weber     | 2025-03-05    | 2025-03-26    |

## Aufgaben

### 1. Analyse der Ausgangstabelle

a) Identifiziere und beschreibe alle vorhandenen Anomalien in der Tabelle (Einfüge-, Änderungs- und Löschanomalien).

b) Welche Normalformen werden in der Ausgangsversion verletzt? Begründe deine Antwort.

### 2. Überführung in die erste Normalform (1NF)

a) Beschreibe, welche Anforderungen für die 1NF erfüllt sein müssen.

b) Überführe die Ausgangstabelle in die 1NF. Zeige alle notwendigen Tabellen mit Beispieldaten.

c) Definiere für jede Tabelle einen geeigneten Primärschlüssel.

### 3. Überführung in die zweite Normalform (2NF)

a) Beschreibe, welche Anforderungen für die 2NF erfüllt sein müssen.

b) Überführe deine 1NF-Struktur in die 2NF. Zeige alle notwendigen Tabellen mit Beispieldaten.

c) Definiere für jede Tabelle einen geeigneten Primärschlüssel und ggf. Fremdschlüssel.

### 4. Überführung in die dritte Normalform (3NF)

a) Beschreibe, welche Anforderungen für die 3NF erfüllt sein müssen.

b) Überführe deine 2NF-Struktur in die 3NF. Zeige alle notwendigen Tabellen mit Beispieldaten.

c) Definiere für jede Tabelle einen geeigneten Primärschlüssel und ggf. Fremdschlüssel.

### 5. Entwurf eines ER-Diagramms

Erstelle ein Entity-Relationship-Diagramm für deine 3NF-Struktur. Das Diagramm soll folgende Elemente enthalten:

a) Alle Entitäten mit ihren Attributen
b) Alle Beziehungen zwischen den Entitäten
c) Kardinalitäten der Beziehungen (1:1, 1:n, n:m)
d) Primär- und Fremdschlüssel klar markiert

Du kannst das Diagramm mit einem Tool deiner Wahl erstellen (z.B. draw.io, Lucidchart, etc.) oder handschriftlich anfertigen und einscannen.

## Abgabe

Deine Lösung sollte folgende Elemente enthalten:

- Antworten zu allen Aufgaben
- Alle Tabellen der verschiedenen Normalformen
- Das ER-Diagramm
- Eine kurze Erläuterung deiner Designentscheidungen
