---
title: "Prüfungsvorbereitung: Fortgeschrittenes SQL"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DDL
    - JOIN
    - Aggregation
    - Schema-Manipulation
---

# Prüfungsvorbereitung: Fortgeschrittenes SQL

## Übungsziele

In diesem Übungsblatt werden die fortgeschrittenen SQL-Konzepte wiederholt und vertieft. Nach Bearbeitung dieser Übungen solltest du:

- DDL-Befehle korrekt anwenden können
- Verschiedene JOIN-Typen unterscheiden und gezielt einsetzen können
- Komplexe Abfragen mit Aggregatfunktionen und Gruppierungen erstellen können
- SQL-Befehle zur Schema-Manipulation beherrschen
- Tabellen entsprechend einem ER-Diagramm implementieren können

## Theoretische Fragen

### 1.1 Data Definition Language (DDL)

Erkläre die folgenden DDL-Befehle und gib jeweils ein Beispiel:

a) CREATE TABLE
b) ALTER TABLE
c) DROP TABLE
d) TRUNCATE TABLE
e) CREATE INDEX

### 1.2 JOIN-Typen

Beschreibe den Unterschied zwischen den folgenden JOIN-Typen und gib für jeden Typ ein Beispiel:

a) INNER JOIN
b) LEFT JOIN (oder LEFT OUTER JOIN)
c) RIGHT JOIN (oder RIGHT OUTER JOIN)
d) FULL JOIN (oder FULL OUTER JOIN)
e) CROSS JOIN

### 1.3 Aggregatfunktionen und Gruppierung

Erkläre die Funktionsweise der folgenden Aggregatfunktionen und wie sie mit GROUP BY und HAVING verwendet werden:

a) COUNT()
b) SUM()
c) AVG()
d) MIN()
e) MAX()
f) GROUP BY
g) HAVING

## Praktische Übungen

### 2.1 DDL-Übungen

Für die folgenden Aufgaben nutze die passenden DDL-Befehle:

a) Erstelle eine neue Tabelle `Kunde` mit den Spalten:
   - `KundenID` (Ganzzahl, Primärschlüssel)
   - `Name` (Variable Zeichenkette, max. 100 Zeichen, nicht NULL)
   - `Email` (Variable Zeichenkette, max. 100 Zeichen, einzigartig)
   - `Registrierungsdatum` (Datum, Standard ist das aktuelle Datum)
   - `Status` (Zeichenkette, entweder 'aktiv', 'inaktiv' oder 'gesperrt')

b) Ändere die Tabelle `Kunde`, um eine neue Spalte `Telefonnummer` (Variable Zeichenkette, max. 20 Zeichen) hinzuzufügen.

c) Erstelle einen Index auf die Spalte `Email` der Tabelle `Kunde`.

d) Erstelle eine neue Tabelle `Bestellung` mit den Spalten:
   - `BestellID` (Ganzzahl, Primärschlüssel)
   - `KundenID` (Ganzzahl, Fremdschlüssel auf `Kunde.KundenID`)
   - `Bestelldatum` (Datum, nicht NULL)
   - `Gesamtbetrag` (Dezimalzahl mit 2 Nachkommastellen, grösser als 0)

e) Füge einen Constraint hinzu, der sicherstellt, dass der `Gesamtbetrag` in der Tabelle `Bestellung` immer grösser als 0 ist.

### 2.2 JOIN-Übungen

Verwende die Verein-Datenbank, um die folgenden Informationen mit verschiedenen JOIN-Typen abzufragen:

a) Zeige alle Personen und ihre Funktionen an. Verwende einen INNER JOIN, um nur Personen mit Funktionen anzuzeigen.

b) Zeige alle Personen und ihre Anlässe an. Verwende einen LEFT JOIN, um auch Personen ohne Anlässe anzuzeigen.

c) Liste alle Anlässe und die dazugehörigen Teilnehmer auf. Verwende einen RIGHT JOIN, um auch Anlässe ohne Teilnehmer anzuzeigen.

d) Zeige alle Personen und alle Sponsoren an, die sie betreuen. Verwende einen FULL JOIN, um alle Personen (auch ohne betreute Sponsoren) und alle Sponsoren (auch ohne betreuende Person) anzuzeigen.

e) Erstelle eine Selbstverknüpfung (Self-Join) mit der Tabelle `Person`, um alle Mentor-Mentee-Beziehungen anzuzeigen.

### 2.3 Komplexe Abfragen mit Aggregation

Schreibe SQL-Abfragen für die folgenden Aufgaben:

a) Zähle, wie viele Personen in jedem Ort wohnen und sortiere das Ergebnis absteigend nach der Anzahl.

b) Berechne die durchschnittliche Anzahl von Teilnehmern pro Anlass.

c) Finde für jeden Status die Anzahl der Personen und den durchschnittlichen Mitgliedsbeitrag.

d) Liste für jeden Sponsor die Gesamtsumme der Spenden, die Anzahl der Spenden und den Durchschnittsbetrag pro Spende auf.

e) Zeige alle Orte an, in denen mehr als 2 Personen wohnen, und gib auch die Anzahl der männlichen und weiblichen Personen pro Ort an. (Anmerkung: Da das Geschlecht nicht als Spalte existiert, verwende für diese Übung eine Annahme basierend auf dem Vornamen oder führe diese Übung nur theoretisch durch.)

### 2.4 Implementierung eines ER-Diagramms

Gegeben sei das folgende ER-Diagramm für ein einfaches Blog-System:

![](exercises/8_exam_preparation/img/artikel.png)

Schreibe die DDL-Befehle, um dieses Datenbankschema zu implementieren. Achte dabei auf:

a) Korrekte Primär- und Fremdschlüssel
b) Geeignete Datentypen
c) NOT NULL Constraints, wo sinnvoll
d) CHECK Constraints für Datenvalidierung, wo sinnvoll
e) Geeignete Bezeichnungen für Constraints und Indizes

### 2.5 Komplexe Abfragen mit mehreren JOINs und Aggregation

Schreibe SQL-Abfragen für die folgenden Aufgaben, die jeweils mehrere JOINs und Aggregationen kombinieren:

a) Erstelle eine Übersicht aller Anlässe mit der Anzahl der Teilnehmer, dem Namen des Organisators und der Summe der für diesen Anlass erhaltenen Spenden.

b) Liste für jede Person auf, an wie vielen Anlässen sie teilgenommen hat und wie viele Funktionen sie im Verein innehat oder hatte.

c) Erstelle einen Bericht, der für jeden Ort die Anzahl der dort wohnenden Personen, die durchschnittliche Anzahl der von ihnen besuchten Anlässe und die Gesamtsumme der von lokalen Sponsoren erhaltenen Spenden anzeigt.

## Zusatzaufgaben

### 3.1 Advanced Subqueries

Schreibe SQL-Abfragen mit Unterabfragen für die folgenden Aufgaben:

a) Finde alle Personen, die an jedem Anlass teilgenommen haben (d.h. keine Anlässe verpasst haben).

b) Liste alle Sponsoren auf, deren durchschnittlicher Spendenbetrag höher ist als der Gesamtdurchschnitt aller Spenden.

c) Finde für jede Person die neueste Funktionsbesetzung (basierend auf dem Antrittsdatum).

### 3.2 Common Table Expressions (CTEs)

Schreibe folgende Abfragen mit CTEs:

a) Erstelle eine Rangfolge der Personen nach Anzahl der besuchten Anlässe.

b) Berechne für jede Person die Differenz zwischen ihrer durchschnittlichen Anlass-Teilnahme und dem Gesamtdurchschnitt.

c) Ermittle die "Spenden-Effizienz" jedes Sponsors, indem du das Verhältnis zwischen der Anzahl der Spenden und dem Gesamtbetrag berechnest, und vergleiche es mit dem Durchschnitt.

---

Denke daran, die Lösungen auf einem separaten Blatt oder in einer Datei zu notieren, damit du später deine Antworten mit den Musterlösungen vergleichen kannst.
