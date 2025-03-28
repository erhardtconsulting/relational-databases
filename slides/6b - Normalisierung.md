---
theme: hftm
footer: 'Normalisierung'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>Normalisierung</h1>
  <p class="date-author">März 2025 | Autor: Simon Erhardt</p>
</div>

---
# Inhaltsverzeichnis
<!--
- Übersicht zum Ablauf der Vorlesung
- Diese Folien dienen als Einstieg für die praktischen Übungen
-->
1. Probleme bei schlecht strukturierten Datenbanken
2. Normalisierung: Warum und wozu?
3. Erste Normalform (1NF)
4. Zweite Normalform (2NF)
5. Dritte Normalform (3NF)
6. Weiterführende Normalformen
7. Wann ist De-Normalisierung sinnvoll?
8. Zusammenfassung

---
# Probleme bei schlecht strukturierten Datenbanken
<!--
- Praktische Probleme durch schlechtes Datenbankdesign
- Motivation für Normalisierung
-->

## Beispiel: Denormalisierte Vereinstabelle

| MitgliedNr | Name      | Vorname | Adresse              | Funktion1  | Funktion2  | Anlass1       | Anlass2       |
|------------|-----------|---------|----------------------|------------|------------|---------------|---------------|
| 1          | Müller    | Hans    | Hauptstrasse 1, Bern | Präsident  | Trainer    | Sommerfest    | Vereinsreise  |
| 2          | Schmidt   | Anna    | Bahnhofplatz 5, Bern | Kassierer  | -          | Sommerfest    | -             |
| 3          | Meier     | Thomas  | Seeweg 12, Zürich    | -          | -          | Vereinsreise  | Weihnachtsfeier|

---
# Probleme bei dieser Struktur
<!--
- Praxisrelevante Probleme
- Brücke zur Notwendigkeit der Normalisierung
-->

1. **Redundanz**: Mehrfache Speicherung derselben Informationen
   - Adressänderung muss an mehreren Stellen gepflegt werden

2. **Einfügeanomalien**: Schwierigkeiten beim Hinzufügen neuer Daten
   - Neuen Anlass hinzufügen ohne Teilnehmer?
   - Neue Funktion ohne Zuordnung zu einer Person?

3. **Änderungsanomalien**: Inkonsistenzen bei Datenänderungen
   - Umbenennung eines Anlasses erfordert Änderungen in mehreren Zeilen

4. **Löschanomalien**: Unbeabsichtigter Datenverlust
   - Löschen des letzten Teilnehmers eines Anlasses löscht auch den Anlass

---
# Normalisierung: Warum und wozu?
<!--
- Definition und Zweck der Normalisierung
- Vorteile eines normalisierten Datenbankdesigns
-->

- **Normalisierung** = schrittweiser Prozess zur Optimierung von Datenbankstrukturen
- Ziel: Beseitigung von Redundanzen und Anomalien durch logische Strukturierung
- Entwickelt von Edgar F. Codd als Teil der relationalen Theorie

## Vorteile normalisierter Datenbanken
- Datenintegrität und Konsistenz
- Reduzierte Redundanz und Speicherbedarf
- Einfachere Wartung und Erweiterbarkeit
- Klarere Abbildung der realen Welt
- Bessere Abfrageperformance für komplexe Abfragen
- Schutz vor logischen Fehlern

---
# Erste Normalform (1NF)
<!--
- Definition und Regeln der 1NF
- Beispiel für die Überführung in 1NF
-->

## Definition
Eine Tabelle ist in 1NF, wenn:
- Jede Spalte atomar (nicht weiter zerlegbar) ist
- Keine Wiederholungsgruppen oder Arrays existieren
- Jede Zeile einen eindeutigen Schlüssel hat

## Beispiel: Nicht in 1NF
| KursID | KursName   | Teilnehmer                       |
|--------|------------|----------------------------------|
| K1     | Datenbanken| Hans Müller, Anna Schmidt        |
| K2     | Webdesign  | Peter Meier, Lisa Weber, Max Kim |

---
# Erste Normalform (1NF) - Umsetzung
<!--
- Praktische Umwandlung von Tabellen in 1NF
-->

## Überführung in 1NF
1. Spalte "Teilnehmer" auflösen in einzelne Zeilen:

| KursID | KursName   | Teilnehmer  |
|--------|------------|-------------|
| K1     | Datenbanken| Hans Müller |
| K1     | Datenbanken| Anna Schmidt|
| K2     | Webdesign  | Peter Meier |
| K2     | Webdesign  | Lisa Weber  |
| K2     | Webdesign  | Max Kim     |

2. Primärschlüssel festlegen:
   - Kombination aus KursID und Teilnehmer oder
   - Neuer künstlicher Primärschlüssel

---
# Zweite Normalform (2NF)
<!--
- Definition und Regeln der 2NF
- Voraussetzungen und Beispiele
-->

## Definition
Eine Tabelle ist in 2NF, wenn sie:
- In 1NF ist
- Alle Nicht-Schlüssel-Attribute voll funktional abhängig vom gesamten Primärschlüssel sind

## Einfache Erklärung
- Betrifft nur Tabellen mit zusammengesetztem Primärschlüssel
- Keine Attribute dürfen nur von einem Teil des Schlüssels abhängen
- "Alles oder nichts" Prinzip für Abhängigkeiten

---
# Zweite Normalform (2NF) - Beispiel
<!--
- Detailliertes Beispiel für 2NF
-->

## Beispiel: Nicht in 2NF
| KursID | Teilnehmer  | KursName   | TeilnehmerEmail    |
|--------|-------------|------------|-------------------|
| K1     | Hans Müller | Datenbanken| hans@example.com  |
| K1     | Anna Schmidt| Datenbanken| anna@example.com  |
| K2     | Peter Meier | Webdesign  | peter@example.com |

Primärschlüssel: (KursID, Teilnehmer)

**Problem**: 
- KursName hängt nur von KursID ab
- TeilnehmerEmail hängt nur von Teilnehmer ab

---
# Zweite Normalform (2NF) - Umsetzung
<!--
- Umsetzungsschritte für die 2NF
-->

## Überführung in 2NF
1. Aufteilung in mehrere Tabellen:

<div class="container">
<div class="col">

**Kurs-Tabelle**:
| KursID | KursName   |
|--------|------------|
| K1     | Datenbanken|
| K2     | Webdesign  |

**Teilnehmer-Tabelle**:
| Teilnehmer  | TeilnehmerEmail   |
|-------------|-------------------|
| Hans Müller | hans@example.com  |
| Anna Schmidt| anna@example.com  |
| Peter Meier | peter@example.com |

</div>
<div class="col">

**Kurs-Teilnehmer-Tabelle**:
| KursID | Teilnehmer  |
|--------|-------------|
| K1     | Hans Müller |
| K1     | Anna Schmidt|
| K2     | Peter Meier |

</div>
</div>

---
# Dritte Normalform (3NF)
<!--
- Definition und Regeln der 3NF
- Abgrenzung zur 2NF
-->

## Definition
Eine Tabelle ist in 3NF, wenn sie:
- In 2NF ist
- Keine transitiven Abhängigkeiten enthält

## Einfache Erklärung
- Nicht-Schlüssel-Attribute dürfen nicht von anderen Nicht-Schlüssel-Attributen abhängen
- Jedes Attribut muss direkt vom Primärschlüssel abhängen
- "Direkte Abhängigkeit" Prinzip

---
# Dritte Normalform (3NF) - Beispiel
<!--
- Detailliertes Beispiel für 3NF
-->

## Beispiel: Nicht in 3NF
| PersonID | Name      | PLZ   | Ort     |
|----------|-----------|-------|---------|
| 1        | Müller    | 3000  | Bern    |
| 2        | Schmidt   | 3000  | Bern    |
| 3        | Meier     | 8000  | Zürich  |

Primärschlüssel: PersonID

**Problem**: 
- Ort hängt transitiv über PLZ von PersonID ab
- PLZ → Ort (Eine PLZ bestimmt eindeutig den Ort)

---
# Dritte Normalform (3NF) - Umsetzung
<!--
- Umsetzungsschritte für die 3NF
-->

## Überführung in 3NF
1. Aufteilung in mehrere Tabellen:

**Person-Tabelle**:
| PersonID | Name      | PLZ   |
|----------|-----------|-------|
| 1        | Müller    | 3000  |
| 2        | Schmidt   | 3000  |
| 3        | Meier     | 8000  |

**PLZ-Tabelle**:
| PLZ   | Ort     |
|-------|---------|
| 3000  | Bern    |
| 8000  | Zürich  |

---
# Weiterführende Normalformen
<!--
- Kurzer Überblick über weitere Normalformen
- Wann sind diese relevant?
-->

## Boyce-Codd Normalform (BCNF)
- Verschärfung der 3NF
- Alle Determinanten sind Kandidatenschlüssel

## Vierte Normalform (4NF)
- Behandelt Mehrwertige Abhängigkeiten
- Selten in der Praxis angewendet

## Fünfte Normalform (5NF)
- Behandelt Join-Abhängigkeiten
- Sehr spezialisiert, selten relevant

> Für die meisten praktischen Anwendungen ist die 3NF ausreichend!

---
# Wann ist De-Normalisierung sinnvoll?
<!--
- WAS WENN-Ebene: Wann weicht man von der Regel ab?
- Praxisorientierte Szenarien
-->

## Gründe für De-Normalisierung
- Stark lesezentrierte Anwendungen
- Reporting- und Analyse-Datenbanken
- Extreme Performance-Anforderungen

## Techniken zur De-Normalisierung
- Berechnete Spalten (z.B. Gesamtpreis in Bestelltabelle)
- Materialisierte Aggregationen (z.B. Anzahl Bestellungen pro Kunde)
- Wiederholungsgruppen für Performance-kritische Daten

**Wichtig**: De-Normalisierung immer dokumentieren und Risiken abwägen!

---
# Zusammenfassung
<!--
- Hauptpunkte zusammenfassen
- Hinweis auf nächste Schritte und Übungen
-->

- **Normalisierung** beseitigt Redundanzen und Anomalien
  - 1NF: Atomare Werte, keine Wiederholungsgruppen
  - 2NF: Volle funktionale Abhängigkeit vom Primärschlüssel
  - 3NF: Keine transitiven Abhängigkeiten

- **Vorteile** der Normalisierung:
  - Verbesserte Datenintegrität
  - Reduzierte Redundanz
  - Einfachere Wartung und Erweiterung
  
- **Balance** zwischen Normalisierung und Performance-Anforderungen
  - De-Normalisierung nur für spezifische Anwendungsfälle
  - 3NF als Standard-Ziel für die meisten Datenbanken
