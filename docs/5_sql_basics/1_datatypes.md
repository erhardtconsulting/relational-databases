# SQL-Datentypen

## Warum sind Datentypen wichtig?

Bevor wir in die Welt der SQL-Befehle eintauchen, müssen wir verstehen, wie Daten in einer relationalen Datenbank strukturiert und gespeichert werden. Datentypen sind hierbei von zentraler Bedeutung, denn sie:

- **Definieren die Art der Daten**, die in einer Spalte gespeichert werden können
- **Stellen die Datenintegrität sicher**, indem sie unzulässige Werte abweisen
- **Optimieren den Speicherplatz**, da unterschiedliche Datentypen unterschiedliche Mengen an Speicherplatz benötigen
- **Verbessern die Abfragegeschwindigkeit**, da der Datenbankserver die optimale Zugriffsmethode für jeden Datentyp kennt
- **Ermöglichen typenspezifische Operationen**, wie arithmetische Operationen bei Zahlen oder Textmanipulationen bei Zeichenketten

Die sorgfältige Auswahl der richtigen Datentypen ist eine der wichtigsten Aufgaben beim Datenbankdesign und hat langfristige Auswirkungen auf die Performance und Funktionalität deiner Anwendung.

## Übersicht der wichtigsten Datentypen

SQL-Datentypen lassen sich in verschiedene Kategorien einteilen:

1. **Texte und Zeichenketten**
   - CHAR, VARCHAR, TEXT

2. **Numerische Werte**
   - INTEGER, SMALLINT, BIGINT, NUMERIC/DECIMAL, REAL, DOUBLE PRECISION

3. **Datum und Zeit**
   - DATE, TIME, TIMESTAMP (mit oder ohne Zeitzone)

4. **Boolesche Werte**
   - BOOLEAN (TRUE/FALSE)

5. **Identifikatoren und Autoinkremente**
   - UUID, SERIAL/IDENTITY

In diesem Abschnitt konzentrieren wir uns auf die gebräuchlichsten Datentypen, die in fast allen relationalen Datenbanksystemen verfügbar sind, mit besonderem Fokus auf PostgreSQL.

## Zeichenketten-Datentypen

### CHAR(n)

Der `CHAR`-Datentyp speichert Zeichenketten fester Länge mit genau `n` Zeichen. Wenn ein kürzerer Wert gespeichert wird, wird er mit Leerzeichen aufgefüllt.

```sql
-- Spalte für feste Codes wie Postleitzahlen
PLZ CHAR(4) NOT NULL
```

**Anwendung**: Ideal für Daten, die immer die gleiche Länge haben, wie Ländercodes oder Postleitzahlen.

**Zu beachten**: Bei einem `CHAR(10)` werden immer 10 Zeichen gespeichert, auch wenn du nur 3 Zeichen eingibst. Die 7 verbleibenden Positionen werden mit Leerzeichen aufgefüllt.

### VARCHAR(n)

Der `VARCHAR`-Datentyp speichert Zeichenketten variabler Länge mit einer maximalen Länge von `n` Zeichen. Im Gegensatz zu `CHAR` wird kein zusätzlicher Speicherplatz für nicht verwendete Zeichen benötigt.

```sql
-- Spalte für Namen variabler Länge
Name VARCHAR(20) NOT NULL
```

**Anwendung**: Gut geeignet für die meisten Texte, bei denen die maximale Länge bekannt ist, aber variieren kann (Namen, Adressen, kurze Beschreibungen).

**Zu beachten**: In PostgreSQL kann `VARCHAR` ohne Längenbegrenzung definiert werden (`VARCHAR` ohne Zahl in Klammern), was faktisch dem `TEXT`-Typ entspricht.

### TEXT

Der `TEXT`-Datentyp speichert Zeichenketten beliebiger Länge ohne definierte Obergrenze (ausser der allgemeinen Systemlimits).

```sql
-- Spalte für Beschreibungen unbestimmter Länge
Beschreibung TEXT
```

**Anwendung**: Ideal für lange Textinhalte wie Kommentare, Beschreibungen oder Artikel, deren Länge nicht vorhersehbar ist.

**Zu beachten**: PostgreSQL behandelt `TEXT` und `VARCHAR` ohne Längenbegrenzung nahezu identisch, in anderen Datenbanksystemen kann es jedoch Unterschiede geben.

## Numerische Datentypen

### INTEGER

Ganzzahlen ohne Dezimalstellen.

```sql
-- Spalte für einfache Ganzzahlen
Anzahl INTEGER
```

**Anwendung**: Für einfache Zählungen, Indizes oder ganzzahlige Werte.

### NUMERIC(p, s)

Der `NUMERIC`-Datentyp speichert exakte Dezimalwerte mit `p` Gesamtstellen (Precision) und `s` Nachkommastellen (Scale).

```sql
-- Spalte für Geldbeträge mit 2 Dezimalstellen
Betrag NUMERIC(10, 2)  -- 10 Stellen insgesamt, davon 2 Nachkommastellen
```

**Anwendung**: Ideal für finanzielle Berechnungen, wo die exakte Genauigkeit entscheidend ist.

**Zu beachten**: In PostgreSQL kann `NUMERIC` auch ohne Präzisierung verwendet werden, was eine variable Genauigkeit erlaubt.

## Datum und Zeit

### DATE

Speichert ein Datum (Jahr, Monat, Tag) ohne Zeitkomponente.

```sql
-- Spalte für Ereignisdaten
Eintritt DATE
```

**Anwendung**: Für Geburtstage, Termine oder andere datumsbezogene Informationen.

### TIME

Speichert eine Tageszeit ohne Datumskomponente.

```sql
-- Spalte für Uhrzeiten
Startzeit TIME
```

**Anwendung**: Für Uhrzeiten oder die Dauer von Ereignissen.

### TIMESTAMP

Kombiniert Datum und Uhrzeit.

```sql
-- Spalte für vollständige Zeitstempel
Erstellungszeitpunkt TIMESTAMP
```

**Anwendung**: Für genaue Zeiterfassung, Protokollierung oder wenn sowohl Datum als auch Uhrzeit relevant sind.

**Zu beachten**: PostgreSQL bietet `TIMESTAMP WITH TIME ZONE` (auch `TIMESTAMPTZ` genannt), das die Zeitzone berücksichtigt – wichtig für internationale Anwendungen.

## Boolesche Werte

### BOOLEAN

Speichert einen Wahrheitswert (wahr/falsch).

```sql
-- Spalte für Ja/Nein-Entscheidungen
IstAktiv BOOLEAN
```

**Anwendung**: Für einfache Ja/Nein-Fragen, Flags oder Status-Indikatoren.

**Zu beachten**: In PostgreSQL kann ein `BOOLEAN` die Werte `TRUE`, `FALSE` oder `NULL` (unbekannt) annehmen.

## Identifikatoren

### UUID (Universally Unique Identifier)

Ein 128-Bit-Wert, der eine global eindeutige Kennung darstellt.

```sql
-- Primärschlüssel als UUID
PersID UUID NOT NULL PRIMARY KEY
```

**Anwendung**: Für Primärschlüssel in verteilten Systemen, wo globale Eindeutigkeit ohne zentrale Koordination erforderlich ist.

**Zu beachten**: UUIDs sind sehr gross (16 Bytes) im Vergleich zu anderen Typen und können die Performance beeinflussen.

### SERIAL / IDENTITY

Ein automatisch inkrementierender ganzzahliger Wert.

```sql
-- Automatisch hochzählender Primärschlüssel
ID SERIAL PRIMARY KEY
```

**Anwendung**: Für einfache Primärschlüssel in lokalen Anwendungen, wo automatische Nummerierung ausreicht.

**Zu beachten**: In modernen PostgreSQL-Versionen wird die Verwendung von `GENERATED AS IDENTITY` statt `SERIAL` empfohlen:

```sql
ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
```

## Datentypen in der praktischen Anwendung

Betrachten wir einige Beispiele aus der Verein-Datenbank:

```sql
CREATE TABLE Status (
    StatID     UUID NOT NULL,              -- UUID als Primärschlüssel
    Bezeichner VARCHAR(20) NOT NULL,       -- Text variabler Länge
    Beitrag    NUMERIC,                    -- Geldbetrag mit Dezimalstellen
    CONSTRAINT pk_Status_StatID PRIMARY KEY (StatID)
);

CREATE TABLE Person (
    PersID      UUID NOT NULL,             -- UUID als Primärschlüssel
    Name        VARCHAR(20) NOT NULL,      -- Text variabler Länge
    Vorname     VARCHAR(15) NOT NULL,      -- Text variabler Länge
    Strasse_Nr  VARCHAR(20) NOT NULL,      -- Text variabler Länge
    PLZ         CHAR(4) NOT NULL,          -- Text fester Länge (Schweizer PLZ)
    Ort         VARCHAR(20) NOT NULL,      -- Text variabler Länge
    bezahlt     CHAR(1) NOT NULL,          -- Einzelnes Zeichen (J/N)
    Bemerkungen VARCHAR(25),               -- Optionaler Text
    Eintritt    DATE,                      -- Datum
    Austritt    DATE,                      -- Datum
    StatID      UUID NOT NULL,             -- Fremdschlüssel (UUID)
    MentorID    UUID,                      -- Optionaler Fremdschlüssel
    CONSTRAINT pk_Person_PersID PRIMARY KEY (PersID)
);
```

## Best Practices und Fallstricke

Bei der Auswahl der Datentypen solltest du folgende Punkte beachten:

1. **Wähle den engsten passenden Datentyp**
   - Verwende `VARCHAR(20)` statt `VARCHAR(1000)`, wenn du weisst, dass der Text nie länger als 20 Zeichen sein wird.
   - Verwende `DATE` statt `TIMESTAMP`, wenn du nur das Datum benötigst.

2. **Beachte die Performance-Implikationen**
   - Indizes auf grossen Spalten wie `TEXT` oder `UUID` benötigen mehr Speicherplatz und können langsamer sein.
   - Die Suche in `CHAR`-Feldern kann wegen der Leerzeichen-Auffüllung tückisch sein.

3. **Nutze domänenspezifische Datentypen**
   - PostgreSQL bietet spezielle Typen wie `INET` für IP-Adressen oder `POINT` für geometrische Koordinaten.
   - Diese Typen bieten oft zusätzliche Funktionalität und bessere Performance.

4. **Achte auf Datenbank-Unterschiede**
   - Nicht alle Datentypen sind in allen Datenbanksystemen verfügbar oder verhalten sich gleich.
   - Insbesondere bei PostgreSQL gibt es mehr eingebaute Datentypen als in anderen DBMS.

## Fazit

Die richtige Wahl der Datentypen ist ein entscheidender Schritt beim Datenbankdesign. Sie beeinflusst nicht nur die Datenintegrität, sondern auch die Performance, Speicherplatznutzung und Wartbarkeit deiner Datenbank. Nimm dir Zeit, um die Anforderungen jeder Spalte zu analysieren und den passenden Datentyp zu wählen.
