# Übung 5: SQL-Grundlagen für Datenanalyse und Reporting

## Lernziele
- Erstellung aussagekräftiger Berichte und Analysen mit SQL
- Anwendung komplexer Abfragetechniken für statistische Auswertungen
- Implementierung von longitudinalen Analysen und Trendauswertungen

## Relevanz für die Praxis

Die Fähigkeit, aus Datenbanken wertvolle Erkenntnisse zu gewinnen, ist heute entscheidend für datengestützte Entscheidungsprozesse. In Vereinen und Organisationen bietet Data Analytics viele Vorteile:

- Erkennung von Entwicklungstrends bei Mitgliederzahlen
- Identifikation erfolgreicher Veranstaltungsformate
- Fundierte Grundlagen für strategische Entscheidungen
- Unterstützung bei der Ressourcenplanung und Budgetierung
- Transparente Darstellung der Vereinsentwicklung für Mitglieder und Förderer

Die in dieser Übung erlernten SQL-Techniken für Datenanalyse und Reporting bilden eine wichtige Grundlage für Business Intelligence und Data Analytics, die in allen Bereichen von Wirtschaft, Verwaltung und Non-Profit-Sektor zunehmend an Bedeutung gewinnen.

## Theoretische Grundlagen

### Datenmodell für Analysen
In unserer Vereinsdatenbank nutzen wir für Analysen primär folgende Tabellen:
- `Person`: Enthält Mitgliederdaten mit Ein- und Austrittsdaten
- `Anlass`: Dokumentiert Vereinsveranstaltungen
- `Teilnehmer`: Verknüpft Personen mit Anlässen
- `Status`: Definiert Mitgliedschaftstypen
- `Funktion` und `Funktionsbesetzung`: Dokumentieren Ämter und deren Besetzung

### Schlüsselkonzepte
- **Zeitreihenanalysen**: Untersuchung von Daten über Zeitperioden hinweg
- **Aggregatfunktionen**: Zusammenfassung von Daten (COUNT, SUM, AVG, MIN, MAX)
- **Gruppierung und Untergruppierung**: Strukturierte Organisation von Daten mit GROUP BY
- **Common Table Expressions (CTE)**: Temporäre Ergebnismengen für komplexe Abfragen
- **Window-Funktionen**: Berechnungen über Datensatzgruppen hinweg
- **Dynamische Kreuztabellen**: Darstellung von Daten in Matrix-Form
- **EXTRACT und DATETIME-Funktionen**: Arbeiten mit zeitbezogenen Daten

## Praktische Übungen

### Aufgabe 1: Mitgliederentwicklung analysieren

Analysiere die Entwicklung der Mitgliederzahlen über verschiedene Jahre hinweg.

```sql
-- Eintritte pro Jahr
SELECT 
    EXTRACT(YEAR FROM Eintritt) AS Jahr,
    COUNT(*) AS Neue_Mitglieder
FROM 
    Person
WHERE 
    Eintritt IS NOT NULL
GROUP BY 
    EXTRACT(YEAR FROM Eintritt)
ORDER BY 
    Jahr;

-- Austritte pro Jahr
SELECT 
    EXTRACT(YEAR FROM Austritt) AS Jahr,
    COUNT(*) AS Ausgetretene_Mitglieder
FROM 
    Person
WHERE 
    Austritt IS NOT NULL
GROUP BY 
    EXTRACT(YEAR FROM Austritt)
ORDER BY 
    Jahr;

-- Netto-Entwicklung pro Jahr
SELECT 
    jahre.jahr,
    COALESCE(eintritte.anzahl, 0) AS Eintritte,
    COALESCE(austritte.anzahl, 0) AS Austritte,
    COALESCE(eintritte.anzahl, 0) - COALESCE(austritte.anzahl, 0) AS Netto
FROM 
    (SELECT DISTINCT EXTRACT(YEAR FROM Eintritt) AS jahr FROM Person
     UNION
     SELECT DISTINCT EXTRACT(YEAR FROM Austritt) AS jahr FROM Person WHERE Austritt IS NOT NULL) jahre
LEFT JOIN 
    (SELECT EXTRACT(YEAR FROM Eintritt) AS jahr, COUNT(*) AS anzahl FROM Person GROUP BY EXTRACT(YEAR FROM Eintritt)) eintritte
    ON jahre.jahr = eintritte.jahr
LEFT JOIN 
    (SELECT EXTRACT(YEAR FROM Austritt) AS jahr, COUNT(*) AS anzahl FROM Person WHERE Austritt IS NOT NULL GROUP BY EXTRACT(YEAR FROM Austritt)) austritte
    ON jahre.jahr = austritte.jahr
ORDER BY 
    jahre.jahr;
```

**Übungsaufgabe**: Erweitere die Analyse, indem du die Fluktuationsrate (Verhältnis der Summe aus Eintritten und Austritten zur Gesamtmitgliederzahl) pro Jahr berechnest. Dies gibt Aufschluss über die Stabilität der Mitgliederstruktur.

### Aufgabe 2: Mitgliederverteilung nach Kategorien analysieren

Analysiere die Verteilung der Mitglieder nach Status und Ort.

```sql
-- Verteilung nach Status mit Änderungsrate zum Vorjahr
SELECT 
    s.Bezeichner,
    COUNT(p.PersID) AS Aktuelle_Anzahl,
    -- Diese Abfrage wurde vereinfacht, um auf komplexe CTEs zu verzichten
    -- In einer realen Anwendung würde man hier Vergleichswerte zum Vorjahr berechnen
    ROUND(COUNT(p.PersID) * 100.0 / (SELECT COUNT(*) FROM Person WHERE Austritt IS NULL), 1) AS Prozent_Gesamt
FROM 
    Status s
LEFT JOIN 
    Person p ON s.StatID = p.StatID AND p.Austritt IS NULL
GROUP BY 
    s.Bezeichner
ORDER BY 
    Aktuelle_Anzahl DESC;

-- Verteilung nach Orten (Top 10)
SELECT 
    p.Ort,
    COUNT(*) AS Anzahl_Mitglieder,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person WHERE Austritt IS NULL), 1) AS Prozent
FROM 
    Person p
WHERE 
    p.Austritt IS NULL
GROUP BY 
    p.Ort
ORDER BY 
    Anzahl_Mitglieder DESC
LIMIT 10;
```

**Übungsaufgabe**: Erstelle eine Abfrage, die die Altersstruktur der Mitglieder analysiert (falls Geburtsdaten in der Datenbank vorhanden sind) oder alternativ die Verteilung nach Mitgliedschaftsdauer.

### Aufgabe 3: Anlässe nach Beliebtheit analysieren

Erstelle eine Auswertung der Veranstaltungen nach Teilnehmerzahl und Kosteneffizienz.

```sql
-- Anlässe nach Teilnehmerzahl
SELECT 
    a.Bezeichner AS Anlass,
    a.Datum,
    COUNT(t.PersID) AS Teilnehmer,
    a.Kosten,
    CASE WHEN COUNT(t.PersID) > 0 THEN ROUND(a.Kosten / COUNT(t.PersID), 2) ELSE NULL END AS Kosten_pro_Teilnehmer
FROM 
    Anlass a
LEFT JOIN 
    Teilnehmer t ON a.AnlaID = t.AnlaID
GROUP BY 
    a.AnlaID, a.Bezeichner, a.Datum, a.Kosten
ORDER BY 
    a.Datum DESC;

-- Teilnahmequote nach Mitgliederstatus
SELECT 
    a.Bezeichner AS Anlass,
    s.Bezeichner AS Status,
    COUNT(t.PersID) AS Teilnehmer,
    (SELECT COUNT(*) FROM Person WHERE StatID = s.StatID AND (Austritt IS NULL OR Austritt > a.Datum) AND (Eintritt <= a.Datum)) AS Gesamtanzahl,
    ROUND(COUNT(t.PersID) * 100.0 / 
        NULLIF((SELECT COUNT(*) FROM Person WHERE StatID = s.StatID AND (Austritt IS NULL OR Austritt > a.Datum) AND (Eintritt <= a.Datum)), 0), 1) AS Teilnahmequote
FROM 
    Anlass a
CROSS JOIN 
    Status s
LEFT JOIN 
    Person p ON s.StatID = p.StatID AND (p.Austritt IS NULL OR p.Austritt > a.Datum) AND (p.Eintritt <= a.Datum)
LEFT JOIN 
    Teilnehmer t ON p.PersID = t.PersID AND a.AnlaID = t.AnlaID
WHERE 
    a.Datum < CURRENT_DATE  -- Nur vergangene Anlässe
GROUP BY 
    a.AnlaID, a.Bezeichner, s.StatID, s.Bezeichner
ORDER BY 
    a.Datum DESC, Teilnahmequote DESC;
```

**Übungsaufgabe**: Erstelle eine Trendanalyse, die zeigt, wie sich die Teilnehmerzahlen bei wiederkehrenden Veranstaltungen (z.B. jährliche Feste) über die Jahre entwickelt haben.

### Aufgabe 4: Kombinierte Auswertung für Vorstandsberichte

Erstelle einen umfassenden Bericht, der die wichtigsten Kennzahlen für den Vorstand zusammenfasst.

```sql
-- Vereinfachte Version ohne komplexe CTEs
-- Aktuelle Mitgliederzahlen
SELECT 
    COUNT(*) AS Aktuelle_Mitglieder,
    COUNT(*) FILTER (WHERE Eintritt >= DATE_TRUNC('year', CURRENT_DATE)) AS Neue_Mitglieder_Jahr,
    COUNT(*) FILTER (WHERE Austritt >= DATE_TRUNC('year', CURRENT_DATE)) AS Austritte_Jahr
FROM 
    Person
WHERE 
    Austritt IS NULL OR Austritt > CURRENT_DATE;

-- Anzahl der Anlässe und Gesamtkosten im laufenden Jahr
SELECT 
    COUNT(*) AS Anlässe_Jahr,
    SUM(Kosten) AS Anlasskosten_Jahr
FROM 
    Anlass
WHERE 
    Datum >= DATE_TRUNC('year', CURRENT_DATE);

-- Durchschnittliche Teilnehmerzahl pro Anlass
SELECT 
    ROUND(AVG(anzahl), 1) AS Durchschnitt_Teilnehmer
FROM (
    SELECT 
        a.AnlaID, 
        COUNT(t.PersID) AS anzahl
    FROM 
        Anlass a
    LEFT JOIN 
        Teilnehmer t ON a.AnlaID = t.AnlaID
    WHERE 
        a.Datum >= DATE_TRUNC('year', CURRENT_DATE)
    GROUP BY 
        a.AnlaID
) AS teilnehmer_pro_anlass;
```

**Übungsaufgabe**: Erweitere den Bericht um eine Auswertung der aktivsten Mitglieder (gemessen an der Teilnahme an Anlässen) und füge eine Prognose der Mitgliederentwicklung für das nächste Jahr hinzu, basierend auf den Trends der letzten Jahre.

## Herausforderungen und Erweiterungen

### Herausforderung 1: Dynamische Dashboard-Abfragen
Entwickle ein Konzept für ein SQL-basiertes Dashboard, das die wichtigsten Kennzahlen für den Vereinsvorstand visualisiert. Überlege:
1. Welche Kennzahlen (KPIs) sind für die Vereinsleitung am relevantesten?
2. Wie könnten Ampelsysteme implementiert werden, die kritische Entwicklungen sofort sichtbar machen?
3. Wie lassen sich Prognosen für zukünftige Entwicklungen aus historischen Daten ableiten?

### Herausforderung 2: Saisonale Muster und Korrelationen
Untersuche, ob es Zusammenhänge zwischen verschiedenen Faktoren gibt:
1. Gibt es saisonale Muster bei Ein- und Austritten?
2. Korrelieren bestimmte Veranstaltungstypen mit höheren Neueintrittszahlen?
3. Besteht ein Zusammenhang zwischen der Aktivität eines Mitglieds (Teilnahme an Anlässen) und der Wahrscheinlichkeit eines Austritts?

### Herausforderung 3: Mehrjahresvergleiche mit OLAP-Techniken
Entwirf eine Datenwürfel-Struktur (OLAP Cube) für die multidimensionale Analyse der Vereinsdaten. Überlege:
1. Welche Dimensionen sind sinnvoll (Zeit, Ort, Mitgliederstatus, Altersgruppe, etc.)?
2. Welche Kennzahlen (Measures) sollten analysiert werden können?
3. Wie können Drill-Down und Roll-Up Operationen mit SQL umgesetzt werden?

### Erweiterung: Predictive Analytics
Entwickle ein Konzept, wie einfache prädiktive Modelle mit SQL umgesetzt werden könnten, um:
1. Die Wahrscheinlichkeit von Mitgliederaustritten vorherzusagen (Churn Prediction)
2. Den potentiellen Erfolg geplanter Veranstaltungen zu prognostizieren
3. Zu optimalen Zeitpunkten für Mitgliederwerbeaktionen zu gelangen

Welche zusätzlichen Daten wären dafür erforderlich, und wie müsste die Datenbankstruktur erweitert werden?

## Reflexion

- Wie können datenbasierte Erkenntnisse die strategische Ausrichtung eines Vereins beeinflussen?
- Welche ethischen Überlegungen sind bei der Analyse von Mitgliederdaten relevant?
- Inwiefern unterscheiden sich Ad-hoc-Analysen von regelmässigen Standard-Reports, und wann ist welcher Ansatz sinnvoller?
- Wie kann die richtige Balance zwischen Detailtiefe und Übersichtlichkeit bei Reports für die Vereinsleitung gefunden werden?
- Welche Grenzen hat die reine SQL-basierte Analyse, und wann sollten spezialisierte BI-Tools oder Statistik-Software eingesetzt werden?
