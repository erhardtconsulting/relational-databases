---
title: "Fortgeschrittenes SQL / Übung 3a: Grundlegende Aggregatfunktionen"
author: 
    - Simon Erhardt
date: "05.04.2025"
keywords:
    - SQL
---

# Übung 3a: Grundlegende Aggregatfunktionen

## Lernziele

In dieser Übung wirst du:
- Verschiedene Aggregatfunktionen (COUNT, SUM, AVG, MIN, MAX) kennenlernen und anwenden
- Daten mit einfachen statistischen Methoden analysieren
- Die Unterschiede zwischen COUNT(*) und COUNT(spalte) sowie die Behandlung von NULL-Werten verstehen
- Mit DISTINCT-Klauseln kombinierte Zählungen durchführen

## Aufgabenszenario

Der Vereinsvorstand möchte datenbasierte Entscheidungen treffen und benötigt daher statistische Auswertungen über Mitglieder, Anlässe, Funktionen und Sponsoren. Mit Hilfe von Aggregatfunktionen kannst du die grundlegenden Analysen durchführen.

## Teil 1: Grundlegende Aggregatfunktionen

### Aufgabe 1.1: Einfache Zählungen
Beantworte folgende Fragen mit SQL-Abfragen:
- Wie viele Personen sind insgesamt im System erfasst?
- Wie viele verschiedene Funktionen gibt es im Verein?
- Wie viele Anlässe wurden bisher durchgeführt?
- Wie viele Sponsoren unterstützen den Verein?

### Aufgabe 1.2: Statistische Auswertungen
Ermittle folgende statistische Kennzahlen:
- Durchschnittlicher Mitgliedsbeitrag über alle Status-Kategorien
- Höchster, niedrigster und durchschnittlicher Spendenbetrag
- Gesamtsumme aller Spenden
- Anzahl der Personen mit und ohne Austrittsdatum

### Aufgabe 1.3: DISTINCT-Zählungen
Ermittle:
- Anzahl der verschiedenen Orte, aus denen Vereinsmitglieder kommen
- Anzahl der Personen, die jemals eine Funktion im Verein innehatten
- Anzahl der Personen, die an mindestens einem Anlass teilgenommen haben

## Hinweise zur Bearbeitung

- Achte auf die korrekte Syntax und den richtigen Einsatz der Aggregatfunktionen (COUNT, SUM, AVG, MIN, MAX)
- Beachte die Behandlung von NULL-Werten bei Aggregatfunktionen:
  * COUNT(*) zählt alle Zeilen unabhängig von NULL-Werten
  * COUNT(spalte) zählt nur Nicht-NULL-Werte in der Spalte
  * SUM(), AVG(), MIN(), MAX() ignorieren NULL-Werte
- Verwende aussagekräftige Aliase für Spalten (z.B. `COUNT(*) AS Anzahl`)
- Teste deine Abfragen auf dem Vereinsdatenbank-Schema, um die Ergebnisse zu verifizieren

## Zusatzaufgabe

Erstelle eine Abfrage, die eine "Gesundheitszustand"-Übersicht der Datenbank anzeigt. Diese soll folgende Informationen enthalten:
- Anzahl der Tabellen in der Datenbank (verwende dazu die Information Schema-Tabellen)
- Anzahl der Datensätze in jeder Tabelle der Vereinsdatenbank
- Verhältnis zwischen aktiven und ausgetretenen Mitgliedern in Prozent
- Durchschnittliche Mitgliedschaftsdauer in Tagen (für Mitglieder mit Austrittsdatum)
