# Übung 4: Praxisnahe Szenarien

## Warum sind praxisnahe Szenarien wichtig?

In realen Anwendungen müssen oft komplexe Geschäftsprozesse als Transaktionen abgebildet werden. Die folgenden Szenarien simulieren typische Anwendungsfälle und zeigen, wie Transaktionen in der Praxis eingesetzt werden können.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen
3. Grundkenntnisse in PL/pgSQL für komplexere Beispiele

Diese Übung nutzt die Tabellen der "Verein"-Datenbank, aber du kannst auch weiterhin mit der Testtabelle aus den vorherigen Übungen arbeiten:

```sql
-- Falls noch nicht vorhanden:
CREATE TABLE IF NOT EXISTS transaktions_test (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    kontostand DECIMAL(10,2) NOT NULL,
    version INTEGER DEFAULT 1
);
```

## Praktische Übung zu praxisnahen Szenarien

### a) Vereinsmitgliedschaft und Veranstaltungsteilnahme

Dieses Szenario verwendet die "Verein"-Datenbank aus der Lernumgebung:

```sql
-- Neue Person anlegen und gleichzeitig als Mitglied aufnehmen
BEGIN;

-- Prüfe zuerst, ob die Person bereits existiert
SELECT COUNT(*) FROM Person WHERE Name = 'Max Mustermann';

-- Wenn die Person nicht existiert, lege sie an
INSERT INTO Person (Name, Vorname, Geburtsdatum, Geschlecht) 
VALUES ('Mustermann', 'Max', '1990-05-15', 'm');

-- Hole die ID der neu angelegten Person
SELECT currval('person_personid_seq');

-- Füge die Person als Mitglied hinzu (Status 1 = Mitglied)
INSERT INTO Person_Status (PersonID, StatusID, Von) 
VALUES (currval('person_personid_seq'), 1, CURRENT_DATE);

-- Melde die Person zu einer Veranstaltung an
INSERT INTO Teilnehmer (PersonID, AnlassID) 
VALUES (currval('person_personid_seq'), 
        (SELECT AnlassID FROM Anlass WHERE Bezeichnung = 'Sommerfest' AND Datum > CURRENT_DATE LIMIT 1));

COMMIT;
```

### b) Komplexe Transaktion mit Fehlerbehandlung in PL/pgSQL

```sql
DO $$
DECLARE
    v_person_id INTEGER;
    v_anlass_id INTEGER;
    v_status_ok BOOLEAN := FALSE;
    v_max_attempts INTEGER := 3;
    v_current_attempt INTEGER := 0;
BEGIN
    -- Prüfe, ob ein passendes Event existiert
    SELECT AnlassID INTO v_anlass_id 
    FROM Anlass 
    WHERE Bezeichnung = 'Sommerfest' AND Datum > CURRENT_DATE 
    LIMIT 1;
    
    IF v_anlass_id IS NULL THEN
        RAISE EXCEPTION 'Kein passendes Event gefunden';
    END IF;
    
    -- Person anlegen mit Retry-Logik für optimistische Sperrung
    WHILE v_current_attempt < v_max_attempts AND NOT v_status_ok LOOP
        BEGIN
            v_current_attempt := v_current_attempt + 1;
            
            -- Transaktion starten
            BEGIN
                -- Person anlegen
                INSERT INTO Person (Name, Vorname, Geburtsdatum, Geschlecht) 
                VALUES ('Schmidt', 'Anna', '1985-08-22', 'w')
                RETURNING PersonID INTO v_person_id;
                
                -- Mitgliedschaft anlegen
                INSERT INTO Person_Status (PersonID, StatusID, Von) 
                VALUES (v_person_id, 1, CURRENT_DATE);
                
                -- Veranstaltungsteilnahme
                INSERT INTO Teilnehmer (PersonID, AnlassID) 
                VALUES (v_person_id, v_anlass_id);
                
                v_status_ok := TRUE;
                COMMIT;
            EXCEPTION
                WHEN unique_violation THEN
                    ROLLBACK;
                    RAISE NOTICE 'Concurrent modification detected, retry % of %', 
                        v_current_attempt, v_max_attempts;
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE;
            END;
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
