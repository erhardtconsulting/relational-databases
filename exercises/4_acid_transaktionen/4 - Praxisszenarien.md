---
title: "ACID und Transaktionen / Übung 4: Praxisnahe Szenarien"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - ACID
    - Transaktion
---
# Übung 4: Praxisnahe Szenarien

## Warum sind praxisnahe Szenarien wichtig?

In realen Anwendungen müssen oft komplexe Geschäftsprozesse als Transaktionen abgebildet werden. Die folgenden Szenarien simulieren typische Anwendungsfälle und zeigen, wie Transaktionen in der Praxis eingesetzt werden können.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen
3. Grundkenntnisse in PL/pgSQL für komplexere Beispiele

Diese Übung nutzt die Tabellen der "Verein"-Datenbank.

```sql
-- Erstelle den Anlass Sommerfest in der Zukunft, damit du später die Person anmelden kannst
INSERT INTO Anlass (AnlaId, Bezeichner, Ort, Datum, OrgId)
    VALUES (gen_random_uuid(), 'Sommerfest', 'Solothurn', '2030-01-01', '872fde0a-1934-4451-8a46-91176241337f');
```

## Praktische Übung zu praxisnahen Szenarien

### a) Vereinsmitgliedschaft und Veranstaltungsteilnahme

Dieses Szenario verwendet die "Verein"-Datenbank aus der Lernumgebung:

```sql
-- Neue Person anlegen und gleichzeitig als Mitglied aufnehmen
BEGIN;

-- Prüfe zuerst, ob die Person bereits existiert
SELECT COUNT(*) 
    FROM Person 
    WHERE Name = 'Mustermann' 
        AND Vorname = 'Max';

-- Wenn die Person nicht existiert, lege sie an
INSERT INTO Person (PersId, Name, Vorname, Strasse_Nr, PLZ, Ort, Bezahlt, Eintritt, StatId) 
	VALUES (gen_random_uuid(), 'Mustermann', 'Max', 'Blumenstrasse 4', '4500', 'Solothurn', 'N', CURRENT_DATE, 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0');

-- Hole die ID der neu angelegten Person
SELECT PersId, Strasse_Nr, PLZ, Ort, Eintritt 
    FROM Person 
    WHERE Name = 'Mustermann' 
        AND Vorname = 'Max';

-- Melde die Person zu einer Veranstaltung an
INSERT INTO Teilnehmer (PersId, AnlaId) 
    VALUES ('d420cf1e-a831-4c96-8cd1-f4eacb2153b6', (
        SELECT AnlaID 
            FROM Anlass 
            WHERE Bezeichner = 'Sommerfest' 
                AND Datum > CURRENT_DATE 
            LIMIT 1
    )
);

COMMIT;
```

### b) Komplexe Transaktion mit Fehlerbehandlung in PL/pgSQL

```sql
DO $$
DECLARE
    v_person_id UUID;
    v_anlass_id UUID;
    v_status_ok BOOLEAN := FALSE;
    v_max_attempts INTEGER := 3;
    v_current_attempt INTEGER := 0;
BEGIN
    -- Prüfe, ob ein passendes Event existiert
    SELECT AnlaId 
        INTO v_anlass_id 
        FROM Anlass 
        WHERE Bezeichner = 'Sommerfest' 
            AND Datum > CURRENT_DATE 
        LIMIT 1;
    
    IF v_anlass_id IS NULL THEN
        RAISE EXCEPTION 'Kein passendes Event gefunden';
    END IF;
    
    -- Person anlegen mit Retry-Logik für optimistische Sperrung
    WHILE v_current_attempt < v_max_attempts AND NOT v_status_ok LOOP
        v_current_attempt := v_current_attempt + 1;
        
        BEGIN -- Transaktion für jeden Versuch starten
            -- Person anlegen
            INSERT INTO Person (PersId, Name, Vorname, Strasse_Nr, PLZ, Ort, Bezahlt, Eintritt, StatId) 
                VALUES (gen_random_uuid(), 'Mustermann', 'Anna', 'Blumenstrasse 4', '4500', 'Solothurn', 'N', CURRENT_DATE, 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0')
            RETURNING PersId INTO v_person_id;
            
            -- Veranstaltungsteilnahme
            INSERT INTO Teilnehmer (PersId, AnlaId) 
            VALUES (v_person_id, v_anlass_id);
            
            v_status_ok := TRUE;
            -- Kein COMMIT hier nötig, DO-Block beendet mit implizitem COMMIT bei Erfolg
        EXCEPTION
            WHEN unique_violation THEN
                ROLLBACK; -- Rollback für diesen Versuch
                RAISE NOTICE 'Concurrent modification detected, retry % of %', 
                    v_current_attempt, v_max_attempts;
            WHEN OTHERS THEN
                ROLLBACK; -- Rollback bei anderen Fehlern
                RAISE;
        END;
    END LOOP;
    
    IF NOT v_status_ok THEN
        RAISE EXCEPTION 'Failed after % attempts', v_max_attempts;
    END IF;
END $$;
```

## Aufgaben

1. Erweitere das PL/pgSQL-Beispiel um zusätzliche Geschäftslogik (z.B. Prüfen der Teilnehmerzahl für eine Veranstaltung).
2. Identifiziere Deadlock-Risiken im "Verein"-Datenbankschema und schlage Lösungen vor.
3. Implementiere eine Transaktion, die mehrere zusammenhängende Operationen auf der "Verein"-Datenbank ausführt und sichere Fehlerbehandlung enthält.
