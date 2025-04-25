---
theme: hftm
footer: 'Benutzerverwaltung und Berechtigungen (DCL)'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>Benutzerverwaltung</h1>
  <p class="date-author">April 2025 | Autor: Simon Erhardt</p>
</div>

---

# Warum Benutzer- und Rechteverwaltung?

- **Datensicherheit**: Schutz vor unbefugtem Zugriff
- **Datenintegrität**: Schutz vor unbeabsichtigten Änderungen
- **Compliance**: Einhaltung gesetzlicher Anforderungen (DSGVO, etc.)
- **Audit-Fähigkeit**: Nachvollziehbarkeit von Änderungen
- **Arbeitsteilung**: Verschiedene Rollen mit verschiedenen Rechten

<!-- Diskussionsfrage: Welche Probleme können entstehen, wenn alle Benutzer volle Berechtigungen haben? -->

---

# Grundbegriffe der Benutzerverwaltung

- **DCL**: Data Control Language - Teil von SQL für Berechtigungsverwaltung
- **Benutzer (User)**: Konto zur Datenbankanmeldung
- **Rolle (Role)**: Sammlung von Berechtigungen
  - In PostgreSQL sind Benutzer spezielle Rollen mit Anmelderechten
- **Prinzip der geringsten Berechtigung**: Nur die minimal notwendigen Rechte erteilen

---

# Arten von Berechtigungen

## Objektberechtigungen
- `SELECT`: Daten lesen
- `INSERT`: Daten einfügen
- `UPDATE`: Daten ändern
- `DELETE`: Daten löschen
- `TRUNCATE`: Tabelle leeren
- `REFERENCES`: Fremdschlüsselbeziehungen erstellen
- `TRIGGER`: Trigger erstellen

## Systemberechtigungen
- `CREATE`/`ALTER`/`DROP USER/ROLE`: Benutzerverwaltung
- `CREATE DATABASE/SCHEMA/TABLESPACE`: Strukturverwaltung

---

# Benutzer und Rollen erstellen

```sql
-- Benutzer erstellen
CREATE USER username WITH PASSWORD 'password';

-- Rolle erstellen
CREATE ROLE rolename;

-- Rolle mit spezifischen Attributen
CREATE ROLE reporting_role WITH 
    NOLOGIN       -- Kann sich nicht anmelden
    NOSUPERUSER   -- Keine Superuser-Rechte
    NOCREATEDB    -- Kann keine Datenbanken erstellen
    NOCREATEROLE; -- Kann keine Rollen erstellen
```

<!-- Hinweis für Dozenten: Live-Demo, einen Benutzer und eine Rolle erstellen -->

---

# Benutzer und Rollen verwalten

```sql
-- Passwort ändern
ALTER USER username WITH PASSWORD 'new_password';

-- Attribute einer Rolle ändern
ALTER ROLE rolename WITH CREATEDB;

-- Ablaufdatum für einen Benutzer setzen
ALTER USER username VALID UNTIL '2025-12-31';

-- Benutzer/Rolle löschen
DROP USER username;
DROP ROLE rolename;
```

---

# Berechtigungen erteilen (GRANT)

```sql
-- Leserechte auf eine Tabelle
GRANT SELECT ON TABLE employees TO username;

-- Mehrere Rechte auf eine Tabelle
GRANT SELECT, INSERT, UPDATE ON TABLE employees TO analyst_role;

-- Rechte auf alle Tabellen in einem Schema
GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader_role;

-- Einer Rolle eine andere Rolle zuweisen
GRANT admin_role TO username;

-- Berechtigungen mit Weitergaberecht
GRANT SELECT ON TABLE customers TO manager_role WITH GRANT OPTION;
```

---

# Berechtigungen entziehen (REVOKE)

```sql
-- Löschrecht auf eine Tabelle entziehen
REVOKE DELETE ON TABLE employees FROM username;

-- Alle Rechte auf eine Tabelle entziehen
REVOKE ALL PRIVILEGES ON TABLE employees FROM username;

-- Mitgliedschaft in einer Rolle entziehen
REVOKE admin_role FROM username;
```

---

# Spezialfälle: Spaltenspezifische Berechtigungen

```sql
-- Nur Zugriff auf bestimmte Spalten gewähren
GRANT SELECT (employee_id, first_name, last_name, department_id) 
ON TABLE employees TO staff_role;

-- UPDATE nur auf bestimmte Spalten
GRANT UPDATE (email, phone) ON TABLE employees TO hr_assistant;
```

<!-- Hinweis: Spaltenspezifische Berechtigungen eignen sich hervorragend für den Datenschutz -->

---

# Audit-Log mit INSERT-only Berechtigungen

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

-- Audit-Rolle erstellen und Rechte zuweisen
CREATE ROLE audit_logger;
GRANT INSERT ON TABLE audit_log TO audit_logger;

-- Sicherstellen, dass keine anderen Rechte bestehen
REVOKE UPDATE, DELETE ON TABLE audit_log FROM audit_logger;
```

<!-- 
Hinweis: Diese Konfiguration stellt sicher, dass Einträge erstellt, aber später nicht geändert werden können - 
ideal für Audit-Trails und regulatorische Anforderungen
-->

---

# Berechtigungshierarchien mit Rollen

```sql
-- Basisrollen erstellen
CREATE ROLE app_read;
CREATE ROLE app_write;

-- Berechtigungen für Basisrollen definieren
GRANT SELECT ON ALL TABLES IN SCHEMA app TO app_read;
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA app TO app_write;

-- Anwendungsrollen, die von Basisrollen erben
CREATE ROLE app_user;
CREATE ROLE app_admin;

-- Rollenvererbung einrichten
GRANT app_read TO app_user;              -- app_user erbt Leserechte
GRANT app_read, app_write TO app_admin;  -- app_admin erbt Lese- und Schreibrechte
```

---

# Praktisches Beispiel: Vier-Augen-Prinzip

<table>
<tr>
<td class="half">

```sql
-- Tabelle für Überweisungsanträge
CREATE TABLE transfer_requests (
    request_id SERIAL PRIMARY KEY,
    amount DECIMAL(12,2),
    source_account VARCHAR(50),
    target_account VARCHAR(50),
    requested_by VARCHAR(50),
    approved_by VARCHAR(50) DEFAULT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approval_time TIMESTAMP
);
```

</td>
<td class="half">

```sql
-- Rollen und Berechtigungen
CREATE ROLE transfer_requester; -- darf Anträge erstellen
CREATE ROLE transfer_approver;  -- darf Anträge genehmigen

GRANT INSERT, SELECT ON transfer_requests TO transfer_requester;
GRANT SELECT, UPDATE (approved_by, status, approval_time) 
  ON transfer_requests TO transfer_approver;
```

</td>
</tr>
</table>

---

# Best Practices für Datenbankberechtigungen

1. **Prinzip der geringsten Berechtigung**: Nur minimal notwendige Rechte erteilen
2. **Rollen statt Einzelberechtigungen**: Berechtigungen über Rollen gruppieren
3. **Regelmässige Überprüfung**: Zugriffsrechte regelmässig überprüfen
4. **Starke Passwörter**: Komplexe Passwörter und regelmässiger Wechsel
5. **Dokumentation**: Berechtigungskonzept dokumentieren
6. **Ablaufdaten**: Temporäre Zugänge mit Ablaufdatum versehen
7. **Schema-Trennung**: Unterschiedliche Schemas für verschiedene Anwendungsbereiche

---

# Zusammenfassung

- DCL ermöglicht die Verwaltung von **Datenbankberechtigungen**
- **Benutzer** und **Rollen** sind die Grundbausteine des Berechtigungssystems
- `GRANT` und `REVOKE` steuern die Vergabe und den Entzug von Berechtigungen
- **Prinzip der geringsten Berechtigung** ist essentiell für die Sicherheit
- **Spezialisierte Berechtigungsszenarien** wie Audit-Logs oder Vier-Augen-Prinzip lassen sich gut umsetzen
- In **professionellen Umgebungen** ist ein durchdachtes Berechtigungskonzept unverzichtbar

<!-- 
Abschlussfrage: Welche Berechtigungsszenarien könnten in euren aktuellen oder zukünftigen Projekten relevant sein?
-->
