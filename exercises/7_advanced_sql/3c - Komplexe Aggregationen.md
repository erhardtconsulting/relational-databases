---
title: "Fortgeschrittenes SQL / Übung 3c: Komplexe Aggregationen"
author: 
    - Simon Erhardt
date: "05.04.2025"
keywords:
    - SQL
---

# Übung 3c: Komplexe Aggregationen

## Lernziele

In dieser Übung wirst du:
- Komplexe Analysen durch Kombination von Joins, Gruppierung und Aggregation durchführen
- Fortgeschrittene Aggregationstechniken in PostgreSQL anwenden
- Aussagekräftige Reports für praxisnahe Anwendungsfälle erstellen
- Datenanalysen für Entscheidungsprozesse entwickeln

## Aufgabenszenario

Der Vereinsvorstand benötigt komplexere Datenanalysen, um strategische Entscheidungen zu treffen. Durch die Kombination von JOIN-Operationen mit Aggregatfunktionen und Gruppierungen können tiefergehende Erkenntnisse gewonnen werden. Diese Übung konzentriert sich auf fortgeschrittene Abfragen, die mehrere SQL-Konzepte kombinieren.

## Teil 1: Komplexe Abfragen mit Joins und Gruppierung

### Aufgabe 1.1: Funktionsanalyse
Erstelle eine Übersicht über alle Funktionen im Verein mit:
- Bezeichnung der Funktion
- Anzahl der Personen, die diese Funktion je innehatten
- Durchschnittliche "Amtszeit" in Tagen (Differenz zwischen Antritt und Rücktritt)
- Name der Person, die diese Funktion am längsten innehatte

### Aufgabe 1.2: Mitgliederaktivität
Erstelle eine Rangliste der aktivsten Mitglieder, basierend auf:
- Anzahl der besetzten Funktionen
- Anzahl der Teilnahmen an Anlässen
- Anzahl der betreuten Sponsoren
Sortiere nach der Gesamtaktivität.

### Aufgabe 1.3: Sponsorenanalyse
Erstelle einen detaillierten Bericht über die Sponsoren mit:
- Name des Sponsors
- Anzahl der Spenden
- Gesamtbetrag der Spenden
- Durchschnittlicher Spendenbetrag
- Datum der ersten und letzten Spende
- Namen der Kontaktpersonen aus dem Verein

### Aufgabe 1.4: Jahresstatistik
Erstelle eine Jahresstatistik für die letzten 5 Jahre mit:
- Jahr
- Anzahl der neuen Mitglieder
- Anzahl der ausgetretenen Mitglieder
- Anzahl der durchgeführten Anlässe
- Gesamtsumme der erhaltenen Spenden
- Anzahl der neuen Sponsoren

## Teil 2: Fortgeschrittene Techniken

### Aufgabe 2.1: Prozentuale Verteilungen
Berechne:
- Prozentualen Anteil jeder Status-Kategorie an der Gesamtmitgliederzahl
- Prozentualen Anteil jedes Sponsors an der Gesamtspendensumme
- Prozentualen Anteil der Teilnehmer pro Anlass im Verhältnis zur Gesamtmitgliederzahl

### Aufgabe 2.2: Kumulativ- und Durchschnittswerte
Erstelle:
- Eine kumulative Summe der Spenden pro Sponsor über die Zeit
- Eine rollende Durchschnittsberechnung der Teilnehmerzahlen pro Anlass über die letzten 3 Anlässe
- Die prozentuale Veränderung der Mitgliederzahlen von Jahr zu Jahr

### Aufgabe 2.3: Spezielle Aggregatfunktionen
Verwende spezielle PostgreSQL-Aggregatfunktionen:
- STRING_AGG zum Zusammenfügen aller Teilnehmernamen pro Anlass
- ARRAY_AGG zum Erzeugen einer Liste aller Funktionsbezeichnungen pro Person
- PERCENTILE_CONT zum Ermitteln des Medians der Spendenbeträge

## Hinweise zur Bearbeitung

- Für komplexe Abfragen solltest du Common Table Expressions (WITH) verwenden, um die Lesbarkeit zu verbessern
- Nutze Subqueries oder JOINs zu Zwischenresultaten, wo dies sinnvoll ist
- Verwende Window-Funktionen (OVER, PARTITION BY), um komplexe Berechnungen innerhalb von Gruppen durchzuführen
- Für Prozentberechnungen nutze CAST oder :: zur Typumwandlung, um Ganzzahldivision zu vermeiden
- Bei komplexen Abfragen ist es oft hilfreich, sie in kleinere Teile zu zerlegen und diese separat zu testen

## Zusatzaufgabe: Dashboard-Abfragen

Der Vereinsvorstand möchte ein Dashboard einrichten, das auf einen Blick die wichtigsten Kennzahlen zeigt. Entwickle Abfragen für folgende Dashboard-Elemente:

1. **Mitgliederübersicht**:
   - Gesamtanzahl aktiver Mitglieder
   - Verteilung nach Status (mit Prozenten)
   - Entwicklung der Mitgliederzahlen der letzten 5 Jahre (als Trend)

2. **Anlass-Performance**:
   - Top 5 Anlässe nach Teilnehmerzahl
   - Durchschnittliche Teilnehmerzahl pro Anlassort
   - Korrelation zwischen Wochentag des Anlasses und Teilnehmerzahl

3. **Finanzkennzahlen**:
   - Gesamtspendensumme des laufenden Jahres im Vergleich zum Vorjahr
   - Top 5 Sponsoren nach Gesamtspendensumme
   - Monatliche Spendenentwicklung der letzten 12 Monate
