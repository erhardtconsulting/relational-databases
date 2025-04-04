---
title: "Fortgeschrittenes SQL / Übung 1: Data Definition Language (DDL)"
author: 
    - Simon Erhardt
date: "05.04.2025"
keywords:
    - SQL
---

# Übung: Data Definition Language (DDL)

## Lernziele

In dieser Übung wirst du:
- Ein ER-Diagramm in SQL-DDL-Anweisungen umsetzen
- Mit CREATE TABLE-Statements Tabellen anlegen
- PRIMARY KEY und FOREIGN KEY Constraints definieren
- CHECK-Constraints für Datenvalidierung implementieren
- ALTER TABLE-Anweisungen verwenden, um vorhandene Tabellen zu erweitern

## Aufgabe: Implementierung einer Bibliotheksdatenbank

### Szenario

Du bist für die Entwicklung einer Datenbank für eine kleine Bibliothek verantwortlich. Die Bibliothek möchte ihre Bücher, Autoren, Ausleihen und Leser digital verwalten.

### ER-Diagramm

Das folgende ER-Diagramm zeigt die Struktur der Bibliotheksdatenbank:

![](exercises/7_advanced_sql/img/bibliothek.png)

### Teil 1: Basistabellen erstellen

Schreibe DDL-Anweisungen, um die folgenden Tabellen zu erstellen:

1. `Autor` mit folgenden Eigenschaften:
   - `AutorID`: Ein automatisch generierter Primärschlüssel
   - `Name`: Muss angegeben werden, maximal 50 Zeichen
   - `Vorname`: Muss angegeben werden, maximal 50 Zeichen
   - `Geburtsjahr`: Optional, muss zwischen 1400 und dem aktuellen Jahr liegen

2. `Leser` mit folgenden Eigenschaften:
   - `LeserID`: Ein automatisch generierter Primärschlüssel
   - `Name`: Muss angegeben werden, maximal 100 Zeichen
   - `Email`: Muss angegeben werden, maximal 100 Zeichen, muss ein @-Zeichen enthalten
   - `Adresse`: Optional, maximal 200 Zeichen
   - `Telefon`: Optional, maximal 20 Zeichen

3. `Buch` mit folgenden Eigenschaften:
   - `BuchID`: Ein automatisch generierter Primärschlüssel
   - `Titel`: Muss angegeben werden, maximal 200 Zeichen
   - `ISBN`: Optional, maximal 20 Zeichen, muss eindeutig sein
   - `Jahr`: Optional, muss zwischen 1400 und dem aktuellen Jahr liegen
   - `Verlag`: Optional, maximal 100 Zeichen
   - `AutorID`: Fremdschlüssel zur Tabelle `Autor`

4. `Ausleihe` mit folgenden Eigenschaften:
   - `AusleihID`: Ein automatisch generierter Primärschlüssel
   - `BuchID`: Fremdschlüssel zur Tabelle `Buch`
   - `LeserID`: Fremdschlüssel zur Tabelle `Leser`
   - `Ausleihdatum`: Muss angegeben werden, standardmässig das aktuelle Datum
   - `Rueckgabedatum`: Optional, muss nach dem Ausleihdatum liegen
   - `Verlaengert`: Ein Boolean-Wert, der angibt, ob die Ausleihe verlängert wurde (standardmässig false)

Beachte bei der Implementierung:
- Verwende sinnvolle Datentypen für alle Spalten
- Implementiere alle notwendigen Constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK)
- Definiere für die Fremdschlüssel ein geeignetes Verhalten bei DELETE-Operationen

### Teil 2: Tabellenerweiterungen

Nachdem du die Basistabellen erstellt hast, sollen einige Erweiterungen vorgenommen werden:

1. Füge der Tabelle `Buch` eine neue Spalte `Seitenzahl` hinzu (Ganzzahl, optional)
2. Füge der Tabelle `Buch` eine neue Spalte `Kategorie` hinzu (maximal 50 Zeichen, optional)
3. Füge der Tabelle `Autor` eine neue Spalte `Nationalitaet` hinzu (maximal 50 Zeichen, optional)
4. Füge der Tabelle `Leser` eine neue Spalte `Registrierungsdatum` hinzu (Datum, standardmässig das aktuelle Datum)
5. Erstelle einen neuen CHECK-Constraint für die Tabelle `Buch`, der sicherstellt, dass die `Seitenzahl` grösser als 0 ist, falls ein Wert angegeben wird

### Teil 3: Fortgeschrittene Anpassungen

1. Erstelle eine neue Tabelle `Kategorie` mit folgenden Eigenschaften:
   - `KategorieID`: Ein automatisch generierter Primärschlüssel
   - `Name`: Muss angegeben werden, maximal 50 Zeichen, muss eindeutig sein
   - `Beschreibung`: Optional, maximal 200 Zeichen

2. Entferne die zuvor erstellte Spalte `Kategorie` aus der Tabelle `Buch` und ersetze sie durch einen Fremdschlüssel `KategorieID`, der auf die neue Tabelle `Kategorie` verweist

3. Erstelle eine neue Tabelle `Bewertung` mit folgenden Eigenschaften:
   - `BewertungID`: Ein automatisch generierter Primärschlüssel
   - `BuchID`: Fremdschlüssel zur Tabelle `Buch`
   - `LeserID`: Fremdschlüssel zur Tabelle `Leser`
   - `Sterne`: Eine Zahl zwischen 1 und 5
   - `Kommentar`: Optional, maximal 500 Zeichen
   - `Datum`: Das Datum der Bewertung, standardmässig das aktuelle Datum
   - Ein Leser darf ein Buch nur einmal bewerten (implementiere einen geeigneten Constraint)


## Abgabeformat

Erstelle ein SQL-Skript, das alle DDL-Anweisungen zur Lösung der Aufgaben enthält. Achte darauf, dass das Skript in der angegebenen Reihenfolge ausgeführt werden kann und alle Anforderungen erfüllt.

## Hinweise

- Achte auf korrekte SQL-Syntax und Einrückung für bessere Lesbarkeit
- Nutze sprechende Namen für Constraints (z.B. `ck_buch_seitenzahl` statt nur `check1`)
- Verwende SERIAL für automatisch generierte Primärschlüssel (PostgreSQL)
- Vergiss nicht, dass für manche Operationen (wie das Hinzufügen von NOT NULL-Constraints zu bestehenden Spalten) zusätzliche Schritte notwendig sein können
- Teste deine Lösung, indem du das Skript in einer PostgreSQL-Datenbank ausführst
