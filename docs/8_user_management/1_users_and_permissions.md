# Benutzerverwaltung und Berechtigungen

## Warum sind Benutzerverwaltung und Berechtigungen wichtig?

In einer Welt, in der Daten zu den wertvollsten Ressourcen gehören, ist deren Schutz und kontrollierter Zugriff von entscheidender Bedeutung. Stellen wir uns folgende Szenarien vor:

- Eine Bankanwendung, bei der nur bestimmte Mitarbeiter Überweisungen über einem bestimmten Betrag genehmigen dürfen
- Ein Gesundheitssystem, bei dem Patientendaten nur von autorisiertem medizinischem Personal eingesehen werden können
- Ein Unternehmenssystem, in dem die Personalabteilung Gehaltsänderungen vornehmen kann, während andere Abteilungen diese Daten nur lesen dürfen

In all diesen Fällen ist ein differenziertes System von Zugriffsrechten unerlässlich. In Datenbanksystemen wird dies durch die **Data Control Language (DCL)** ermöglicht – ein Teil der SQL-Sprache, der speziell für die Verwaltung von Berechtigungen konzipiert wurde.

Die Implementierung eines durchdachten Berechtigungskonzepts bietet mehrere Vorteile:

1. **Datensicherheit**: Schutz sensibler Informationen vor unbefugtem Zugriff
2. **Datenintegrität**: Verhinderung unbeabsichtigter Änderungen durch nicht autorisierte Benutzer
3. **Compliance**: Erfüllung gesetzlicher Anforderungen (z.B. DSGVO, Branchenstandards)
4. **Auditing**: Nachvollziehbarkeit von Datenzugriffen und -änderungen
5. **Arbeitsteilung**: Ermöglichung spezialisierter Zugriffe basierend auf Funktionen oder Abteilungen

## Was sind die grundlegenden Konzepte?

### Benutzer vs. Rollen

In Datenbanksystemen unterscheiden wir zwischen **Benutzern** und **Rollen**:

- **Benutzer (User)**: Ein Datenbankbenutzer ist ein Konto, mit dem sich eine Person oder Anwendung bei der Datenbank authentifizieren kann. Jeder Benutzer hat normalerweise eigene Anmeldeinformationen.

- **Rolle (Role)**: Eine Rolle ist eine Sammlung von Berechtigungen, die Benutzern zugewiesen werden kann. Rollen erleichtern die Verwaltung von Berechtigungen, da Änderungen an einer Rolle automatisch für alle Benutzer gelten, denen diese Rolle zugewiesen wurde.

In PostgreSQL ist die Unterscheidung zwischen Benutzern und Rollen weniger strikt – hier sind Benutzer technisch gesehen spezielle Rollen mit Anmelderechten.

### Arten von Berechtigungen

Datenbankberechtigungen lassen sich in zwei Hauptkategorien einteilen:

1. **Objektberechtigungen**: Beziehen sich auf spezifische Datenbankobjekte wie Tabellen, Views, Sequenzen usw.
   - `SELECT`: Erlaubt das Lesen/Abfragen von Daten
   - `INSERT`: Erlaubt das Hinzufügen neuer Datensätze
   - `UPDATE`: Erlaubt das Ändern bestehender Datensätze
   - `DELETE`: Erlaubt das Löschen von Datensätzen
   - `TRUNCATE`: Erlaubt das Leeren einer Tabelle
   - `REFERENCES`: Erlaubt das Erstellen von Fremdschlüsselbeziehungen
   - `TRIGGER`: Erlaubt das Erstellen von Triggern
   - `CREATE`: Erlaubt das Erstellen neuer Objekte (z.B. Tabellen in einem Schema)
   - `EXECUTE`: Erlaubt das Ausführen von Funktionen oder Prozeduren

2. **Systemberechtigungen**: Beziehen sich auf Datenbankoperationen auf Systemebene
   - `CREATE USER/ROLE`: Erlaubt das Erstellen neuer Benutzer/Rollen
   - `ALTER USER/ROLE`: Erlaubt das Ändern von Benutzern/Rollen
   - `DROP USER/ROLE`: Erlaubt das Löschen von Benutzern/Rollen
   - `CREATE DATABASE`: Erlaubt das Erstellen neuer Datenbanken
   - `CREATE SCHEMA`: Erlaubt das Erstellen neuer Schemas
   - `CREATE TABLESPACE`: Erlaubt das Erstellen von Tablespaces

### Prinzip der geringsten Berechtigung

Ein grundlegendes Sicherheitsprinzip in der Benutzerverwaltung ist das **Prinzip der geringsten Berechtigung** (Principle of Least Privilege, PoLP). Dieses besagt, dass ein Benutzer nur die minimalen Berechtigungen erhalten sollte, die er für seine Aufgaben benötigt – nicht mehr.

Dieses Prinzip reduziert die Angriffsfläche und minimiert potenzielle Schäden durch kompromittierte Benutzerkonten oder versehentliche Aktionen.

## Wie werden Benutzer und Berechtigungen verwaltet?

### Benutzer und Rollen erstellen

In PostgreSQL verwenden wir die folgenden Befehle zur Benutzerverwaltung:

```sql
-- Einen neuen Benutzer erstellen
CREATE USER username WITH PASSWORD 'password';

-- Eine neue Rolle erstellen
CREATE ROLE rolename;

-- Eine Rolle mit spezifischen Attributen erstellen
CREATE ROLE reporting_role WITH 
    NOLOGIN       -- Kann sich nicht anmelden
    NOSUPERUSER   -- Keine Superuser-Rechte
    NOCREATEDB    -- Kann keine Datenbanken erstellen
    NOCREATEROLE; -- Kann keine Rollen erstellen
```

### Benutzer und Rollen ändern

Bestehende Benutzer und Rollen können mit `ALTER` angepasst werden:

```sql
-- Passwort eines Benutzers ändern
ALTER USER username WITH PASSWORD 'new_password';

-- Attribute einer Rolle ändern
ALTER ROLE rolename WITH CREATEDB;

-- Ablaufdatum für einen Benutzer setzen
ALTER USER username VALID UNTIL '2025-12-31';
```

### Benutzer und Rollen löschen

Nicht mehr benötigte Benutzer und Rollen können entfernt werden:

```sql
-- Benutzer löschen
DROP USER username;

-- Rolle löschen
DROP ROLE rolename;

-- Rolle nur löschen, wenn sie existiert (verhindert Fehler)
DROP ROLE IF EXISTS rolename;
```

### Berechtigungen erteilen (GRANT)

Der `GRANT`-Befehl wird verwendet, um Berechtigungen zu erteilen:

```sql
-- Leserechte auf eine Tabelle gewähren
GRANT SELECT ON TABLE employees TO username;

-- Mehrere Rechte auf eine Tabelle gewähren
GRANT SELECT, INSERT, UPDATE ON TABLE employees TO analyst_role;

-- Rechte auf alle Tabellen in einem Schema gewähren
GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader_role;

-- Einer Rolle eine andere Rolle zuweisen
GRANT admin_role TO username;
```

Die Option `WITH GRANT OPTION` erlaubt es dem Empfänger, diese Berechtigungen weiterzugeben:

```sql
-- Berechtigungen mit Weitergaberecht erteilen
GRANT SELECT ON TABLE customers TO manager_role WITH GRANT OPTION;
```

### Berechtigungen entziehen (REVOKE)

Der `REVOKE`-Befehl wird verwendet, um erteilte Berechtigungen zu entziehen:

```sql
-- Löschrecht auf eine Tabelle entziehen
REVOKE DELETE ON TABLE employees FROM username;

-- Alle Rechte auf eine Tabelle entziehen
REVOKE ALL PRIVILEGES ON TABLE employees FROM username;

-- Mitgliedschaft in einer Rolle entziehen
REVOKE admin_role FROM username;
```

### Vorhandene Berechtigungen anzeigen

Um zu überprüfen, welche Berechtigungen für ein Datenbankobjekt gelten, kann in PostgreSQL folgender Befehl verwendet werden:

```sql
-- Berechtigungen für eine Tabelle anzeigen
\dp employees

-- Alternativ mit SQL
SELECT grantee, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_name = 'employees';
```

## Was wenn? Fortgeschrittene Szenarien und Anwendungsfälle

### Audit-Log mit INSERT-only Berechtigungen

Ein häufiger Anwendungsfall für spezialisierte Berechtigungen ist die Erstellung eines manipulationssicheren Audit-Logs. Hier wird ein Benutzer oder eine Rolle erstellt, die nur `INSERT`-Berechtigungen hat, aber keine `UPDATE` oder `DELETE`-Rechte:

```sql
-- Audit-Log-Tabelle erstellen
CREATE TABLE audit_log (
    log_id SERIAL PRIMARY KEY,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name TEXT,
    action_type TEXT,
    table_affected TEXT,
    record_id INTEGER,
    details TEXT
);

-- Audit-Rolle erstellen
CREATE ROLE audit_logger WITH LOGIN PASSWORD 'secure_password';

-- Nur INSERT-Rechte gewähren, keine Möglichkeit zum Ändern oder Löschen
GRANT INSERT ON TABLE audit_log TO audit_logger;
REVOKE UPDATE, DELETE ON TABLE audit_log FROM audit_logger;
```

Diese Konfiguration stellt sicher, dass Audit-Einträge nicht nachträglich geändert oder gelöscht werden können, was die Integrität des Logs gewährleistet.

### Spaltenspezifische Berechtigungen

In manchen Situationen möchten wir Zugriff auf bestimmte Spalten einer Tabelle gewähren, während andere Spalten verborgen bleiben sollen:

```sql
-- Nur Zugriff auf nicht-sensible Spalten gewähren
GRANT SELECT (employee_id, first_name, last_name, department_id) 
ON TABLE employees TO staff_role;
```

In diesem Beispiel kann ein Benutzer mit der Rolle `staff_role` die grundlegenden Mitarbeiterdaten sehen, aber keine sensiblen Informationen wie Gehalt oder persönliche Kontaktdaten.

### Temporäre Berechtigungen

In manchen Fällen müssen Berechtigungen nur für einen begrenzten Zeitraum gewährt werden:

```sql
-- Temporären Benutzer erstellen
CREATE USER temp_auditor WITH PASSWORD 'audit123' VALID UNTIL '2025-05-31';

-- Berechtigungen gewähren
GRANT SELECT ON ALL TABLES IN SCHEMA accounting TO temp_auditor;
```

Hier erhält ein temporärer Auditor Leserechte auf alle Tabellen im Accounting-Schema, aber sein Konto wird nach dem festgelegten Datum automatisch deaktiviert.

### Berechtigungshierarchien mit Rollenvererbung

Rollen können verschachtelt werden, um komplexe Berechtigungsstrukturen aufzubauen:

```sql
-- Basisrollen erstellen
CREATE ROLE app_read;
CREATE ROLE app_write;

-- Berechtigungen für Basisrollen definieren
GRANT SELECT ON ALL TABLES IN SCHEMA app TO app_read;
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA app TO app_write;

-- Anwendungsrollen erstellen, die von Basisrollen erben
CREATE ROLE app_user;
CREATE ROLE app_admin;

-- Berechtigungen zuweisen durch Rollenvererbung
GRANT app_read TO app_user;
GRANT app_read, app_write TO app_admin;

-- Benutzer erstellen und Rollen zuweisen
CREATE USER john WITH PASSWORD 'john123';
CREATE USER maria WITH PASSWORD 'maria123';

GRANT app_user TO john;
GRANT app_admin TO maria;
```

Mit dieser Struktur erbt John automatisch alle Leserechte, während Maria sowohl Lese- als auch Schreibrechte hat. Wenn sich die Berechtigungen für `app_read` oder `app_write` ändern, werden diese Änderungen automatisch an alle Benutzer weitergegeben, die diese Rollen direkt oder indirekt innehaben.

### Schemaspezifische Rollen

In grösseren Datenbanken mit mehreren Schemas kann es sinnvoll sein, schemabasierte Berechtigungsstrukturen zu erstellen:

```sql
-- Schemas erstellen
CREATE SCHEMA sales;
CREATE SCHEMA hr;
CREATE SCHEMA finance;

-- Schemabasierte Rollen erstellen
CREATE ROLE sales_user;
CREATE ROLE hr_user;
CREATE ROLE finance_user;

-- Berechtigungen für die Schemas zuweisen
GRANT USAGE ON SCHEMA sales TO sales_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales TO sales_user;

GRANT USAGE ON SCHEMA hr TO hr_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hr TO hr_user;

GRANT USAGE ON SCHEMA finance TO finance_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA finance TO finance_user;
```

So können Benutzer klare, auf ihre Abteilung bezogene Berechtigungen erhalten.

## Zusammenfassung

Die Benutzerverwaltung und Zugriffssteuerung ist ein zentraler Aspekt jedes Datenbanksystems. Mit den DCL-Befehlen (`CREATE USER/ROLE`, `ALTER USER/ROLE`, `DROP USER/ROLE`, `GRANT`, `REVOKE`) können wir feinkörnige Berechtigungskonzepte implementieren, die sowohl die Sicherheit als auch die Compliance-Anforderungen erfüllen.

Die wichtigsten Grundsätze für ein effektives Berechtigungsmanagement sind:

1. **Prinzip der geringsten Berechtigung**: Nur die minimal erforderlichen Rechte gewähren
2. **Verwendung von Rollen**: Berechtigungen über Rollen gruppieren und verwalten
3. **Regelmässige Überprüfung**: Berechtigungen regelmässig auf ihre Notwendigkeit prüfen
4. **Dokumentation**: Berechtigungskonzepte sollten dokumentiert und nachvollziehbar sein

Ein gut durchdachtes Berechtigungskonzept bildet die Grundlage für ein sicheres und compliance-konformes Datenbanksystem und ist in professionellen Umgebungen unverzichtbar.
