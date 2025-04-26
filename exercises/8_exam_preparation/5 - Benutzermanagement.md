---
title: "Prüfungsvorbereitung: Benutzerverwaltung und Berechtigungen"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DCL
    - Benutzer
    - Rollen
    - Berechtigungen
---

# Prüfungsvorbereitung: Benutzerverwaltung und Berechtigungen

## Übungsziele

In diesem Übungsblatt werden die Konzepte der Benutzerverwaltung und Berechtigungen in relationalen Datenbanken wiederholt und vertieft. Nach Bearbeitung dieser Übungen solltest du:

- Die Grundkonzepte der Data Control Language (DCL) verstehen und anwenden können
- Benutzer und Rollen in PostgreSQL erstellen und verwalten können
- Berechtigungen mit GRANT/REVOKE-Befehlen erteilen und entziehen können
- Das Prinzip der geringsten Berechtigung (Least Privilege) praktisch umsetzen können
- Komplexe Berechtigungsstrukturen für verschiedene Anwendungsfälle entwerfen können

## Theoretische Fragen

### 1.1 Grundkonzepte der Benutzerverwaltung

Erkläre die folgenden Begriffe und ihre Bedeutung im Kontext der Datenbankzugriffskontrolle:

a) Data Control Language (DCL)
b) Benutzer (User) vs. Rolle (Role)
c) Prinzip der geringsten Berechtigung (Least Privilege)
d) Objektberechtigungen vs. Systemberechtigungen
e) Berechtigungsweitergabe (WITH GRANT OPTION)

### 1.2 DCL-Befehle

Erläutere die Funktion und Syntax der folgenden DCL-Befehle und gib jeweils ein Beispiel:

a) CREATE USER / CREATE ROLE
b) ALTER USER / ALTER ROLE
c) DROP USER / DROP ROLE
d) GRANT
e) REVOKE

### 1.3 Vererbung und Hierarchien

Erkläre, wie Rollenvererbung in PostgreSQL funktioniert und welche Vorteile die Verwendung von Rollenhierarchien bietet. Gib ein Beispiel für eine sinnvolle Rollenhierarchie.

## Praktische Übungen

### 2.1 Benutzer- und Rollenerstellung

Du bist Datenbankadministrator eines kleinen Unternehmens und musst Benutzer und Rollen für verschiedene Abteilungen einrichten. Schreibe die SQL-Befehle für folgende Aufgaben:

a) Erstelle eine Rolle `verkauf_rolle` für die Vertriebsmitarbeiter mit folgenden Eigenschaften:
   - Kein Login möglich (wird nur zur Rechteverwaltung verwendet)
   - Nicht berechtigt, Datenbanken zu erstellen
   - Nicht berechtigt, neue Rollen zu erstellen

b) Erstelle einen Benutzer `max_mueller` mit Passwort 'sicher123' und folgenden Eigenschaften:
   - Kann sich an der Datenbank anmelden
   - Das Konto soll am 31.12.2025 ablaufen

c) Erstelle zusätzlich die Rollen `marketing_rolle` und `admin_rolle` mit geeigneten Eigenschaften.

d) Weise dem Benutzer `max_mueller` die Rolle `verkauf_rolle` zu.

e) Erstelle eine Hierarchie, in der `admin_rolle` die Rechte von `verkauf_rolle` und `marketing_rolle` erbt.

### 2.2 Berechtigungen für Tabellen

Führe folgende Aufgaben aus:

a) Gewähre der `verkauf_rolle` Leserechte (SELECT) auf die Tabelle `Kunde` und Leserechte sowie Einfügungsrechte (INSERT) auf die Tabelle `Bestellung`.

b) Gewähre dem Benutzer `max_mueller` direkt (nicht über eine Rolle) die Berechtigung, Daten in der Tabelle `Kunde` zu aktualisieren (UPDATE), aber nur für die Spalten `Telefonnummer` und `Email`.

c) Erteile der `marketing_rolle` Leserechte auf alle Tabellen im Schema `public`.

d) Erteile der `admin_rolle` alle Rechte auf alle Tabellen im Schema `public` mit der Option, diese Rechte weiterzugeben.

e) Entziehe dem Benutzer `max_mueller` das Recht, Daten aus der Tabelle `Kunde` zu löschen (falls dieses Recht besteht).

### 2.3 Berechtigungen für Datenbankobjekte

Erstelle ein Schema für die Finanzabteilung und richte entsprechende Berechtigungen ein:

a) Erstelle ein neues Schema namens `finanz` und eine neue Rolle `finanz_rolle`.

b) Erstelle in diesem Schema eine Tabelle `Rechnung` mit geeigneten Spalten.

c) Gewähre der `finanz_rolle` volle Rechte auf das Schema `finanz` und alle darin enthaltenen Objekte.

d) Definiere eine Dokumentationsrichtlinie, die beschreibt, wie der Zugriff auf bestimmte Rechnungen für die `verkauf_rolle` beschränkt werden kann (grundlegende Strategie mit Tabellenberechtigung).

e) Richte eine Berechtigung ein, die es Benutzern mit der `admin_rolle` erlaubt, neue Objekte im Schema `finanz` zu erstellen.

### 2.4 Audit-Log mit INSERT-only-Berechtigungen

Implementiere ein Audit-Log-System mit speziellen Berechtigungen:

a) Erstelle eine Tabelle `audit_log` mit folgenden Spalten:
   - `log_id` (automatisch inkrementierend)
   - `zeitstempel` (automatisch auf den aktuellen Zeitpunkt gesetzt)
   - `benutzer` (der angemeldete Datenbankbenutzer)
   - `aktion` (Art der Aktion, z.B. 'INSERT', 'UPDATE', 'DELETE')
   - `tabelle` (betroffene Tabelle)
   - `datensatz_id` (ID des betroffenen Datensatzes)
   - `details` (JSON oder Text mit Details)

b) Erstelle eine Rolle `logger_rolle` mit der ausschliesslichen Berechtigung, Einträge in der `audit_log`-Tabelle zu erstellen (INSERT), aber ohne die Möglichkeit, bestehende Einträge zu lesen, zu ändern oder zu löschen.

c) Erstelle eine Rolle `auditor_rolle` mit der Berechtigung, Einträge in der `audit_log`-Tabelle zu lesen (SELECT), aber ohne die Möglichkeit, Einträge zu erstellen, zu ändern oder zu löschen.

d) Erkläre, wie ein wirksames Audit-Log-System aufgebaut sein sollte und welche Rolle die Berechtigungssteuerung dabei spielt (ohne Code-Implementierung).

### 2.5 Komplexes Berechtigungsszenario für ein Mehrbenutzersystem

Du entwickelst ein Datenbanksystem für ein Ärztenetzwerk mit verschiedenen Benutzergruppen. Entwirf ein grundlegendes Berechtigungskonzept mit folgenden Anforderungen:

a) Definiere eine Rollenstruktur für verschiedene Benutzergruppen: Ärzte, Pflegepersonal, Verwaltungspersonal, Abrechnungsmitarbeiter und IT-Administratoren.

b) Lege fest, welche Tabellenzugriffe (SELECT, INSERT, UPDATE, DELETE) für jede Rolle auf den folgenden Tabellen erlaubt sein sollten:
   - Patient (PatientID, Name, Vorname, Geburtsdatum, Adresse, Versicherungsnummer)
   - Diagnose (DiagnoseID, PatientID, ArztID, Datum, Beschreibung, Diagnosecode)
   - Behandlung (BehandlungID, PatientID, ArztID, Datum, Beschreibung, Behandlungscode, Kosten)
   - ArztPatient (ArztID, PatientID)

c) Erstelle eine Rollenhierarchie, die die Vererbung von Berechtigungen zwischen verwandten Rollen abbildet.

d) Implementiere die grundlegenden GRANT-Befehle für die wichtigsten Zugriffsrechte (mindestens 5 Beispiele).

e) Dokumentiere Einschränkungen dieses Berechtigungskonzepts (z.B. wo feingranulare Zugriffssteuerung mit den vorhandenen Mitteln nicht möglich ist).

## Zusatzaufgaben

### 3.1 Temporäre Berechtigungen und Zeitbeschränkungen

Manchmal ist es nötig, temporäre Berechtigungen für bestimmte Aufgaben zu gewähren. Implementiere ein Szenario, in dem:

a) Ein externer Auditor für einen begrenzten Zeitraum (bis zum Ende des Monats) Leserechte auf die Finanztabellen erhält.

b) Dokumentiere, welche Massnahmen ergriffen werden könnten, um die abgelaufenen Berechtigungen zu erkennen und zu entfernen (konzeptionell, ohne Code-Implementierung).

### 3.2 Multi-Tenant-Datenbank mit Schema-Isolation

Du entwickelst eine SaaS-Anwendung (Software as a Service), bei der jeder Kunde (Tenant) seine eigenen, isolierten Daten haben soll, aber die Datenbankinstanz geteilt wird. Entwirf ein Berechtigungskonzept für dieses Szenario:

a) Wie können Schemas zur Isolierung der Daten verschiedener Tenants verwendet werden?

b) Wie sollten die Rollen und Berechtigungen strukturiert sein, um sicherzustellen, dass jeder Tenant nur auf seine eigenen Daten zugreifen kann?

c) Welche Rolle sollte die Anwendung selbst haben, wenn sie auf die Daten aller Tenants zugreifen muss?

d) Wie kann verhindert werden, dass ein Tenant-Administrator auf Daten anderer Tenants zugreift?

---

Denke daran, die Lösungen auf einem separaten Blatt oder in einer Datei zu notieren, damit du später deine Antworten mit den Musterlösungen vergleichen kannst.
