---
title: "Relationen und Normalisierung / Übung 1b: Erweiterte Normalisierung"
author: 
    - Simon Erhardt
date: "28.03.2025"
keywords:
    - Relationen
    - Normalisierung
---
# Übung 1b: Erweiterte Normalisierung

## Lernziele

- Komplexe Datenanomalien in denormalisierten Datenstrukturen erkennen
- Höhere Normalformen (BCNF, 4NF) verstehen und anwenden
- Vor- und Nachteile verschiedener Normalisierungsgrade abwägen
- Geeignete Denormalisierungsstrategien für Performanceoptimierung entwickeln

## Einführung

In dieser fortgeschrittenen Übung wirst du dich mit komplexeren Normalisierungskonzepten beschäftigen. Du wirst über die grundlegenden Normalformen (1NF, 2NF, 3NF) hinausgehen und anspruchsvollere Datenstrukturen analysieren. Dabei lernst du auch, wann eine Denormalisierung sinnvoll sein kann und wie man einen ausgewogenen Kompromiss zwischen Datenintegrität und Abfrageleistung findet.

## Ausgangssituation: Projekt- und Ressourcenmanagement

Ein Unternehmen nutzt folgende denormalisierte Tabelle für sein Projekt- und Ressourcenmanagement. Die Tabelle ist hier in vier thematisch zusammengehörige Teile aufgeteilt:

**Tabelle 1: Projektinformationen**

| ProjektID | ProjektName | StartDatum | EndDatum |
|-----------|-------------|------------|----------|
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 |
| P003 | Datenmigration | 2025-05-01 | 2025-07-31 |
| P003 | Datenmigration | 2025-05-01 | 2025-07-31 |

**Tabelle 2a: Mitarbeiterinformationen (Teil 1)**

| ProjektID | MitarbeiterID | MitarbeiterName | Abteilung |
|-----------|---------------|-----------------|-----------|
| P001 | M101 | Anna Müller | IT |
| P001 | M101 | Anna Müller | IT |
| P001 | M102 | Max Schmidt | IT |
| P001 | M103 | Julia Klein | Finanzen |
| P002 | M104 | Tom Fischer | Marketing |
| P002 | M105 | Laura Kraus | IT |
| P002 | M105 | Laura Kraus | IT |
| P003 | M101 | Anna Müller | IT |
| P003 | M101 | Anna Müller | IT |

**Tabelle 2b: Mitarbeiterinformationen (Teil 2)**

| MitarbeiterID | AbteilungsLeiter | Rolle | Stunden |
|---------------|------------------|-------|---------|
| M101 | Dr. Thomas Weber | Projektleiter | 120 |
| M101 | Dr. Thomas Weber | Projektleiter | 120 |
| M102 | Dr. Thomas Weber | Entwickler | 160 |
| M103 | Maria Berger | Fachexperte | 80 |
| M104 | Lisa Wagner | Projektleiter | 90 |
| M105 | Dr. Thomas Weber | Entwickler | 140 |
| M105 | Dr. Thomas Weber | Entwickler | 140 |
| M101 | Dr. Thomas Weber | Datenanalyst | 100 |
| M101 | Dr. Thomas Weber | Datenanalyst | 100 |

**Tabelle 3: Qualifikationsinformationen**

| MitarbeiterID | QualifikationID | QualifikationName | QualifikationsLevel |
|---------------|-----------------|-------------------|---------------------|
| M101 | Q1 | Projektmanagement | Expert |
| M101 | Q2 | ERP-Systeme | Advanced |
| M102 | Q3 | Java | Expert |
| M103 | Q4 | Buchhaltung | Expert |
| M104 | Q5 | UI/UX Design | Advanced |
| M105 | Q3 | Java | Advanced |
| M105 | Q6 | Web-Entwicklung | Expert |
| M101 | Q7 | SQL | Expert |
| M101 | Q8 | ETL-Prozesse | Advanced |

**Tabelle 4a: Ressourcenzuordnung**

| ProjektID | RessourceID | RessourceName | RessourcenTyp |
|-----------|-------------|---------------|---------------|
| P001 | R001 | Server Rack A | Hardware |
| P001 | R001 | Server Rack A | Hardware |
| P001 | R002 | Entwicklungsserver | Hardware |
| P001 | NULL | NULL | NULL |
| P002 | R003 | Design-Workstation | Hardware |
| P002 | R004 | Cloud-Server A | Cloud |
| P002 | R004 | Cloud-Server A | Cloud |
| P003 | R005 | Datenbank-Server | Hardware |
| P003 | R005 | Datenbank-Server | Hardware |

**Tabelle 4b: Ressourcenverfügbarkeit**

| RessourceID | Verfügbar_ab | Verfügbar_bis | Standort | StandortAdresse |
|-------------|--------------|---------------|----------|-----------------|
| R001 | 2025-03-15 | 2025-10-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| R001 | 2025-03-15 | 2025-10-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| R002 | 2025-02-01 | 2025-12-31 | Berlin | Hauptstr. 1, 10115 Berlin |
| NULL | NULL | NULL | NULL | NULL |
| R003 | 2025-03-01 | 2025-06-30 | München | Mariusstr. 25, 80331 München |
| R004 | 2025-01-01 | 2025-12-31 | NULL | NULL |
| R004 | 2025-01-01 | 2025-12-31 | NULL | NULL |
| R005 | 2025-04-15 | 2025-08-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| R005 | 2025-04-15 | 2025-08-15 | Berlin | Hauptstr. 1, 10115 Berlin |

## Aufgaben

### 1. Kritische Analyse der Ausgangstabelle

a) Identifiziere alle Arten von Anomalien in der Tabelle und gib jeweils ein konkretes Beispiel aus den Daten.

b) Identifiziere alle funktionalen Abhängigkeiten in der Tabelle. Berücksichtige auch transitive und partielle Abhängigkeiten.

c) Bestimme den aktuellen Normalisierungsgrad der Tabelle und begründe deine Einschätzung.

### 2. Schrittweise Normalisierung

a) Überführe die Tabelle in die erste Normalform (1NF) und erkläre deine Schritte.

b) Überführe das Ergebnis in die zweite Normalform (2NF) und erkläre deine Schritte.

c) Überführe das Ergebnis in die dritte Normalform (3NF) und erkläre deine Schritte.

d) *Bonus:* Überführe das Ergebnis in die Boyce-Codd-Normalform (BCNF) und erkläre deine Schritte.

e) *Bonus:* Überprüfe, ob die vierte Normalform (4NF) erfüllt ist oder weitere Änderungen notwendig sind. 

### 3. Mehrwertige Abhängigkeiten

a) Erkläre das Konzept der mehrwertigen Abhängigkeiten an einem Beispiel aus der Projektverwaltung.

b) Identifiziere potenzielle mehrwertige Abhängigkeiten in der ursprünglichen Tabelle.

c) Zeige, wie diese Abhängigkeiten durch die Normalisierung bis zur 4NF aufgelöst werden.

### 4. ER-Diagramm der normalisierten Struktur

a) Erstelle ein vollständiges Entity-Relationship-Diagramm für deine normalisierte Datenstruktur.

b) Markiere alle Entitäten, Attribute, Beziehungen und Kardinalitäten.

c) Achte besonders auf die korrekte Darstellung von n:m-Beziehungen und schwachen Entitätstypen.

### 5. Praktische Anwendung und Denormalisierung

a) Entwickle fünf typische Abfragen, die für die Projektverwaltung relevant wären (z.B. "Liste aller Mitarbeiter mit ihren Qualifikationen").

b) Analysiere, wie gut deine normalisierte Struktur diese Abfragen unterstützt. Wo könnten Performance-Probleme auftreten?

c) Schlage mindestens zwei gezielte Denormalisierungsmassnahmen vor, um die Performance bestimmter Abfragen zu verbessern. Begründe, warum diese Denormalisierungen sinnvoll sind und welche Kompromisse sie mit sich bringen.

d) Erstelle ein modifiziertes Schemadiagramm, das deine Denormalisierungsvorschläge beinhaltet.

## Abgabe

Deine Lösung sollte folgende Elemente enthalten:

 - Vollständige Analyse der funktionalen Abhängigkeiten
 - Schrittweise Normalisierung mit Zwischenergebnissen
 - Alle normalisierten Tabellen mit Primär- und Fremdschlüsseln
 - ER-Diagramm der normalisierten Struktur
 - Begründete Denormalisierungsvorschläge
 - Modifiziertes Schemadiagramm
