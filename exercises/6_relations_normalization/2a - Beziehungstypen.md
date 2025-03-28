---
title: "Relationen und Normalisierung / Übung 2a: Identifikation und Modellierung von Beziehungstypen"
author: 
    - Simon Erhardt
date: "28.03.2025"
keywords:
    - Relationen
    - Normalisierung
---
# Übung 2a: Identifikation und Modellierung von Beziehungstypen

## Lernziele

- Verschiedene Beziehungstypen (1:1, 1:n, n:m) in realen Szenarien erkennen
- Geeignete Datenbankstrukturen für unterschiedliche Beziehungstypen entwerfen
- Beziehungen in relationalen Tabellen korrekt abbilden
- Entity-Relationship-Diagramme für gegebene Anforderungen erstellen

## Einführung

Beziehungen zwischen Entitäten bilden das Fundament relationaler Datenbanken. In dieser Übung wirst du ein Datenbankschema für einen Online-Shop entwerfen. Du wirst verschiedene Beziehungstypen identifizieren und entsprechende Tabellenstrukturen konzipieren.

## Ausgangssituation: Online-Shop

Ein Online-Shop für Computer-Hardware benötigt eine neue Datenbank. Aus Gesprächen mit den Beteiligten wurden folgende Anforderungen gesammelt:

1. Der Shop verkauft Produkte verschiedener Kategorien (z.B. CPUs, Grafikkarten, Mainboards).
2. Jedes Produkt hat eine eindeutige Artikelnummer, Bezeichnung, Preis, Lagerbestand und gehört zu genau einer Kategorie.
3. Jede Kategorie hat einen Namen und eine Beschreibung.
4. Kunden können sich im Shop registrieren mit Name, Adresse, E-Mail und Telefonnummer.
5. Ein Kunde kann mehrere Bestellungen aufgeben.
6. Jede Bestellung enthält ein oder mehrere Produkte in unterschiedlichen Mengen.
7. Zu jeder Bestellung werden Bestelldatum, Versandadresse und Zahlungsmethode gespeichert.
8. Jeder Kunde kann eine oder mehrere Versandadressen hinterlegen.
9. Jedes Produkt kann mehrere technische Spezifikationen haben (z.B. Taktrate, Speichergrösse).
10. Ein Produkt kann zu mehreren verwandten Produkten in Beziehung stehen (z.B. kompatible Komponenten).

## Aufgaben

### 1. Identifikation der Entitäten und Beziehungen

a) Identifiziere alle notwendigen Entitäten für den Online-Shop.

b) Benenne alle Beziehungen zwischen diesen Entitäten.

c) Bestimme für jede Beziehung den Typ (1:1, 1:n oder n:m) und begründe deine Entscheidung.

### 2. Erstellung eines ER-Diagramms

a) Erstelle ein Entity-Relationship-Diagramm, das alle Entitäten, deren Attribute und die Beziehungen darstellt.

b) Markiere Primär- und Fremdschlüssel.

c) Gib für jede Beziehung die Kardinalität an.

Du kannst das Diagramm mit einem Tool deiner Wahl erstellen (z.B. draw.io, Lucidchart, etc.) oder handschriftlich anfertigen und einscannen.

### 3. Umsetzung der 1:1 Beziehungen

a) Identifiziere aus deinem ER-Diagramm eine 1:1 Beziehung (oder erstelle eine passende, falls keine existiert).

b) Zeige, wie du diese Beziehung in relationalen Tabellen umsetzen würdest (Tabellenstruktur mit Attributen und Schlüsseln).

c) Erkläre deine Designentscheidung (welche Tabelle enthält den Fremdschlüssel und warum).

### 4. Umsetzung der 1:n Beziehungen

a) Wähle zwei der 1:n Beziehungen aus deinem ER-Diagramm aus.

b) Zeige, wie du diese Beziehungen in relationalen Tabellen umsetzen würdest.

c) Beschreibe, welche Integritätsbedingungen du für diese Beziehungen definieren würdest.

### 5. Umsetzung der n:m Beziehungen

a) Wähle mindestens eine n:m Beziehung aus deinem ER-Diagramm.

b) Zeige, wie du diese Beziehung in relationalen Tabellen umsetzen würdest, inklusive der notwendigen Zwischentabelle.

c) Entscheide, welche zusätzlichen Attribute die Zwischentabelle haben sollte und begründe deine Entscheidung.

## Abgabe

Deine Lösung sollte folgende Elemente enthalten:

- Identifikation aller Entitäten und Beziehungen mit Begründungen
- Das ER-Diagramm
- Tabellenstrukturen für alle identifizierten Beziehungstypen
- Erläuterungen zu deinen Designentscheidungen
