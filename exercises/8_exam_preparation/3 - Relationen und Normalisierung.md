---
title: "Prüfungsvorbereitung: Relationen und Normalisierung"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - Relationen
    - Normalisierung
    - Beziehungstypen
    - ER-Modell
    - Funktionale Abhängigkeiten
---

# Prüfungsvorbereitung: Relationen und Normalisierung

## Übungsziele

In diesem Übungsblatt werden die Konzepte der relationalen Datenmodellierung und Normalisierung wiederholt und vertieft. Nach Bearbeitung dieser Übungen solltest du:

- Die Grundkonzepte des relationalen Modells verstehen und anwenden können
- Verschiedene Beziehungstypen (1:1, 1:n, n:m) erkennen und implementieren können
- Den Normalisierungsprozess (1NF bis 3NF) durchführen können
- Datenbankschemas basierend auf funktionalen Abhängigkeiten entwerfen können
- Probleme in nicht-normalisierten Datenbanken identifizieren können

## Theoretische Fragen

### 1.1 Grundkonzepte des relationalen Modells

Erkläre kurz die folgenden Begriffe und ihre Bedeutung im relationalen Datenbankmodell:

a) Relation
b) Tupel
c) Attribut
d) Primärschlüssel
e) Fremdschlüssel
f) Referentielle Integrität

### 1.2 Beziehungstypen

Beschreibe die folgenden Beziehungstypen und gib jeweils ein Beispiel:

a) 1:1-Beziehung
b) 1:n-Beziehung
c) n:m-Beziehung

### 1.3 Normalformen

Definiere die folgenden Normalformen:

a) Erste Normalform (1NF)
b) Zweite Normalform (2NF)
c) Dritte Normalform (3NF)

### 1.4 Anomalien

Erkläre die folgenden Anomalien und warum sie in schlecht strukturierten Datenbanken auftreten:

a) Einfügeanomalie
b) Änderungsanomalie
c) Löschanomalie

## Praktische Übungen

### 2.1 Entitäten, Attribute und Beziehungen identifizieren

Betrachte folgendes Szenario einer Bibliothek:

Eine Bibliothek verleiht Bücher an ihre Mitglieder. Jedes Buch hat einen Titel, eine ISBN-Nummer, einen Verlag und mehrere Autoren. Mitglieder haben eine Mitgliedsnummer, Name, Adresse und Telefonnummer. Für jede Ausleihe werden das Ausleihdatum und das Rückgabedatum erfasst. Die Bibliothek besteht aus verschiedenen Standorten, und jedes Buch ist einem bestimmten Standort zugeordnet.

a) Identifiziere alle relevanten Entitäten in diesem Szenario.

b) Liste für jede Entität die wichtigsten Attribute auf und markiere mögliche Primärschlüssel.

c) Identifiziere alle Beziehungen zwischen den Entitäten und bestimme deren Typ (1:1, 1:n, n:m).

### 2.2 ER-Diagramm erstellen

Erstelle ein ER-Diagramm für das Bibliotheks-Szenario aus Aufgabe 2.1. Verwende die Standardnotation mit Rechtecken für Entitäten, Ovalen für Attribute, Rauten für Beziehungen und entsprechenden Verbindungen.

### 2.3 Normalisierung einer denormalisierten Tabelle

Betrachte folgende denormalisierte Tabelle für ein Online-Shop-System:

| Bestellung_ID | Kunden_Name | Kunden_Email | Kunden_Adresse | Produkt_ID | Produkt_Name | Produkt_Kategorie | Menge | Einzelpreis | Gesamtpreis |
|--------------|-------------|--------------|----------------|------------|--------------|------------------|-------|-------------|-------------|
| 1001 | Schmidt, Anna | anna@mail.de | Hauptstr. 1, 10115 Berlin | P201 | Laptop XPS | Computer | 1 | 1200.00 | 1200.00 |
| 1001 | Schmidt, Anna | anna@mail.de | Hauptstr. 1, 10115 Berlin | P305 | Maus Wireless | Zubehör | 2 | 25.00 | 50.00 |
| 1002 | Müller, Thomas | thomas@mail.de | Bergstr. 42, 70565 Stuttgart | P201 | Laptop XPS | Computer | 1 | 1200.00 | 1200.00 |
| 1003 | Weber, Lisa | lisa@mail.de | Seeweg 7, 80331 München | P102 | Drucker Laser | Peripherie | 1 | 299.00 | 299.00 |
| 1003 | Weber, Lisa | lisa@mail.de | Seeweg 7, 80331 München | P305 | Maus Wireless | Zubehör | 1 | 25.00 | 25.00 |

a) Identifiziere die Probleme (Redundanzen, potenzielle Anomalien) in dieser Tabellenstruktur.

b) Überführe die Tabelle in die erste Normalform (1NF), falls sie nicht bereits in 1NF ist.

c) Überführe die Tabelle in die zweite Normalform (2NF).

d) Überführe die Tabelle in die dritte Normalform (3NF).

e) Zeichne ein ER-Diagramm für das normalisierte Schema.

### 2.4 Identifikation funktionaler Abhängigkeiten

Betrachte folgende Tabelle:

| StudentID | Kurs | Professor | ProfessorBüro | Note | Semester |
|----------|------|-----------|--------------|------|----------|

a) Bestimme alle funktionalen Abhängigkeiten, die in dieser Tabelle bestehen könnten. Begründe deine Annahmen.

b) Bestimme den/die Kandidatenschlüssel dieser Tabelle auf Basis der von dir identifizierten funktionalen Abhängigkeiten.

c) Überführe die Tabelle in die dritte Normalform (3NF).

### 2.5 Implementierung in SQL

Schreibe SQL-DDL-Anweisungen zur Implementierung des normalisierten Schemas aus Aufgabe 2.3. Achte dabei auf:

a) Korrekte Datentypen für alle Attribute
b) Primärschlüssel für jede Tabelle
c) Fremdschlüsselbedingungen mit geeigneten Optionen für ON DELETE und ON UPDATE
d) Geeignete Constraints (z.B. NOT NULL, UNIQUE, CHECK)

## Zusatzaufgaben

### 3.1 De-Normalisierung für Performance

In manchen Fällen kann es sinnvoll sein, eine Datenbank bewusst zu de-normalisieren, um die Performance zu verbessern.

a) Beschreibe ein Szenario, in dem De-Normalisierung vorteilhaft sein könnte.

b) Nehme an, du hast ein vollständig normalisiertes Schema für einen Online-Shop mit Tabellen für Kunden, Produkte, Bestellungen und Bestellpositionen. Welche De-Normalisierungen könntest du vornehmen, um häufige Abfragen zu beschleunigen?

### 3.2 Beziehungen im Verein-Schema

Analysiere das Schema der Verein-Datenbank:

a) Identifiziere alle 1:n und n:m Beziehungen im Schema.

b) Gibt es selbstreferenzierende Beziehungen? Falls ja, erkläre ihren Zweck.

c) Schlage eine Erweiterung des Schemas vor, die eine zusätzliche n:m-Beziehung einführt (z.B. könnten Personen mehrere Sponsoren betreuen und ein Sponsor könnte von mehreren Personen betreut werden).

---

Denke daran, die Lösungen auf einem separaten Blatt oder in einer Datei zu notieren, damit du später deine Antworten mit den Musterlösungen vergleichen kannst.
