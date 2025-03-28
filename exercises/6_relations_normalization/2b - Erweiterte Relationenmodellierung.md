---
title: "Relationen und Normalisierung / Übung 2b: Erweiterte Relationenmodellierung"
author: 
    - Simon Erhardt
date: "28.03.2025"
keywords:
    - Relationen
    - Normalisierung
---
# Übung 2b: Erweiterte Relationenmodellierung

## Lernziele

- Komplexe Beziehungstypen in realen Szenarien identifizieren
- Mehrfachbeziehungen und selbstreferenzierende Beziehungen modellieren
- Optionale und obligatorische Beziehungen unterscheiden und korrekt umsetzen
- Fortgeschrittene Konzepte der relationalen Datenmodellierung anwenden

## Einführung

Diese Übung führt dich tiefer in die Welt der relationalen Datenmodellierung ein. Du wirst mit komplexeren Szenarien konfrontiert, die anspruchsvollere Beziehungstypen und Modellierungsentscheidungen erfordern. Die Übung baut auf den Grundlagen der Beziehungstypen auf und erweitert dein Wissen im Bereich des konzeptionellen Datenbankdesigns.

## Ausgangssituation: Universitätsverwaltung

Eine Universität möchte ihr Verwaltungssystem neu gestalten. Nach einer ausführlichen Anforderungsanalyse wurden folgende Informationen zusammengetragen:

1. Die Universität besteht aus mehreren Fakultäten (Name, Gründungsjahr, Standort).
2. Jede Fakultät hat einen Dekan, der gleichzeitig Professor an der Universität ist.
3. Fakultäten bieten verschiedene Studiengänge an (Bezeichnung, Abschluss, Regelstudienzeit).
4. Ein Studiengang kann von mehreren Fakultäten gemeinsam angeboten werden (interdisziplinäre Studiengänge).
5. Studierende (Matrikelnummer, Name, Geburtsdatum, Adresse) sind in einem Hauptstudiengang eingeschrieben, können aber Module aus anderen Studiengängen belegen.
6. Professoren (Personalnummer, Name, Titel, Fachgebiet) gehören einer Fakultät an, können aber auch Lehrveranstaltungen für andere Fakultäten anbieten.
7. Ein Professor kann mehrere Assistenten betreuen.
8. Assistenten (Personalnummer, Name, Fachgebiet) unterstützen jeweils genau einen Professor.
9. Lehrveranstaltungen (Veranstaltungsnummer, Titel, ECTS-Punkte, Semester) werden von genau einem Professor gehalten und gehören zu einem oder mehreren Studiengängen.
10. Studierende belegen mehrere Lehrveranstaltungen und erhalten für jede eine Note.
11. Professoren können als Mentoren für Studierende fungieren. Ein Studierender hat höchstens einen Mentor, ein Professor kann mehrere Studierende betreuen.
12. Für besondere Projekte können Arbeitsgruppen gebildet werden, in denen sowohl Professoren, Assistenten als auch Studierende mitarbeiten können.

## Aufgaben

### 1. Identifikation besonderer Beziehungstypen

a) Identifiziere im Universitätsszenario alle Entitäten und deren Beziehungen.

b) Markiere besonders die folgenden Beziehungstypen und begründe deine Entscheidung:
   - Selbstreferenzierende Beziehungen
   - Mehrfachbeziehungen zwischen denselben Entitäten
   - Beziehungen mit besonderen Attributen
   - Ternäre oder komplexere Beziehungen

c) Unterscheide bei allen Beziehungen, ob sie optional oder obligatorisch sind und begründe deine Entscheidung.

### 2. Erweitertes ER-Diagramm

a) Erstelle ein detailliertes ER-Diagramm für das Universitätsszenario.

b) Verwende eine geeignete Notation für:
   - Verschiedene Arten von Entitäten (stark/schwach)
   - Beziehungstypen mit ihren Kardinalitäten
   - Attribute (einfach/mehrwertig/abgeleitet)
   - Spezialisierungs-/Generalisierungsbeziehungen, falls sinnvoll

c) Dokumentiere alle Annahmen, die du bei der Modellierung triffst.

### 3. Herausforderung: Mehrfachbeziehungen

a) Betrachte besonders die Beziehung zwischen Professoren und Studierenden, die in mehreren Kontexten auftreten kann (Lehrveranstaltung, Mentoring, Projektarbeit).

b) Entwickle zwei alternative Modellierungsansätze für diese Mehrfachbeziehungen und diskutiere deren Vor- und Nachteile.

c) Entscheide dich für eine der Alternativen und begründe deine Wahl.

### 4. Umsetzung komplexer Beziehungen in relationale Tabellen

a) Überführe die folgenden komplexen Beziehungen aus deinem ER-Diagramm in relationale Tabellen:

   **1. Die interdisziplinären Studiengänge** (mehrere Fakultäten bieten einen Studiengang an)
   
   **2. Die Arbeitsgruppen** (mit Professoren, Assistenten und Studierenden)
   
   **3. Die Beziehung zwischen Studierenden und Lehrveranstaltungen** (mit Noten)

b) Lege für jede Tabelle fest:
   - Attribute
   - Primärschlüssel
   - Fremdschlüssel
   - Weitere Integritätsbedingungen

c) Begründe deine Entscheidungen und diskutiere Alternativen.

### 5. Kritische Reflexion

a) Analysiere dein Datenbankdesign kritisch:
   - Welche Abfragen wären mit diesem Design einfach, welche komplex?
   - Wo könnten bei hoher Datenmenge Performance-Probleme auftreten?
   - Welche Änderungen im realen System könnten dein Datenbankdesign beeinflussen?

b) Schlage mindestens zwei konkrete Verbesserungen für dein Design vor und erläutere, welche Vorteile diese bieten würden.

## Abgabe

Deine Lösung sollte folgende Elemente enthalten:

 - Vollständige Analyse der Entitäten und Beziehungen
 - Detailliertes ER-Diagramm mit allen relevanten Elementen
 - Ausführliche Diskussion der Modellierungsentscheidungen
 - Relationale Umsetzung der komplexen Beziehungen
 - Kritische Reflexion und Verbesserungsvorschläge
