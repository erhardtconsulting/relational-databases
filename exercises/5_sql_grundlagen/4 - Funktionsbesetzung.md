---
title: "SQL-Grundlagen / Übung 4: SQL-Grundlagen für die Funktionsbesetzung im Verein"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - SQL
---
# Übung 4: SQL-Grundlagen für die Funktionsbesetzung im Verein

## Lernziele
- Verwaltung von Funktionen und Ämtern in Vereinsstrukturen mittels SQL
- Implementierung von Zuweisungen, Rücktritten und Nachfolgeplanung
- Erstellung übersichtlicher Darstellungen der Vereinsleitung und -organisation

## Relevanz für die Praxis

Die Organisation eines Vereins erfordert eine klare Struktur mit definierten Rollen und Verantwortlichkeiten. Eine effiziente datenbankgestützte Verwaltung dieser Funktionen bietet zahlreiche Vorteile:

- Transparente Darstellung der Vereinsstruktur und Verantwortlichkeiten
- Lückenlose Dokumentation von Amtsübernahmen und Rücktritten
- Planungssicherheit bei anstehenden Wechseln in der Vereinsleitung
- Historische Nachvollziehbarkeit der Vereinsentwicklung
- Grundlage für Kontaktlisten, Webseiten-Inhalte und offizielle Dokumente

Die hier erlernten Techniken sind übertragbar auf andere organisatorische Strukturen wie Unternehmen, Behörden oder Bildungseinrichtungen, wo ebenfalls Positionen, Rollen und deren zeitliche Entwicklung verwaltet werden müssen.

## Theoretische Grundlagen

### Datenmodell Funktionsbesetzung
In unserer Vereinsdatenbank werden Funktionen und deren Besetzung über folgende Tabellen verwaltet:
- `Funktion`: Enthält die verschiedenen Rollen im Verein (z.B. Präsident, Kassier)
- `Person`: Enthält die persönlichen Daten der Vereinsmitglieder
- `Funktionsbesetzung`: Verknüpfungstabelle, die Personen mit Funktionen verbindet und den Zeitraum der Amtsausübung dokumentiert

### Schlüsselkonzepte
- **N:M-Beziehungen**: Eine Person kann mehrere Funktionen innehaben, und eine Funktion kann im Laufe der Zeit von verschiedenen Personen ausgeübt werden
- **Zeitbezogene Daten**: Antritts- und Rücktrittsdaten definieren den Zeitraum der Amtsausübung
- **NULL-Werte**: Ein NULL-Wert beim Rücktrittsdatum bedeutet, dass die Person die Funktion aktuell noch ausübt
- **Benutzerdefinierte Sortierung**: Anpassung der Sortierreihenfolge für eine sinnvolle Darstellung der Vereinshierarchie
- **CASE-Ausdrücke**: Flexible Anpassung der Abfrageergebnisse basierend auf Bedingungen

## Praktische Übungen

### Aufgabe 1: Funktionsträger erfassen

Erfasse eine neue Funktionsbesetzung in der Datenbank.

```sql
-- Neue Funktionsbesetzung registrieren
INSERT INTO Funktionsbesetzung (
    FunkID, PersID, Antritt, Ruecktritt
)
VALUES (
    (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Kasse'),
    (SELECT PersID FROM Person WHERE Name = 'Wendel' AND Vorname = 'Otto'),
    '2025-01-01',  -- Antritt
    NULL  -- Noch kein Rücktritt
);
```

**Übungsaufgabe**: Erfasse eine weitere Funktionsbesetzung für eine andere Position und Person deiner Wahl. Achte darauf, dass das Antrittsdatum in der Zukunft liegt.

### Aufgabe 2: Rücktritt registrieren

Erfasse den Rücktritt eines Funktionsträgers.

```sql
-- Rücktritt eines Funktionsträgers erfassen
UPDATE Funktionsbesetzung
SET Ruecktritt = '2025-12-31'
WHERE 
    FunkID = (SELECT FunkID FROM Funktion WHERE Bezeichner = 'Praesidium')
    AND PersID = (SELECT PersID FROM Person WHERE Name = 'Gruber' AND Vorname = 'Romy')
    AND Ruecktritt IS NULL;
```

**Übungsaufgabe**: Modifiziere die obige Abfrage so, dass sie zusätzlich überprüft, ob das Rücktrittsdatum nach dem Antrittsdatum liegt, um fehlerhafte Einträge zu vermeiden.

### Aufgabe 3: Aktuelle Vereinsleitung anzeigen

Erstelle eine Übersicht der aktuellen Funktionsträger.

```sql
-- Aktuelle Funktionsträger
SELECT 
    f.Bezeichner AS Funktion,
    p.Name,
    p.Vorname,
    fb.Antritt,
    fb.Ruecktritt,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, fb.Antritt)) AS Jahre_im_Amt
FROM 
    Funktion f
JOIN 
    Funktionsbesetzung fb ON f.FunkID = fb.FunkID
JOIN 
    Person p ON fb.PersID = p.PersID
WHERE 
    fb.Ruecktritt IS NULL OR fb.Ruecktritt >= CURRENT_DATE  -- Nur aktuelle Funktionsträger
ORDER BY 
    CASE 
        WHEN f.Bezeichner = 'Praesidium' THEN 1
        WHEN f.Bezeichner = 'Vizepraesidium' THEN 2
        WHEN f.Bezeichner = 'Kasse' THEN 3
        WHEN f.Bezeichner = 'Beisitz' THEN 4
        ELSE 5
    END,  -- Benutzerdefinierte Sortierung nach Wichtigkeit
    f.Bezeichner;
```

**Übungsaufgabe**: Erweitere die Abfrage, sodass zusätzlich die Kontaktinformationen der Funktionsträger (z.B. Adresse oder Wohnort) angezeigt werden.

### Aufgabe 4: Funktionshistorie anzeigen

Erstelle eine Übersicht aller Personen, die eine bestimmte Funktion ausgeübt haben.

```sql
-- Alle Personen, die jemals Präsident waren, chronologisch sortiert
SELECT 
    p.Name,
    p.Vorname,
    fb.Antritt,
    fb.Ruecktritt,
    CASE
        WHEN fb.Ruecktritt IS NULL THEN 'Aktuell im Amt'
        ELSE 'Zurückgetreten'
    END AS Status,
    CASE
        WHEN fb.Ruecktritt IS NULL THEN 
            EXTRACT(YEAR FROM AGE(CURRENT_DATE, fb.Antritt))
        ELSE 
            EXTRACT(YEAR FROM AGE(fb.Ruecktritt, fb.Antritt))
    END AS Amtsjahre
FROM 
    Person p
JOIN 
    Funktionsbesetzung fb ON p.PersID = fb.PersID
JOIN 
    Funktion f ON fb.FunkID = f.FunkID
WHERE 
    f.Bezeichner = 'Präsident'
ORDER BY 
    fb.Antritt;
```

**Übungsaufgabe**: Erstelle eine ähnliche Abfrage für eine andere Funktion (z.B. 'Kassier') und füge eine Berechnung hinzu, die die durchschnittliche Amtszeit aller vergangenen Amtsträger anzeigt.

## Herausforderungen und Erweiterungen

### Herausforderung 1: Amtsübergabe und Übergangszeiträume
In der Praxis gibt es oft Übergangszeiträume, in denen ein scheidender und ein neuer Funktionsträger parallel arbeiten. Entwickle ein Konzept, wie solche Übergangszeiträume in der Datenbank abgebildet werden könnten. Überlege:
1. Wie könnten die Tabellen erweitert werden?
2. Welche SQL-Abfragen wären für die Anzeige von Übergangsphasen notwendig?
3. Wie könnten automatische Prüfungen gewährleisten, dass keine Inkonsistenzen entstehen?

### Herausforderung 2: Wahlen und Amtsbestätigungen
Überlege, wie du das Datenmodell erweitern könntest, um auch Informationen über:
1. Wahlverfahren und -ergebnisse
2. Amtsbestätigungen/Wiederwahlen
3. Kandidaten für vakante Positionen
zu erfassen und auszuwerten.

## Reflexion

- Inwiefern unterstützt eine strukturierte Datenbankabbildung der Vereinsfunktionen die strategische Entwicklung eines Vereins?
- Welche Vorteile bietet die SQL-basierte Verwaltung von Funktionen gegenüber einer Excel-Liste oder einem Textdokument?
- Wie wichtig ist die historische Dokumentation von Funktionsbesetzungen für die Vereinsgeschichte und -entwicklung?
- Welche ethischen oder rechtlichen Aspekte sollten bei der Speicherung von Informationen über Rücktritte oder Amtsenthebungen beachtet werden?
