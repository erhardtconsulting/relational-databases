---
title: "Benutzerverwaltung / Übung 3: Spezialszenario Audit-Log"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DCL
    - Audit
    - Berechtigungen
    - INSERT-only
---

# Übung 3: Spezialszenario Audit-Log

## Lernziele

In dieser Übung wirst du:
- Ein INSERT-only Berechtigungsszenario für Audit-Logs implementieren
- Triggers nutzen, um Änderungen automatisch zu protokollieren
- Die Integrität von Audit-Daten durch gezielte Berechtigungen sicherstellen
- Ein praktisches Sicherheitskonzept für Datenbankänderungen umsetzen

## Aufgabenszenario

In vielen Anwendungen mit hohen Sicherheits- oder Compliance-Anforderungen müssen alle Änderungen an sensiblen Daten protokolliert werden. In dieser Übung wirst du ein manipulationssicheres Audit-System für die `verein`-Datenbank einrichten, das Änderungen an den Mitgliederdaten protokolliert.

Das Besondere: Die Audit-Logs sollen unveränderlich sein - einmal geschrieben, können die Protokolleinträge weder geändert noch gelöscht werden (INSERT-only Berechtigung).

## Teil 1: Audit-Log-Tabelle und Berechtigungen

### Aufgabe 1.1: Audit-Log-Tabelle erstellen
1. Erstelle eine Tabelle `audit_log` mit folgender Struktur:
   - `log_id`: Automatisch inkrementierender Primärschlüssel
   - `zeitstempel`: Zeitstempel mit Standardwert CURRENT_TIMESTAMP
   - `benutzer`: Name des Datenbankbenutzers, der die Aktion ausgeführt hat
   - `aktion`: Art der Aktion (INSERT, UPDATE, DELETE)
   - `tabelle`: Name der Tabelle, die geändert wurde
   - `datensatz_id`: ID des betroffenen Datensatzes
   - `alte_werte`: JSON-Objekt mit alten Werten (vor der Änderung)
   - `neue_werte`: JSON-Objekt mit neuen Werten (nach der Änderung)

```sql
-- Beispiellösung für Aufgabe 1.1:
CREATE TABLE audit_log (
    log_id SERIAL PRIMARY KEY,
    zeitstempel TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    benutzer VARCHAR(100),
    aktion VARCHAR(10) CHECK (aktion IN ('INSERT', 'UPDATE', 'DELETE')),
    tabelle VARCHAR(100),
    datensatz_id INTEGER,
    alte_werte JSONB,
    neue_werte JSONB
);
```

### Aufgabe 1.2: Audit-Benutzer und Rollen erstellen
1. Erstelle eine Rolle namens `audit_role` ohne Login-Berechtigung.
2. Erstelle einen Benutzer namens `audit_user` mit Passwort und weise ihm die Rolle `audit_role` zu.
3. Erstelle zusätzlich einen Benutzer namens `audit_admin` mit Passwort, der später Audit-Daten lesen darf.

```sql
-- Beispiellösung für Aufgabe 1.2:
CREATE ROLE audit_role NOLOGIN;
CREATE USER audit_user WITH PASSWORD 'audit123';
CREATE USER audit_admin WITH PASSWORD 'admin123';

GRANT audit_role TO audit_user;
```

### Aufgabe 1.3: INSERT-only Berechtigungen konfigurieren
1. Erteile der Rolle `audit_role` **nur** INSERT-Berechtigungen auf die Tabelle `audit_log`.
2. Entziehe explizit alle anderen Berechtigungen (SELECT, UPDATE, DELETE, TRUNCATE) von dieser Rolle.
3. Erteile dem Benutzer `audit_admin` Leserechte (SELECT) auf die Tabelle `audit_log`.

```sql
-- Beispiellösung für Aufgabe 1.3:
GRANT INSERT ON TABLE audit_log TO audit_role;
REVOKE SELECT, UPDATE, DELETE, TRUNCATE ON TABLE audit_log FROM audit_role;

GRANT SELECT ON TABLE audit_log TO audit_admin;
```

## Teil 2: Audit-Trigger für automatische Protokollierung

### Aufgabe 2.1: Trigger-Funktion erstellen
Erstelle eine Trigger-Funktion, die Änderungen an Tabellen automatisch in die Audit-Log-Tabelle schreibt. Die Funktion soll:
1. Den aktuellen Datenbankbenutzer ermitteln
2. Die Art der Aktion (INSERT, UPDATE, DELETE) identifizieren
3. Die betroffene Tabelle und den Primärschlüsselwert speichern
4. Die alten und neuen Werte als JSON speichern

```sql
-- Beispiellösung für Aufgabe 2.1:
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    old_values JSONB := NULL;
    new_values JSONB := NULL;
    rec_id INTEGER;
BEGIN
    IF TG_OP = 'INSERT' THEN
        new_values := to_jsonb(NEW);
        rec_id := NEW.id; -- Annahme: Die Spalte heisst 'id' (anpassen falls nötig)
    ELSIF TG_OP = 'UPDATE' THEN
        old_values := to_jsonb(OLD);
        new_values := to_jsonb(NEW);
        rec_id := NEW.id;
    ELSIF TG_OP = 'DELETE' THEN
        old_values := to_jsonb(OLD);
        rec_id := OLD.id;
    END IF;

    -- Protokollierung nur als audit_user durchführen
    SET LOCAL ROLE audit_user;

    INSERT INTO audit_log (
        zeitstempel,
        benutzer,
        aktion,
        tabelle,
        datensatz_id,
        alte_werte,
        neue_werte
    )
    VALUES (
        CURRENT_TIMESTAMP,
        CURRENT_USER,
        TG_OP,
        TG_TABLE_NAME,
        rec_id,
        old_values,
        new_values
    );

    -- Zurück zur ursprünglichen Rolle
    RESET ROLE;
    
    -- Rückgabe für Trigger
    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### Aufgabe 2.2: Trigger auf die Personen-Tabelle anwenden
Erstelle Trigger, die die Audit-Funktion für alle Änderungen an der Tabelle `person` aufrufen:

```sql
-- Beispiellösung für Aufgabe 2.2:
CREATE TRIGGER person_audit_insert
AFTER INSERT ON person
FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER person_audit_update
AFTER UPDATE ON person
FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER person_audit_delete
AFTER DELETE ON person
FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();
```

## Teil 3: Testen des Audit-Systems

### Aufgabe 3.1: Änderungen an den Personendaten vornehmen
1. Füge eine neue Person in die Tabelle `person` ein.
2. Aktualisiere einige Daten dieser Person.
3. Lösche die Person wieder.

```sql
-- Beispiellösung für Aufgabe 3.1:
-- Neue Person einfügen
INSERT INTO person (
    Name, Vorname, Adresse, PLZ, Ort, Geburtsdatum, Email, Eintritt, StatID
) VALUES (
    'Mustermann', 'Max', 'Musterstr. 1', '1234', 'Musterstadt', 
    '1990-01-01', 'max@example.com', CURRENT_DATE, 1
);

-- ID der eingefügten Person ermitteln
SET @new_person_id = LASTVAL(); -- oder: SELECT CURRVAL('person_PersID_seq');

-- Daten aktualisieren
UPDATE person 
SET Email = 'max.mustermann@example.com', Ort = 'Neustadt' 
WHERE PersID = @new_person_id;

-- Person löschen
DELETE FROM person WHERE PersID = @new_person_id;
```

### Aufgabe 3.2: Audit-Logs überprüfen
1. Melde dich als `audit_admin` an.
2. Frage die Audit-Log-Tabelle ab und überprüfe, ob alle Änderungen korrekt protokolliert wurden.
3. Versuche, einen Audit-Log-Eintrag zu ändern (sollte fehlschlagen).

```sql
-- Beispiellösung für Aufgabe 3.2:
-- Als audit_admin anmelden und logs abfragen
SELECT * FROM audit_log WHERE tabelle = 'person' ORDER BY zeitstempel DESC LIMIT 10;

-- Versuch, einen Log-Eintrag zu ändern (sollte fehlschlagen)
UPDATE audit_log SET aktion = 'EDIT' WHERE log_id = 1;

-- Versuch, einen Log-Eintrag zu löschen (sollte fehlschlagen)
DELETE FROM audit_log WHERE log_id = 1;
```

### Aufgabe 3.3: Manipulationsversuch
1. Melde dich als `audit_user` an.
2. Versuche, die Audit-Log-Tabelle abzufragen (sollte fehlschlagen).
3. Versuche, einen Audit-Log-Eintrag zu ändern oder zu löschen (sollte fehlschlagen).

```sql
-- Beispiellösung für Aufgabe 3.3:
-- Als audit_user anmelden
-- Versuche verschiedene Operationen
SELECT * FROM audit_log LIMIT 5; -- Sollte fehlschlagen
UPDATE audit_log SET aktion = 'EDIT' WHERE log_id = 1; -- Sollte fehlschlagen
DELETE FROM audit_log WHERE log_id = 1; -- Sollte fehlschlagen
```

## Teil 4: Erweitertes Szenario

### Aufgabe 4.1: Selektive Audit-Protokollierung (optional)
Implementiere eine verbesserte Version der Audit-Trigger-Funktion, die:
1. Nur bestimmte Spaltenänderungen protokolliert (z.B. Name, E-Mail, aber nicht Adresse)
2. Keine Protokollierung vornimmt, wenn nur unwichtige Felder geändert wurden

```sql
-- Beispiellösung für Aufgabe 4.1:
CREATE OR REPLACE FUNCTION selective_audit_trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    old_values JSONB := NULL;
    new_values JSONB := NULL;
    rec_id INTEGER;
    wichtige_aenderung BOOLEAN := FALSE;
BEGIN
    -- Nur wichtige Spalten überprüfen
    IF TG_OP = 'UPDATE' THEN
        IF (OLD.Name != NEW.Name OR 
            OLD.Vorname != NEW.Vorname OR 
            OLD.Email != NEW.Email OR
            OLD.StatID != NEW.StatID) THEN
            wichtige_aenderung := TRUE;
        ELSE
            -- Keine wichtige Änderung, kein Log-Eintrag nötig
            RETURN NEW;
        END IF;
    END IF;

    -- Rest wie in der ursprünglichen Funktion...
    -- [code hier einfügen]
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### Aufgabe 4.2: Audit-Dashboard (optional)
Erstelle eine View, die als Basis für ein Audit-Dashboard dienen kann:
1. Die View sollte alle relevanten Informationen aus der Audit-Log-Tabelle enthalten
2. Füge zusätzliche berechnete Spalten hinzu (z.B. Tageszeit der Änderung)
3. Richte die Berechtigungen so ein, dass nur autorisierte Benutzer auf diese View zugreifen können

```sql
-- Beispiellösung für Aufgabe 4.2:
CREATE VIEW audit_dashboard AS
SELECT
    log_id,
    zeitstempel,
    benutzer,
    aktion,
    tabelle,
    datensatz_id,
    TO_CHAR(zeitstempel, 'HH24:MI:SS') AS uhrzeit,
    TO_CHAR(zeitstempel, 'YYYY-MM-DD') AS datum,
    CASE 
        WHEN aktion = 'INSERT' THEN 'Neu'
        WHEN aktion = 'UPDATE' THEN 'Änderung'
        WHEN aktion = 'DELETE' THEN 'Löschung'
    END AS aktionstyp,
    alte_werte,
    neue_werte,
    neue_werte->'Email' AS geaenderte_email
FROM audit_log
ORDER BY zeitstempel DESC;

-- Berechtigungen für die View
GRANT SELECT ON audit_dashboard TO audit_admin;
```

## Hinweise zur Bearbeitung

- Achte auf die korrekte Syntax bei der Erstellung von Triggern und Funktionen
- Bei Fehlern in Trigger-Funktionen überprüfe die PostgreSQL-Logs
- Stelle sicher, dass die Rollenberechtigungen korrekt konfiguriert sind
- Teste das Verhalten bei verschiedenen Arten von Änderungen (INSERT, UPDATE, DELETE)
- Prüfe die Protokollierung von NULL-Werten und Sonderzeichen
- Berücksichtige mögliche Performance-Auswirkungen durch die Audit-Trigger
- Am Ende der Übung sollten alle Trigger und Testdaten wieder entfernt werden

## Zusatzaufgabe (optional)

Recherchiere und implementiere eine Lösung für folgende Erweiterungen:
1. Verschlüsselung sensibler Daten in den Audit-Logs
2. Implementierung einer Aufbewahrungsfrist mit automatischer Archivierung älterer Logs
3. Integration des Audit-Logs mit einem externen Sicherheitssystem (z.B. SIEM)
