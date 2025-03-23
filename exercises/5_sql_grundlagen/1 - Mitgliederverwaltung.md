---
title: "SQL-Grundlagen / Übung 1: SQL-Grundlagen für die Mitgliederverwaltung"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - SQL
---
# Übung 1: SQL-Grundlagen für die Mitgliederverwaltung

## Lernziele
- SQL-Befehle im Kontext einer Vereinsdatenbank anwenden
- INSERT, UPDATE und SELECT Operationen für die Mitgliederverwaltung nutzen
- Transaktionen zur Wahrung der Datenintegrität einsetzen

## Relevanz für die Praxis

Jeder Verein benötigt eine effiziente Mitgliederverwaltung. Als Datenbank-Administrator oder Entwickler wirst du häufig mit Aufgaben konfrontiert wie:
- Neue Mitglieder in die Datenbank aufnehmen
- Übersichten für den Vorstand erstellen
- Zahlungsstatus verfolgen und aktualisieren

Diese Operationen bilden die Grundlage für die tägliche Arbeit mit Datenbanken in vielen Organisationen. Die hier erlernten Techniken sind direkt auf andere Anwendungsfälle wie Kundenverwaltung oder Personalmanagement übertragbar.

## Theoretische Grundlagen

### Datenmodell Vereinsmitglieder
In unserer Vereinsdatenbank werden Mitglieder über mehrere Tabellen verwaltet:
- `Person`: Enthält persönliche Daten wie Name, Adresse und Beitrittsdatum
- `Status`: Definiert verschiedene Mitgliedschaftstypen mit unterschiedlichen Beiträgen
- `Funktion`: Enthält mögliche Rollen im Verein
- `Funktionsbesetzung`: Verknüpft Personen mit ihren Funktionen

### Schlüsselkonzepte
- **Transaktionen**: Zusammenfassen mehrerer SQL-Befehle zu einer logischen Einheit
- **Fremdschlüsselbeziehungen**: Verknüpfung von Tabellen, z.B. Person mit Status
- **Abfragen mit Verknüpfungen**: JOIN-Operationen für aussagekräftige Ergebnisse
- **Aggregatfunktionen**: Zusammenfassen von Daten, z.B. für Statistiken

## Praktische Übungen

### Aufgabe 1: Neue Mitglieder aufnehmen

Füge ein neues Mitglied in die Datenbank ein und weise ihm die Standardfunktion "Mitglied" zu.

```sql
-- Schritt 1: Transaktion starten
BEGIN;

-- Schritt 2: Neues Mitglied in die Personen-Tabelle einfügen
INSERT INTO Person (
    PersID, Name, Vorname, Strasse_Nr, PLZ, Ort, 
    bezahlt, Bemerkungen, Eintritt, StatID
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Muster', 'Maria', 'Seeweg 15', '3000', 'Bern',
    'N',  -- Noch nicht bezahlt
    'Über Webformular beigetreten',
    CURRENT_DATE,  -- Heutiges Datum als Eintrittsdatum
    (SELECT StatID FROM Status WHERE Bezeichner = 'Aktiv') -- Subquery
);

-- Schritt 3: Funktion zuweisen (zuerst manuell die PersID ermitteln)
-- In einer realen Anwendung würde dies über die Anwendungslogik oder einen Trigger erfolgen

-- Mitglied mit ID abfragen (Ergebnis merken für den nächsten Schritt)
SELECT PersID
    FROM Person
    WHERE Name = 'Muster' AND Vorname = 'Maria' AND Eintritt = CURRENT_DATE;

-- Schritt 4: Transaktion abschliessen
COMMIT;
```

**Übungsaufgabe**: Füge ein weiteres Mitglied mit eigenen Daten hinzu und weise ihm die Funktion "Kassier" zu.

### Aufgabe 2: Mitgliederübersicht erstellen

Erstelle eine Übersicht aller aktiven Mitglieder mit ihrem Status.

```sql
-- Aktive Mitglieder (ohne Austrittsdatum) mit Statusbezeichnung abfragen
SELECT 
    p.Name, 
    p.Vorname, 
    p.Eintritt, 
    s.Bezeichner AS Status,
    s.Beitrag AS Jahresbeitrag,
    p.bezahlt,
    p.Ort
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.Austritt IS NULL
ORDER BY 
    p.Name, p.Vorname;
```

**Übungsaufgabe**: Erweitere die Abfrage, sodass nur Mitglieder mit dem Status "aktiv" angezeigt werden.

### Aufgabe 3: Säumige Zahler identifizieren

Identifiziere alle Mitglieder, die ihren Beitrag noch nicht bezahlt haben.

```sql
-- Mitglieder mit unbezahltem Beitrag abfragen
SELECT 
    p.Name, 
    p.Vorname, 
    p.Strasse_Nr,
    p.PLZ,
    p.Ort, 
    s.Beitrag,
    p.Eintritt
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.bezahlt = 'N'
    AND p.Austritt IS NULL
    AND s.Beitrag > 0  -- Nur Mitglieder, die tatsächlich einen Beitrag zahlen müssen
ORDER BY 
    p.Name, p.Vorname;

-- Gesamtbetrag der ausstehenden Zahlungen berechnen
SELECT 
    SUM(s.Beitrag) AS Gesamtausstehend
FROM 
    Person p
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    p.bezahlt = 'N'
    AND p.Austritt IS NULL
    AND s.Beitrag > 0;
```

**Übungsaufgabe**: Erstelle eine Abfrage, die den Prozentsatz der säumigen Zahler an der Gesamtmitgliederzahl berechnet.

### Aufgabe 4: Zahlungsstatus aktualisieren

Aktualisiere den Zahlungsstatus von Mitgliedern nach Eingang der Beiträge.

```sql
-- Beitragszahlung für ein einzelnes Mitglied registrieren
UPDATE Person
SET bezahlt = 'J'
WHERE PersID = '123e4567-e89b-12d3-a456-426614174000';  -- UUID des Mitglieds

-- Mehrere Mitglieder mit einer Liste von IDs aktualisieren
UPDATE Person
SET bezahlt = 'J'
WHERE PersID IN (
    '123e4567-e89b-12d3-a456-426614174000',
    '234f5678-f90c-23e4-b567-537725285111',
    '345g6789-g01d-34f5-c678-648836396222'
);
```

**Übungsaufgabe**: Schreibe eine SQL-Anweisung, die den Zahlungsstatus aller Mitglieder eines bestimmten Ortes (z.B. "Bern") auf "bezahlt" setzt.

## Herausforderungen und Erweiterungen

### Herausforderung 1: Massenaktualisiung mit Protokollierung
Entwirf eine SQL-Lösung, die nicht nur den Zahlungsstatus aktualisiert, sondern auch ein Protokoll der Zahlungseingänge führt. Was müsste am Datenbankschema geändert werden?

### Herausforderung 2: Beitragserhöhung
Stelle dir vor, der Verein beschliesst eine Beitragserhöhung um 10% für alle Mitgliedstypen. Wie würdest du dies in der Datenbank umsetzen? Bedenke auch, welche Auswirkungen dies auf bereits bezahlte und noch offene Beiträge hat.

### Herausforderung 3: Mitgliederstatus-Wechsel
Was passiert, wenn ein Mitglied seinen Status ändert (z.B. von Aktivmitglied zu Ehrenmitglied)? Überlege, welche SQL-Anweisungen notwendig wären und wie sich dies auf den Zahlungsstatus auswirkt.

### Erweiterung: Automatische E-Mail-Erinnerung
Entwickle ein Konzept, wie du mithilfe der Datenbank-Abfragen ein System zur automatischen Erinnerung für säumige Zahler implementieren könntest. Welche zusätzlichen Daten müsstest du erfassen?

## Reflexion

- Welche Vorteile bietet die Verwendung von Transaktionen bei der Mitgliederverwaltung?
- Wie wichtig ist die referenzielle Integrität (Fremdschlüsselbeziehungen) in diesem Kontext?
- Welche Fehlerquellen könnten bei der manuellen Eingabe von Mitgliederdaten auftreten und wie könnten diese minimiert werden?
