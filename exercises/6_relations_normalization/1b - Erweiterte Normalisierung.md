# Übung 4: Erweiterte Normalisierung

## Lernziele

- Komplexe Datenanomalien in denormalisierten Datenstrukturen erkennen
- Höhere Normalformen (BCNF, 4NF) verstehen und anwenden
- Vor- und Nachteile verschiedener Normalisierungsgrade abwägen
- Geeignete Denormalisierungsstrategien für Performanceoptimierung entwickeln

## Einführung

In dieser fortgeschrittenen Übung wirst du dich mit komplexeren Normalisierungskonzepten beschäftigen. Du wirst über die grundlegenden Normalformen (1NF, 2NF, 3NF) hinausgehen und anspruchsvollere Datenstrukturen analysieren. Dabei lernst du auch, wann eine Denormalisierung sinnvoll sein kann und wie man einen ausgewogenen Kompromiss zwischen Datenintegrität und Abfrageleistung findet.

## Ausgangssituation: Projekt- und Ressourcenmanagement

Ein Unternehmen nutzt folgende denormalisierte Tabelle für sein Projekt- und Ressourcenmanagement:

| ProjektID | ProjektName | StartDatum | EndDatum | MitarbeiterID | MitarbeiterName | Abteilung | AbteilungsLeiter | Rolle | Stunden | QualifikationID | QualifikationName | QualifikationsLevel | RessourceID | RessourceName | RessourcenTyp | Verfügbar_ab | Verfügbar_bis | Standort | StandortAdresse |
|-----------|-------------|------------|----------|---------------|-----------------|-----------|------------------|-------|---------|-----------------|-------------------|---------------------|-------------|---------------|---------------|--------------|---------------|----------|-----------------|
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 | M101 | Anna Müller | IT | Dr. Thomas Weber | Projektleiter | 120 | Q1 | Projektmanagement | Expert | R001 | Server Rack A | Hardware | 2025-03-15 | 2025-10-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 | M101 | Anna Müller | IT | Dr. Thomas Weber | Projektleiter | 120 | Q2 | ERP-Systeme | Advanced | R001 | Server Rack A | Hardware | 2025-03-15 | 2025-10-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 | M102 | Max Schmidt | IT | Dr. Thomas Weber | Entwickler | 160 | Q3 | Java | Expert | R002 | Entwicklungsserver | Hardware | 2025-02-01 | 2025-12-31 | Berlin | Hauptstr. 1, 10115 Berlin |
| P001 | ERP-Migration | 2025-04-01 | 2025-09-30 | M103 | Julia Klein | Finanzen | Maria Berger | Fachexperte | 80 | Q4 | Buchhaltung | Expert | NULL | NULL | NULL | NULL | NULL | NULL | NULL |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 | M104 | Tom Fischer | Marketing | Lisa Wagner | Projektleiter | 90 | Q5 | UI/UX Design | Advanced | R003 | Design-Workstation | Hardware | 2025-03-01 | 2025-06-30 | München | Mariusstr. 25, 80331 München |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 | M105 | Laura Kraus | IT | Dr. Thomas Weber | Entwickler | 140 | Q3 | Java | Advanced | R004 | Cloud-Server A | Cloud | 2025-01-01 | 2025-12-31 | NULL | NULL |
| P002 | Website-Relaunch | 2025-03-15 | 2025-05-31 | M105 | Laura Kraus | IT | Dr. Thomas Weber | Entwickler | 140 | Q6 | Web-Entwicklung | Expert | R004 | Cloud-Server A | Cloud | 2025-01-01 | 2025-12-31 | NULL | NULL |
| P003 | Datenmigration | 2025-05-01 | 2025-07-31 | M101 | Anna Müller | IT | Dr. Thomas Weber | Datenanalyst | 100 | Q7 | SQL | Expert | R005 | Datenbank-Server | Hardware | 2025-04-15 | 2025-08-15 | Berlin | Hauptstr. 1, 10115 Berlin |
| P003 | Datenmigration | 2025-05-01 | 2025-07-31 | M101 | Anna Müller | IT | Dr. Thomas Weber | Datenanalyst | 100 | Q8 | ETL-Prozesse | Advanced | R005 | Datenbank-Server | Hardware | 2025-04-15 | 2025-08-15 | Berlin | Hauptstr. 1, 10115 Berlin |

## Aufgaben

### 1. Kritische Analyse der Ausgangstabelle

a) Identifiziere alle Arten von Anomalien in der Tabelle und gib jeweils ein konkretes Beispiel aus den Daten.

b) Identifiziere alle funktionalen Abhängigkeiten in der Tabelle. Berücksichtige auch transitive und partielle Abhängigkeiten.

c) Bestimme den aktuellen Normalisierungsgrad der Tabelle und begründe deine Einschätzung.

### 2. Schrittweise Normalisierung

a) Überführe die Tabelle in die erste Normalform (1NF) und erkläre deine Schritte.

b) Überführe das Ergebnis in die zweite Normalform (2NF) und erkläre deine Schritte.

c) Überführe das Ergebnis in die dritte Normalform (3NF) und erkläre deine Schritte.

d) Überführe das Ergebnis in die Boyce-Codd-Normalform (BCNF) und erkläre deine Schritte.

e) Überprüfe, ob die vierte Normalform (4NF) erfüllt ist oder weitere Änderungen notwendig sind.

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

c) Schlage mindestens zwei gezielte Denormalisierungsmaßnahmen vor, um die Performance bestimmter Abfragen zu verbessern. Begründe, warum diese Denormalisierungen sinnvoll sind und welche Kompromisse sie mit sich bringen.

d) Erstelle ein modifiziertes Schemadiagramm, das deine Denormalisierungsvorschläge beinhaltet.

## Abgabe

Deine Lösung sollte folgende Elemente enthalten:
- Vollständige Analyse der funktionalen Abhängigkeiten
- Schrittweise Normalisierung mit Zwischenergebnissen
- Alle normalisierten Tabellen mit Primär- und Fremdschlüsseln
- ER-Diagramm der normalisierten Struktur
- Begründete Denormalisierungsvorschläge
- Modifiziertes Schemadiagramm
