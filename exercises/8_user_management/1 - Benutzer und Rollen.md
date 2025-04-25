---
title: "Benutzerverwaltung / Übung 1: Benutzer und Rollen"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DCL
    - Benutzer
    - Rollen
---

# Übung 1: Benutzer und Rollen

## Lernziele

In dieser Übung wirst du:
- Verschiedene Benutzer und Rollen in PostgreSQL erstellen
- Die Unterschiede zwischen Benutzern und Rollen verstehen
- Benutzer- und Rollenattribute konfigurieren
- Eine einfache Rollenhierarchie aufbauen

## Aufgabenszenario

Du bist als Datenbankadministrator für ein neues Projekt verantwortlich und musst die grundlegende Benutzerstruktur für eine PostgreSQL-Datenbank einrichten. Du arbeitest mit einer Testdatenbank oder unserer bekannten `verein`-Datenbank.

## Teil 1: Grundlegende Benutzer erstellen

### Aufgabe 1.1: Einfache Benutzererstellung
1. Erstelle einen Datenbankbenutzer namens `app_user` mit einem Passwort deiner Wahl.
2. Erstelle einen zweiten Benutzer namens `reporting_user` mit einem anderen Passwort.
3. Überprüfe mit dem Befehl `\du` (in psql) oder einer entsprechenden Abfrage in DBeaver, ob die Benutzer erfolgreich erstellt wurden.

```sql
-- Beispiellösung für Aufgabe 1.1:
CREATE USER app_user WITH PASSWORD 'sicheres_passwort1';
CREATE USER reporting_user WITH PASSWORD 'sicheres_passwort2';

-- Überprüfung der erstellten Benutzer
SELECT usename, usecreatedb, usesuper 
FROM pg_catalog.pg_user;
```

### Aufgabe 1.2: Benutzer mit Attributen
1. Erstelle einen Benutzer namens `admin_user` mit Passwort, der Datenbanken erstellen darf (`CREATEDB`).
2. Erstelle einen Benutzer namens `temp_user` mit Passwort, der nur bis zum 31.12.2025 gültig ist.
3. Versuche, einen Superuser zu erstellen (dies wird möglicherweise fehlschlagen, abhängig von deinen Berechtigungen).

```sql
-- Beispiel für Benutzer mit Attributen
CREATE USER admin_user WITH PASSWORD 'admin_pw' CREATEDB;
CREATE USER temp_user WITH PASSWORD 'temp_pw' VALID UNTIL '2025-12-31';

-- Versuch, einen Superuser zu erstellen (erfordert Superuser-Rechte)
CREATE USER super_user WITH SUPERUSER PASSWORD 'super_pw';
```

## Teil 2: Rollen erstellen und verwalten

### Aufgabe 2.1: Einfache Rollen
1. Erstelle eine Rolle namens `read_only` ohne Login-Berechtigung.
2. Erstelle eine Rolle namens `read_write` ohne Login-Berechtigung.
3. Erstelle eine Rolle namens `app_admin` ohne Login-Berechtigung.

```sql
-- Beispiellösung für Aufgabe 2.1:
CREATE ROLE read_only NOLOGIN;
CREATE ROLE read_write NOLOGIN;
CREATE ROLE app_admin NOLOGIN;
```

### Aufgabe 2.2: Rollenhierarchie aufbauen
1. Weise der Rolle `read_write` die Rolle `read_only` zu (Vererbung).
2. Weise der Rolle `app_admin` die Rolle `read_write` zu (Vererbung).
3. Überprüfe die Rollenhierarchie mit einer geeigneten Abfrage.

```sql
-- Beispiel für Rollenhierarchie
GRANT read_only TO read_write;
GRANT read_write TO app_admin;

-- Überprüfung der Rollenhierarchie
SELECT r.rolname, array_agg(m.rolname) AS member_of
FROM pg_roles r
LEFT JOIN pg_auth_members am ON am.member = r.oid
LEFT JOIN pg_roles m ON am.roleid = m.oid
WHERE r.rolname IN ('read_only', 'read_write', 'app_admin')
GROUP BY r.rolname;
```

### Aufgabe 2.3: Rollen den Benutzern zuweisen
1. Weise dem Benutzer `reporting_user` die Rolle `read_only` zu.
2. Weise dem Benutzer `app_user` die Rolle `read_write` zu.
3. Weise dem Benutzer `admin_user` die Rolle `app_admin` zu.

```sql
-- Beispiel für Rollenzuweisung
GRANT read_only TO reporting_user;
GRANT read_write TO app_user;
GRANT app_admin TO admin_user;
```

## Teil 3: Benutzer- und Rollenverwaltung

### Aufgabe 3.1: Benutzerattribute ändern
1. Ändere das Passwort des Benutzers `app_user`.
2. Deaktiviere den Benutzer `temp_user` temporär (Tipp: `NOLOGIN`).
3. Erlaube dem Benutzer `reporting_user` Datenbankverbindungen zu erstellen (Tipp: `CREATEDB`).

```sql
-- Beispiel für Attributänderungen
ALTER USER app_user WITH PASSWORD 'neues_passwort';
ALTER USER temp_user WITH NOLOGIN;
ALTER USER reporting_user WITH CREATEDB;
```

### Aufgabe 3.2: Benutzer und Rollen löschen
1. Entziehe dem Benutzer `reporting_user` die Rolle `read_only`.
2. Lösche die Rolle `app_admin` (beachte dabei die Abhängigkeiten).
3. Lösche den Benutzer `temp_user`.

```sql
-- Beispiel für Entziehen und Löschen
REVOKE read_only FROM reporting_user;
REVOKE read_write FROM app_admin; -- Zuerst Abhängigkeiten auflösen
DROP ROLE app_admin;
DROP USER temp_user;
```

## Hinweise zur Bearbeitung

- Führe die Befehle in der angegebenen Reihenfolge aus
- Beachte die Ausgabe der Befehle und korrigiere aufgetretene Fehler
- Falls du nicht über ausreichende Berechtigungen verfügst (z.B. für `SUPERUSER`), notiere die Fehlermeldung
- Am Ende der Übung solltest du alle erstellten Benutzer und Rollen wieder löschen, um die Datenbank in den ursprünglichen Zustand zurückzuversetzen

## Zusatzaufgabe (optional)

Erstelle ein SQL-Skript, das automatisch:
1. Alle in dieser Übung erstellten Benutzer und Rollen löscht (falls vorhanden)
2. Anschliessend alle Benutzer und Rollen neu erstellt und konfiguriert
3. Die Zuweisungen zwischen Rollen und Benutzern herstellt

Das Skript sollte idempotent sein, d.h. es kann mehrfach ausgeführt werden, ohne Fehler zu verursachen.
