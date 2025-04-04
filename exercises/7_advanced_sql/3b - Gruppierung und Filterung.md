# Übung: Gruppierung und Filterung von Daten

## Lernziele

In dieser Übung wirst du:
- Daten mit GROUP BY gruppieren und analysieren
- Gruppierte Daten mit HAVING-Klauseln filtern
- Den Unterschied zwischen WHERE (vor Gruppierung) und HAVING (nach Gruppierung) verstehen
- Gruppierungen nach mehreren Kriterien erstellen und auswerten

## Aufgabenszenario

Der Vereinsvorstand benötigt detailliertere Auswertungen, bei denen Daten nach verschiedenen Kriterien gruppiert und gefiltert werden. Mit Hilfe von GROUP BY und HAVING kannst du diese komplexeren Analysen durchführen.

## Teil 1: Gruppierung mit GROUP BY

### Aufgabe 1.1: Personenstatistik
Gruppiere die Personen nach verschiedenen Kriterien und zähle jeweils:
- Anzahl der Personen pro Status
- Anzahl der Personen pro Ort
- Anzahl der Personen pro Jahr des Eintritts

### Aufgabe 1.2: Anlassstatistik
Erstelle folgende Auswertungen zu Anlässen:
- Anzahl der Anlässe pro Jahr
- Durchschnittliche Teilnehmerzahl pro Anlass
- Anzahl der Anlässe pro Organisator (mit Namen und Vornamen)

### Aufgabe 1.3: Mehrfachgruppierung
Erstelle komplexere Gruppierungen:
- Anzahl der Personen pro Status und Ort
- Anzahl der Anlässe pro Jahr und Ort
- Anzahl der Funktionsbesetzungen pro Funktion und Jahr (Jahr des Antritts)

## Teil 2: Filterung von Gruppen mit HAVING

### Aufgabe 2.1: Filterung von Personengruppen
Finde mit Hilfe von HAVING:
- Orte, in denen mehr als 3 Vereinsmitglieder wohnen
- Status-Kategorien mit einem durchschnittlichen Beitrag über 50
- Personen, die mehr als eine Funktion innehaben oder hatten

### Aufgabe 2.2: Filterung von Anlässen
Finde:
- Anlässe mit mehr als 5 Teilnehmern
- Organisatoren, die mehr als 2 Anlässe organisiert haben
- Jahre, in denen mehr als 3 Anlässe stattgefunden haben

### Aufgabe 2.3: Filterung von Sponsoren
Finde:
- Sponsoren, die mehr als 2 Spenden getätigt haben
- Sponsoren mit einer Gesamtspendensumme über 1000
- Sponsoren, deren durchschnittliche Spende über dem Gesamtdurchschnitt liegt

## Hinweise zur Bearbeitung

- Achte auf die korrekte Anwendung von GROUP BY und HAVING Klauseln
- Beachte die Reihenfolge der SQL-Operationen:
  1. FROM und JOINs (Tabellen verknüpfen)
  2. WHERE (Zeilen filtern vor der Gruppierung)
  3. GROUP BY (Zeilen gruppieren)
  4. Aggregatfunktionen anwenden
  5. HAVING (Gruppen filtern nach der Aggregation)
  6. SELECT (Spalten auswählen)
  7. ORDER BY (Sortierung)
- Wenn du nicht-aggregierte Spalten im SELECT verwendest, müssen diese auch in der GROUP BY-Klausel erscheinen
- Bei komplexen Abfragen kann es hilfreich sein, sie schrittweise zu entwickeln und zu testen

## Zusatzaufgabe

Erstelle eine "Top-Performer"-Analyse für den Verein:

1. Identifiziere die Top 3 Status-Kategorien mit den meisten Mitgliedern
2. Finde die Top 5 Anlässe mit der höchsten Teilnehmerzahl
3. Ermittle die Top 3 aktivsten Jahre (gemessen an der Anzahl der Anlässe und neuen Mitglieder)
4. Identifiziere die Top 5 engagiertesten Mitglieder (basierend auf der Anzahl der ausgeübten Funktionen und Anlassteilnahmen)

Formatiere die Ausgabe so, dass sie gut lesbar ist und eine klare Rangfolge erkennen lässt.
