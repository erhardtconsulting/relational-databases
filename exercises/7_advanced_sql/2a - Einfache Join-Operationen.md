# Übung: Einfache Join-Operationen

## Lernziele

In dieser Übung wirst du:
- Grundlegende Join-Typen (INNER, LEFT, RIGHT) anwenden
- Abfragen über mehrere Tabellen formulieren
- Die Ergebnisunterschiede zwischen verschiedenen Join-Typen analysieren
- Selbst-Joins implementieren

## Aufgabenszenario

Du arbeitest mit der Verein-Datenbank, die folgende Tabellen enthält:
- `Person`: Mitglieder und andere Personen des Vereins
- `Status`: Mögliche Mitgliedschaftsarten (mit unterschiedlichen Beiträgen)
- `Funktion`: Verschiedene Rollen und Ämter im Verein
- `Funktionsbesetzung`: Zuordnung von Personen zu Funktionen (mit Zeitraum)
- `Anlass`: Veranstaltungen des Vereins
- `Teilnehmer`: Teilnahme von Personen an Anlässen
- `Sponsor`: Firmen oder Personen, die den Verein unterstützen
- `Spende`: Einzelne Spendenzahlungen von Sponsoren
- `Sponsorenkontakt`: Zuordnung von Vereinsmitgliedern zu Sponsoren (Kontaktpersonen)

## Teil 1: Grundlegende Joins

Formuliere SQL-Abfragen für die folgenden Aufgaben:

### Aufgabe 1.1: INNER JOIN
Erstelle eine Liste aller Personen mit ihrem Status. Zeige Name, Vorname, Status-Bezeichnung und Beitrag an.

### Aufgabe 1.2: LEFT JOIN
Erstelle eine Liste aller Personen und ihrer Funktionen. Auch Personen ohne Funktion sollen angezeigt werden.

### Aufgabe 1.3: Mehrfach-Join
Erstelle eine Liste aller Anlässe mit ihren Organisatoren (Name und Vorname). Sortiere nach Datum (neueste zuerst).

### Aufgabe 1.4: Selbst-Join
Zeige eine Liste aller Personen und ihrer Mentoren an (Name und Vorname beider Personen). Hinweis: In der Person-Tabelle gibt es ein Feld `MentorID`, das auf dieselbe Tabelle verweist.

## Teil 2: Vergleich verschiedener Join-Typen

### Aufgabe 2.1: INNER vs. LEFT JOIN
Schreibe eine Abfrage mit INNER JOIN, die alle Funktionen und die Personen, die sie aktuell besetzen, anzeigt. Schreibe dann eine ähnliche Abfrage mit LEFT JOIN, die auch Funktionen ohne aktuelle Besetzung anzeigt. Vergleiche die Ergebnisse.

### Aufgabe 2.2: LEFT vs. RIGHT JOIN
Schreibe zwei Abfragen, die alle Sponsoren und ihre Spenden anzeigen - einmal mit LEFT JOIN und einmal mit äquivalentem RIGHT JOIN (mit umgekehrter Tabellenreihenfolge). Die Ergebnisse sollten identisch sein.

### Aufgabe 2.3: FULL JOIN
Schreibe eine Abfrage mit FULL JOIN, die alle Anlässe und alle Personen anzeigt. Für jede Kombination soll angezeigt werden, ob die Person am Anlass teilgenommen hat oder nicht.

### Aufgabe 2.4: Mehrere LEFT JOINs
Erstelle eine Liste aller Personen mit ihrem Status und ihrer Funktion (falls vorhanden). Verwende LEFT JOINs. Sortiere nach Name und Vorname.

## Hinweise zur Bearbeitung

- Starte mit einfachen Joins und baue diese schrittweise zu komplexeren Abfragen aus
- Verwende Tabellenaliase, um die Lesbarkeit zu verbessern (z.B. `Person p` statt nur `Person`)
- Achte auf die korrekte Verknüpfung der Tabellen (richtige Spalten im JOIN)
- Nutze die PostgreSQL-Dokumentation, wenn du dir bei spezifischen Funktionen nicht sicher bist
- Teste deine Abfragen mit der Vereinsdatenbank und analysiere die Ergebnisse
