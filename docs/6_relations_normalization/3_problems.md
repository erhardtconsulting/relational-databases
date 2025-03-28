# Probleme bei schlecht strukturierten Datenbanken

## Warum eine gute Strukturierung wichtig ist

Nachdem wir die Grundlagen des relationalen Modells und die verschiedenen Beziehungstypen kennengelernt haben, stellt sich die Frage: Was passiert eigentlich, wenn wir unsere Datenbank nicht sorgfältig strukturieren? Warum sollten wir uns die Mühe machen, komplexe Beziehungen zu definieren, statt einfach alle Daten in einer grossen Tabelle zu speichern?

Die Antwort liegt in den zahlreichen Problemen, die bei schlecht strukturierten Datenbanken auftreten können. Diese Probleme beeinträchtigen nicht nur die Effizienz und Performance, sondern können auch die Datenintegrität gefährden und die Wartbarkeit erheblich erschweren.

In diesem Abschnitt betrachten wir die häufigsten Probleme, die in denormalisierten (nicht optimal strukturierten) Datenbanken auftreten. Diese Probleme bieten die Motivation für den Normalisierungsprozess, den wir im nächsten Abschnitt detailliert untersuchen werden.

## Redundanz und ihre Folgen

**Redundanz** bezeichnet die mehrfache Speicherung derselben Information an verschiedenen Stellen in einer Datenbank. Dies ist eines der Hauptprobleme bei schlecht strukturierten Datenbanken.

### Beispiel einer denormalisierten Tabelle

Betrachten wir folgende denormalisierte Tabelle, die versucht, alle Informationen über Vereinsmitglieder und ihre Aktivitäten in einer einzigen Struktur zu speichern:

| MitID| Name    | Adresse     | StatusBez| StatusBeitrag| FunktionBez| Funktion_Seit| AnlassBez  | Anlass_Datum|
|------|---------|-------------|----------|-------------|------------|-------------|------------|-------------|
| 1    | Müller  | Hauptstr. 1 | Aktiv    | 100         | Präsident  | 2020-01-01  | Sommerfest | 2024-07-15  |
| 1    | Müller  | Hauptstr. 1 | Aktiv    | 100         | Präsident  | 2020-01-01  | Jahresfeier| 2024-12-10  |
| 1    | Müller  | Hauptstr. 1 | Aktiv    | 100         | Trainer    | 2018-06-15  | Sommerfest | 2024-07-15  |
| 2    | Weber   | Seeweg 5    | Aktiv    | 100         | Kassier    | 2019-03-10  | Sommerfest | 2024-07-15  |
| 3    | Schmidt | Bergstr. 12 | Passiv   | 50          | NULL       | NULL        | NULL       | NULL        |

In dieser Tabelle können wir mehrere Redundanzen identifizieren:

1. **Persönliche Daten**: Die Informationen zu "Müller, Hans" (ID, Name, Vorname, Adresse) sind in drei Zeilen dupliziert.
2. **Statusdaten**: Die Informationen "Aktiv, 100" sind mehrfach gespeichert.
3. **Anlass-Informationen**: Die Informationen zum "Sommerfest" am 24.07.2024 erscheinen dreimal.

### Probleme durch Redundanz

Redundanz führt zu mehreren schwerwiegenden Problemen:

1. **Verschwendung von Speicherplatz**: Daten werden unnötigerweise mehrfach gespeichert.
2. **Konsistenzprobleme**: Wenn sich Daten ändern (z.B. die Adresse von Müller), müssen alle Vorkommen dieser Information aktualisiert werden.
3. **Erhöhter Wartungsaufwand**: Updates werden komplexer und fehleranfälliger.
4. **Schlechtere Performance**: Mehr Daten bedeuten langsamere Abfragen und mehr I/O-Operationen.

Ein einfaches Beispiel: Wenn sich der Mitgliedsbeitrag für Aktiv-Mitglieder von 100 auf 120 ändert, müssen wir in der obigen Tabelle mehrere Zeilen aktualisieren. Vergessen wir eine, haben wir inkonsistente Daten.

## Anomalien

Neben der allgemeinen Redundanz können in schlecht strukturierten Datenbanken spezifische Probleme auftreten, die als **Anomalien** bezeichnet werden. Diese Anomalien machen es schwierig, die Datenbank korrekt zu verwalten und zu nutzen.

### Einfügeanomalie

Eine **Einfügeanomalie** tritt auf, wenn wir bestimmte Informationen nicht speichern können, ohne gleichzeitig andere, möglicherweise noch nicht verfügbare Informationen zu speichern.

**Beispiel**: 
In unserer denormalisierten Tabelle können wir einen neuen Anlass nicht einfügen, ohne ihn sofort einem Mitglied zuzuordnen. Wenn wir beispielsweise einen Wandertag planen, aber noch keine Teilnehmer haben, können wir diesen Anlass nicht in der Tabelle speichern.

```sql
-- Versuch, einen neuen Anlass ohne Teilnehmer einzufügen - nicht möglich in dieser Struktur
INSERT INTO DenormalisierteTabelle (AnlassBez, Anlass_Datum) 
VALUES ('Wandertag', '2024-08-20');  -- Funktioniert nicht, da MitID, Name, etc. benötigt werden
```

### Änderungsanomalie

Eine **Änderungsanomalie** tritt auf, wenn eine Änderung an einem Datensatz mehrere Updates an verschiedenen Stellen erfordert.

**Beispiel**:
Wenn sich die Adresse von "Müller, Hans" ändert, müssen wir alle Zeilen aktualisieren, in denen seine Informationen vorkommen:

```sql
-- Müssen alle Zeilen für Müller aktualisieren
UPDATE DenormalisierteTabelle 
SET Adresse = 'Neue Strasse 10' 
WHERE MitID = 1;  -- Aktualisiert mehrere Zeilen
```

Falls wir versehentlich nur einige Zeilen aktualisieren, haben wir inkonsistente Daten in unserer Datenbank.

### Löschanomalie

Eine **Löschanomalie** tritt auf, wenn das Löschen bestimmter Informationen unbeabsichtigt zum Verlust anderer, wichtiger Daten führt.

**Beispiel**:
Wenn wir alle Teilnehmer eines Anlasses löschen, verlieren wir auch die Informationen über den Anlass selbst:

```sql
-- Löschen aller Einträge für den Anlass "Jahresfeier"
DELETE FROM DenormalisierteTabelle 
WHERE AnlassBez = 'Jahresfeier';  -- Löscht den einzigen Eintrag für diesen Anlass
```

Nach dieser Operation haben wir keine Information mehr darüber, dass es eine Jahresfeier am 10.12.2024 geben soll.

## Probleme mit NULL-Werten

Ein weiteres Problem in schlecht strukturierten Datenbanken ist der übermässige Einsatz von **NULL-Werten**. In unserem Beispiel sehen wir, dass für "Schmidt, Peter" mehrere Felder NULL sind, da er keine Funktion hat und an keinem Anlass teilnimmt.

NULL-Werte können zu verschiedenen Problemen führen:

1. **Speicherplatzvergeudung**: Leere Felder belegen dennoch Speicherplatz
2. **Komplexere Abfragen**: Abfragen mit NULL-Werten erfordern spezielle Behandlung
3. **Mehrdeutige Bedeutung**: NULL kann verschiedene Bedeutungen haben (nicht anwendbar, unbekannt, noch nicht festgelegt)

## Ineffiziente Abfragen

Schlecht strukturierte Datenbanken führen oft zu ineffizienten Abfragen. Betrachten wir einige Beispiele:

1. **Einfache Zusammenfassungen werden komplex**:
   Wenn wir die Anzahl der Anlässe pro Jahr zählen wollen, müssen wir Duplikate berücksichtigen:

   ```sql
   SELECT EXTRACT(YEAR FROM Anlass_Datum) AS Jahr, 
          COUNT(DISTINCT AnlassBez) AS AnzahlAnlässe
   FROM DenormalisierteTabelle
   GROUP BY EXTRACT(YEAR FROM Anlass_Datum);
   ```

2. **Filterung erfordert komplexe Bedingungen**:
   Um alle Mitglieder zu finden, die an mehr als einem Anlass teilnehmen:

   ```sql
   SELECT MitID, Name, Vorname
   FROM DenormalisierteTabelle
   GROUP BY MitID, Name, Vorname
   HAVING COUNT(DISTINCT AnlassBez) > 1;
   ```

Diese Abfragen sind nicht nur komplex, sondern auch ineffizient in Bezug auf Performance und Ressourcennutzung.

## Auswirkungen auf Geschäftslogik und Anwendungsentwicklung

Die Probleme schlecht strukturierter Datenbanken wirken sich auch auf die höheren Ebenen der Anwendungsentwicklung aus:

1. **Erhöhte Komplexität im Anwendungscode**: Die Anwendung muss zusätzliche Logik implementieren, um Redundanzen und Anomalien zu behandeln.
2. **Höheres Risiko für Fehler**: Je komplexer die Anwendungslogik, desto wahrscheinlicher sind Fehler.
3. **Schwierigere Wartbarkeit**: Änderungen am Datenbankschema können weitreichende Auswirkungen auf den Anwendungscode haben.
4. **Eingeschränkte Skalierbarkeit**: Mit wachsenden Datenmengen verstärken sich die Probleme.

## Vergleich: Denormalisiert vs. Normalisiert

Um die Vorteile einer gut strukturierten Datenbank zu verdeutlichen, vergleichen wir unsere denormalisierte Tabelle mit einer normalisierten Struktur:

### Denormalisierte Struktur (eine Tabelle)

| MitID| Name    | Vorname| Adresse     | StatusBez| StatusBeitrag| FunktionBez| Funktion_Seit| AnlassBez  | Anlass_Datum|
|------|---------|--------|-------------|----------|-------------|------------|-------------|------------|-------------|
| ...  | ...     | ...    | ...         | ...      | ...         | ...        | ...         | ...        | ...         |

### Normalisierte Struktur (mehrere verknüpfte Tabellen)

**Tabelle: Mitglied**

| MitID| Name    | Vorname| Adresse     | StatusID |
|------|---------|--------|-------------|----------|
| 1    | Müller  | Hans   | Hauptstr. 1 | 1        |
| 2    | Weber   | Anna   | Seeweg 5    | 1        |
| 3    | Schmidt | Peter  | Bergstr. 12 | 2        |

**Tabelle: Status**

| StatusID | Bezeichner| Beitrag     |
|----------|-----------|-------------|
| 1        | Aktiv     | 100         |
| 2        | Passiv    | 50          |

**Tabelle: Funktion**

| FunktionID | Bezeichner|
|------------|-----------|
| 1          | Präsident |
| 2          | Kassier   |
| 3          | Trainer   |

**Tabelle: Mitglied_Funktion**

| MitID| FunktionID | Seit        |
|------|------------|-------------|
| 1    | 1          | 2020-01-01  |
| 1    | 3          | 2018-06-15  |
| 2    | 2          | 2019-03-10  |

**Tabelle: Anlass**

| AnlassID | Bezeichnung| Datum       |
|----------|------------|-------------|
| 1        | Sommerfest | 2024-07-15  |
| 2        | Jahresfeier| 2024-12-10  |

**Tabelle: Mitglied_Anlass**

| MitID| AnlassID |
|------|----------|
| 1    | 1        |
| 1    | 2        |
| 2    | 1        |

Die normalisierte Struktur bietet mehrere Vorteile:

1. **Keine Redundanz**: Jede Information wird nur einmal gespeichert
2. **Weniger Anomalien**: Einfügen, Ändern und Löschen sind sicherer und einfacher
3. **Bessere Datenintegrität**: Beziehungen zwischen Entitäten werden klar definiert
4. **Flexiblere Abfragen**: Komplexe Fragen können effizienter beantwortet werden
5. **Bessere Skalierbarkeit**: Die Struktur kann leicht erweitert werden

## Fazit

Wir haben gesehen, dass schlecht strukturierte Datenbanken zu erheblichen Problemen führen können:

- Redundanz führt zu Speicherverschwendung und Konsistenzproblemen
- Anomalien erschweren das Einfügen, Ändern und Löschen von Daten
- Übermässige NULL-Werte verkomplizieren Abfragen und verschwenden Ressourcen
- Ineffiziente Abfragen beeinträchtigen die Performance
- Komplexe Anwendungslogik erhöht das Fehlerrisiko

Um diese Probleme zu vermeiden, benötigen wir einen systematischen Ansatz zur Strukturierung unserer Datenbanken. Diesen bietet der **Normalisierungsprozess**, den wir im nächsten Abschnitt genauer untersuchen werden.

Der Normalisierungsprozess bietet uns einen Fahrplan, wie wir eine schlecht strukturierte Datenbank schrittweise in eine gut strukturierte überführen können, indem wir Redundanzen eliminieren und die Daten auf logische Weise in zusammenhängende Tabellen aufteilen.
