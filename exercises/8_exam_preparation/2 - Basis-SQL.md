---
title: "Prüfungsvorbereitung: SQL-Grundlagen"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DML
    - Datentypen
    - NULL-Werte
    - SELECT
---

# Prüfungsvorbereitung: SQL-Grundlagen

## Übungsziele

In diesem Übungsblatt werden die Grundlagen der SQL-Abfragen und Datenmanipulation wiederholt und vertieft. Nach Bearbeitung dieser Übungen solltest du:

- Komplexe SELECT-Abfragen formulieren können
- Daten mit INSERT, UPDATE und DELETE manipulieren können
- Filterung, Sortierung und Begrenzung von Ergebnissen beherrschen
- Die korrekte Anwendung von NULL-Werten verstehen
- Praxisnahe SQL-Szenarien lösen können

## Theoretische Fragen

### 1.1 SQL-Grundbegriffe

Erkläre kurz den Unterschied zwischen:

a) DML (Data Manipulation Language) und DDL (Data Definition Language)
b) WHERE und HAVING
c) ORDER BY und GROUP BY
d) DISTINCT und GROUP BY

### 1.2 NULL-Werte

Beschreibe, wie NULL-Werte in folgenden Situationen behandelt werden:

a) In Vergleichen mit `=` oder `<>`
b) In logischen Ausdrücken mit `AND` und `OR`
c) In Aggregatfunktionen wie `COUNT()`, `SUM()`, `AVG()`

### 1.3 Datentypen

Welcher SQL-Datentyp wäre am besten geeignet für die folgenden Informationen und warum?

a) Eine Schweizer Postleitzahl
b) Ein Geldbetrag mit zwei Nachkommastellen
c) Eine E-Mail-Adresse
d) Ein Geburtsdatum (ohne Uhrzeit)
e) Ein Status, der nur "aktiv", "inaktiv" oder "gesperrt" sein kann

## Praktische Übungen

### 2.1 SELECT-Abfragen

Verwende die Verein-Datenbank, um folgende Informationen abzufragen:

a) Liste alle Personen (Name, Vorname) alphabetisch nach Nachnamen sortiert auf, die in Grenchen wohnen.

b) Zeige alle Anlässe (Bezeichner, Datum) an, deren Datum in der Zukunft liegt, sortiert nach Datum (aufsteigend).

c) Finde alle Sponsoren mit einem Spendentotal über 1000 und zeige ihren Namen und das Spendentotal an.

d) Erstelle eine Liste aller Orte und zähle, wie viele Personen jeweils dort wohnen. Zeige nur Orte mit mehr als 2 Personen an.

### 2.2 Filterbedingungen

Schreibe SQL-Abfragen für die folgenden Aufgaben:

a) Finde alle Personen, deren Name mit 'M' beginnt oder deren Vorname mit 'A' beginnt.

b) Liste alle Personen auf, die keine Mentoren sind (deren PersID nicht als MentorID bei anderen Personen vorkommt).

c) Zeige alle Anlässe mit Kosten zwischen 100 und 200 oder ohne eingetragene Kosten (NULL).

d) Finde alle Personen, die im Jahr 2014 eingetreten sind.

### 2.3 Datenmanipulation mit INSERT, UPDATE und DELETE

Schreibe SQL-Anweisungen für die folgenden Aufgaben:

a) Füge eine neue Person mit dem Status "Aktiv" hinzu. Verwende für die ID einen UUID-Wert (kann fiktiv sein, solange er dem UUID-Format entspricht).

b) Ändere den Wohnort aller Personen von "Bettlach" zu "Solothurn".

c) Erhöhe die Kosten aller Anlässe um 10%.

d) Lösche alle Spenden mit einem Betrag unter 100.

### 2.4 Komplexere Abfragen

a) Erstelle eine Liste aller Personen mit einer Zählung, an wie vielen Anlässen jede Person teilgenommen hat. Auch Personen ohne Teilnahmen sollen erscheinen (mit Zählung 0).

b) Finde den durchschnittlichen Spendenbetrag pro Sponsor und vergleiche ihn mit dem Gesamtdurchschnitt aller Spenden.

c) Ermittle für jede Person das Datum ihres ersten und letzten Anlasses sowie die Gesamtzahl der Anlässe, an denen sie teilgenommen hat.

### 2.5 Praktische Anwendungsfälle

a) Der Verein möchte eine E-Mail an alle aktiven Mitglieder senden. Erstelle eine SQL-Abfrage, die eine Liste mit Namen, Vornamen und E-Mail-Adressen aller aktiven Mitglieder (Status "Aktiv") erzeugt, die ihren Beitrag noch nicht bezahlt haben (bezahlt = 'N').

b) Für einen Jahresbericht soll eine Statistik erstellt werden, die zeigt, wie sich die Mitgliederzahl über die Jahre entwickelt hat. Schreibe eine Abfrage, die für jedes Jahr die Anzahl der Eintritte und die Anzahl der Austritte ausgibt.

c) Der Verein plant ein Jubiläumsfest und möchte Einladungen an alle Mitglieder und Sponsoren versenden. Erstelle eine SQL-Abfrage, die eine Liste aller Personen und Sponsoren mit Namen und Adressdaten erzeugt, ohne Duplikate (falls eine Person auch Sponsor ist).

## Zusatzaufgaben

### 3.1 Fortgeschrittene Texttransformation

a) Schreibe eine Abfrage, die für alle Personen den Namen in Grossbuchstaben und den Vornamen mit dem ersten Buchstaben gross und den Rest klein ausgibt.

Beispiel: "müller, hans" → "MÜLLER, Hans"

b) Erstelle eine Anrede für einen Brief, die wie folgt formatiert ist: "Sehr geehrte(r) Herr/Frau [Nachname]". Nimm für diese Übung an, dass es eine Spalte "geschlecht" mit den Werten 'm' und 'w' gibt.

### 3.2 Datumsfunktionen

a) Liste alle Personen mit ihrem Eintrittsdatum und der Anzahl der Jahre auf, die sie bereits Mitglied sind.

b) Finde alle Anlässe, die an einem Wochenende (Samstag oder Sonntag) stattfinden.

---

Denke daran, die Lösungen auf einem separaten Blatt oder in einer Datei zu notieren, damit du später deine Antworten mit den Musterlösungen vergleichen kannst.
