---
title: "SQL-Grundlagen / Übung 2: SQL-Grundlagen für das Veranstaltungsmanagement"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - SQL
---
# Übung 2: SQL-Grundlagen für das Veranstaltungsmanagement

## Lernziele
- Planung und Verwaltung von Vereinsanlässen mittels SQL
- Implementierung von Anmelde- und Teilnehmerverwaltungsprozessen
- Erstellung von Teilnehmerlisten und statistischen Auswertungen

## Relevanz für die Praxis

Die Organisation von Veranstaltungen ist eine Kernaufgabe vieler Vereine und Organisationen. Eine effiziente Datenbankunterstützung kann hier den administrativen Aufwand erheblich reduzieren:

- Veranstaltungen müssen geplant und dokumentiert werden
- Teilnehmerlisten müssen verwaltet und aktualisiert werden
- Teilnehmerstatistiken werden für die Evaluation benötigt
- Bei regelmässigen Veranstaltungen lassen sich Trends erkennen

Die in dieser Übung erlernten Techniken sind nicht nur für Vereine relevant, sondern finden Anwendung in allen Bereichen des Event-Managements, von Unternehmensveranstaltungen bis hin zu öffentlichen Veranstaltungen und Konferenzen.

## Theoretische Grundlagen

### Datenmodell Veranstaltungsmanagement
In unserer Vereinsdatenbank werden Veranstaltungen und Teilnehmer über folgende Tabellen verwaltet:
- `Anlass`: Enthält Informationen zu Veranstaltungen (Bezeichner, Ort, Datum, Kosten)
- `Person`: Persönliche Daten der potentiellen Teilnehmer
- `Teilnehmer`: Verknüpfungstabelle zwischen Anlass und Person (m:n-Beziehung)
- `Status`: Status der Personen (relevant für Teilnehmerstatistiken)

### Schlüsselkonzepte
- **INSERT mit Subqueries**: Einfügen von Daten mit Unterabfragen für Fremdschlüssel
- **Mehrere Datensätze gleichzeitig einfügen**: Effiziente Methoden für Massenoperationen
- **Komplexe JOIN-Abfragen**: Verknüpfen mehrerer Tabellen für aussagekräftige Ergebnisse
- **Aggregatfunktionen**: Zusammenfassen von Daten für statistische Auswertungen
- **Prozentuale Berechnungen**: Relative Werte für bessere Vergleichbarkeit

## Praktische Übungen

### Aufgabe 1: Veranstaltung planen

Erstelle einen neuen Vereinsanlass in der Datenbank.

```sql
-- Neuen Anlass einfügen
INSERT INTO Anlass (
    AnlaID, Bezeichner, Ort, Datum, Kosten, OrgID
)
VALUES (
    gen_random_uuid(),  -- UUID generieren
    'Sommerfest 2025',
    'Stadtpark Bern',
    '2025-07-20',  -- Datum im ISO-Format
    1500.00,  -- Geschätzte Kosten
    (SELECT PersID FROM Person WHERE Name = 'Frei' AND Vorname = 'Barbara')  -- Organisator
);
```

**Übungsaufgabe**: Erstelle einen weiteren Anlass mit eigenen Daten für eine Vereins-Generalversammlung im nächsten Jahr. Denke daran, einen passenden Organisator zu wählen.

### Aufgabe 2: Teilnehmer-Anmeldungen erfassen

Erfasse Anmeldungen von Mitgliedern für den Anlass.

```sql
-- Teilnehmer für einen Anlass registrieren
INSERT INTO Teilnehmer (PersID, AnlaID)
VALUES (
    (SELECT PersID FROM Person WHERE Name = 'Cadola' AND Vorname = 'Leo'),
    (SELECT AnlaID FROM Anlass WHERE Bezeichner = 'Sommerfest 2025')
);

-- Mehrere Teilnehmer auf einmal registrieren
INSERT INTO Teilnehmer (PersID, AnlaID)
SELECT 
    p.PersID,
    (SELECT AnlaID FROM Anlass WHERE Bezeichner = 'Sommerfest 2025')
FROM 
    Person p
WHERE 
    p.Name IN ('Bart', 'Huber', 'Luder')
    AND p.Austritt IS NULL;
```

**Übungsaufgabe**: Registriere alle aktiven Mitglieder, die in Bern wohnen, für den zuvor erstellten Generalversammlungs-Anlass.

### Aufgabe 3: Teilnehmerliste erstellen

Erstelle eine Teilnehmerliste für einen bestimmten Anlass.

```sql
-- Teilnehmerliste für einen bestimmten Anlass
SELECT 
    p.Name, 
    p.Vorname, 
    p.Ort,
    s.Bezeichner AS Status
FROM 
    Person p
JOIN 
    Teilnehmer t ON p.PersID = t.PersID
JOIN 
    Status s ON p.StatID = s.StatID
JOIN 
    Anlass a ON t.AnlaID = a.AnlaID
WHERE 
    a.Bezeichner = 'Sommerfest 2025'
ORDER BY 
    p.Name, p.Vorname;

-- Anzahl der Teilnehmer
SELECT 
    COUNT(*) AS Teilnehmeranzahl
FROM 
    Teilnehmer t
JOIN 
    Anlass a ON t.AnlaID = a.AnlaID
WHERE 
    a.Bezeichner = 'Sommerfest 2025';
```

**Übungsaufgabe**: Erweitere die Teilnehmerliste, sodass auch die Kontaktdaten (Telefon oder E-Mail) angezeigt werden, sofern in der Datenbank vorhanden. Falls diese Felder nicht existieren, überlege, wie die Tabelle Person erweitert werden müsste.

### Aufgabe 4: Veranstaltungsstatistik erstellen

Erstelle statistische Auswertungen nach der Veranstaltung.

```sql
-- Teilnahmestatistik nach Status
SELECT 
    s.Bezeichner AS Status,
    COUNT(t.PersID) AS Anzahl,
    ROUND(COUNT(t.PersID) * 100.0 / (SELECT COUNT(*) FROM Teilnehmer WHERE AnlaID = a.AnlaID), 1) AS Prozent
FROM 
    Anlass a
JOIN 
    Teilnehmer t ON a.AnlaID = t.AnlaID
JOIN 
    Person p ON t.PersID = p.PersID
JOIN 
    Status s ON p.StatID = s.StatID
WHERE 
    a.Bezeichner = 'Sommerfest 2025'
GROUP BY 
    s.Bezeichner, a.AnlaID
ORDER BY 
    Anzahl DESC;
```

**Übungsaufgabe**: Erstelle eine Statistik, die zeigt, aus welchen Orten die Teilnehmer kommen und wie hoch der prozentuale Anteil pro Ort ist.

## Herausforderungen und Erweiterungen

### Herausforderung 1: Teilnehmerlimits und Wartelisten
Ein Anlass hat eine maximale Teilnehmerzahl. Entwirf SQL-Abfragen, die:
1. Prüfen, ob das Limit bereits erreicht ist
2. Teilnehmer ggf. auf eine Warteliste setzen
3. Bei Absagen automatisch Teilnehmer von der Warteliste nachrücken lassen

Welche Änderungen am Datenbankschema wären notwendig?

### Herausforderung 2: Veranstaltungsserien
Entwickle ein Konzept für wiederkehrende Veranstaltungen, z.B. monatliche Stammtische. Wie könntest du mit SQL-Befehlen:
1. Eine Serie von Veranstaltungen effizient anlegen
2. Teilnahmetrends über mehrere Veranstaltungen hinweg analysieren
3. Regelmässige Teilnehmer identifizieren

### Herausforderung 3: Ressourcenplanung
Ein Vereinsanlass benötigt auch Ressourcen wie Räume, Equipment und Helfer. Entwirf eine Erweiterung des Datenbankschemas und SQL-Abfragen, die folgende Aspekte berücksichtigen:
1. Zuordnung von Ressourcen zu Anlässen
2. Prüfung auf Verfügbarkeit (keine Doppelbelegungen)
3. Übersicht über benötigte Ressourcen pro Anlass

### Erweiterung: Anmelde- und Abmeldeprozess
Entwickle ein Konzept für einen formalen Anmelde- und Abmeldeprozess inklusive Bestätigungen und Erinnerungen. Welche Daten müsstest du zusätzlich erfassen und welche SQL-Abfragen würden für die Automatisierung benötigt?

## Reflexion

- Inwiefern können SQL-Abfragen den organisatorischen Aufwand bei der Veranstaltungsplanung reduzieren?
- Welche Vorteile bietet die Verwendung von Subqueries beim Einfügen von Teilnehmerdaten?
- Wie könnten die statistischen Auswertungen genutzt werden, um zukünftige Veranstaltungen besser zu planen?
- Welche ethischen Aspekte sind bei der Verwaltung von Teilnehmerdaten zu beachten?
