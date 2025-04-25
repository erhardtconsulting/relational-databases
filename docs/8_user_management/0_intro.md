# Benutzerverwaltung und Berechtigungen (DCL)

Die Verwaltung von Datenbankbenutzern und deren Zugriffsrechten ist ein zentraler Aspekt in der Datenbankadministration. Während wir uns bisher hauptsächlich mit der Definition von Datenstrukturen (DDL) und der Manipulation von Daten (DML) beschäftigt haben, widmen wir uns nun der Data Control Language (DCL), die für die Zugriffskontrolle in Datenbanksystemen verantwortlich ist.

## Lernziele

Nach dem Durcharbeiten dieses Kapitels solltest du:

- Die Grundkonzepte der Benutzerverwaltung in Datenbanksystemen verstehen.
- Den Unterschied zwischen Benutzern und Rollen erklären können.
- Die wichtigsten SQL-DCL-Befehle (`CREATE USER/ROLE`, `ALTER USER`, `DROP USER/ROLE`, `GRANT`, `REVOKE`) anwenden können.
- Spezifische Rechtestrukturen für verschiedene Anwendungsfälle entwerfen können.
- Die Bedeutung des Prinzips der geringsten Berechtigung ("Least Privilege") verstehen.
- Die Sicherheitsaspekte der Datenbankzugriffskontrolle einschätzen können.

## Überblick

In diesem Kapitel behandeln wir:

1. **Grundlagen der Benutzerverwaltung**: Benutzer vs. Rollen, Authentifizierung, Sicherheitskonzepte.
2. **Erstellung und Verwaltung von Benutzern und Rollen**: Syntax und Verwendung der entsprechenden Befehle.
3. **Vergabe und Entzug von Berechtigungen**: Detaillierte Betrachtung von `GRANT` und `REVOKE`.
4. **Berechtigungstypen**: Unterscheidung zwischen Objekt- und Systemberechtigungen.
5. **Fortgeschrittene Szenarien**: Berechtigungshierarchien, Vererbung, spezielle Anwendungsfälle.

Die Beherrschung der DCL-Befehle und -Konzepte ist entscheidend für die Entwicklung sicherer und gut verwalteter Datenbanksysteme. In einer professionellen Umgebung ist die korrekte Implementierung von Zugriffskontrollen oft genauso wichtig wie die eigentliche Datenbankstruktur und -funktionalität.
