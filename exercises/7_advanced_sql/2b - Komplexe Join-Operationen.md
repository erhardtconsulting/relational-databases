# Übung: Komplexe Join-Operationen

## Lernziele

In dieser Übung wirst du:
- Komplexe Abfragen über mehrere Tabellen formulieren
- Mehrfach-Joins mit speziellen Filterbedingungen anwenden
- Joins mit Unterabfragen kombinieren
- Praxisnahe Anwendungsfälle mit der Verein-Datenbank lösen

## Aufgabenszenario

Du arbeitest weiterhin mit der Verein-Datenbank aus der vorherigen Übung. Zur Erinnerung, die Datenbank enthält folgende Tabellen:
- `Person`: Mitglieder und andere Personen des Vereins
- `Status`: Mögliche Mitgliedschaftsarten (mit unterschiedlichen Beiträgen)
- `Funktion`: Verschiedene Rollen und Ämter im Verein
- `Funktionsbesetzung`: Zuordnung von Personen zu Funktionen (mit Zeitraum)
- `Anlass`: Veranstaltungen des Vereins
- `Teilnehmer`: Teilnahme von Personen an Anlässen
- `Sponsor`: Firmen oder Personen, die den Verein unterstützen
- `Spende`: Einzelne Spendenzahlungen von Sponsoren
- `Sponsorenkontakt`: Zuordnung von Vereinsmitgliedern zu Sponsoren (Kontaktpersonen)

## Teil 1: Komplexe Abfragen mit Joins

### Aufgabe 1.1: Mehrfach-Joins und Filterung
Finde alle Personen, die an Anlässen teilgenommen haben, die von Personen aus demselben Ort organisiert wurden.

### Aufgabe 1.2: Joins mit Unterabfragen
Liste alle Personen auf, die an mindestens zwei verschiedenen Anlässen teilgenommen haben.

### Aufgabe 1.3: Komplexe Bedingungen im JOIN
Finde alle Personen, die sowohl eine Funktion im Verein haben als auch Kontaktperson für mindestens einen Sponsor sind.

### Aufgabe 1.4: Kombinierte Joins
Erstelle eine Liste aller Anlässe mit der Anzahl der Teilnehmer und dem Namen des Organisators. Sortiere nach der Anzahl der Teilnehmer (absteigend).

## Teil 2: Praxisnahe Anwendungsfälle

### Aufgabe 2.1: Mitgliederverwaltung
Der Vereinspräsident benötigt eine Liste aller aktiven Mitglieder (Austritt ist NULL), sortiert nach Status und Name. Für jedes Mitglied soll angezeigt werden, ob es derzeit eine Funktion besetzt und ob es als Mentor für andere Mitglieder fungiert.

### Aufgabe 2.2: Sponsorenverwaltung
Erstelle einen Bericht über alle Sponsoren, der zeigt, wie viele Spenden sie gemacht haben, wie hoch die Gesamtsumme ist und welche Vereinsmitglieder als Kontaktpersonen fungieren.

### Aufgabe 2.3: Anlass-Analyse
Der Vorstand möchte wissen, welche Anlässe besonders erfolgreich waren. Erstelle eine Übersicht aller Anlässe der letzten 2 Jahre mit der Anzahl der Teilnehmer und der Summe der damit verbundenen Spenden.

### Aufgabe 2.4: Personensuche
Entwickle eine Abfrage, die alle Personen findet, die:
- aus einem bestimmten Ort kommen (Parameter: Ort)
- und/oder einen bestimmten Status haben (Parameter: Status)
- und/oder an einem bestimmten Anlass teilgenommen haben (Parameter: AnlassID)

## Hinweise zur Bearbeitung

- Verwende Tabellenaliase, um die Lesbarkeit zu verbessern (z.B. `Person p` statt nur `Person`)
- Für komplexe Abfragen kann es hilfreich sein, mit WITH-Klauseln (Common Table Expressions) zu arbeiten
- Teste verschiedene Ansätze und vergleiche die Ergebnisse
- Achte bei komplexen Joins besonders darauf, dass du die erwarteten Ergebnisse erhältst
- Erstelle für mehrschrittige Probleme zunächst Teillösungen, die du dann kombinieren kannst

## Zusatzaufgabe (für Fortgeschrittene)

Erstelle eine Abfrage, die für jede Person eine "Aktivitätswertung" berechnet, basierend auf:
- 10 Punkte für jede besetzte Funktion
- 5 Punkte für jede Teilnahme an einem Anlass
- 15 Punkte für jede Organisation eines Anlasses
- 8 Punkte für jede Sponsorenkontakt-Beziehung

Zeige die Top 10 Personen nach ihrer Aktivitätswertung an, zusammen mit einer Aufschlüsselung, wie sich ihre Punktzahl zusammensetzt.
