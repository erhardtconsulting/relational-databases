---
title: "Benutzerverwaltung / Übung 4: Spaltenspezifische Berechtigungen"
author: 
    - Simon Erhardt
date: "25.04.2025"
keywords:
    - SQL
    - DCL
    - Column Permissions
    - Datenschutz
---

# Übung 4: Spaltenspezifische Berechtigungen

## Lernziele

In dieser Übung wirst du:
- Spaltenspezifische Berechtigungen für verschiedene Benutzergruppen konfigurieren
- Sensible Daten durch gezielte Zugriffskontrollen schützen
- Mit Views als Sicherheitsebene arbeiten
- Praktische Datenschutzkonzepte in Datenbanken umsetzen

## Aufgabenszenario

Die Vereinsdatenbank enthält personenbezogene Daten, die unterschiedlichen Schutzbedarf haben. Nicht alle Benutzer sollten auf alle Personendaten zugreifen können. In dieser Übung implementierst du ein Berechtigungskonzept, das den Datenschutz durch spaltenspezifische Berechtigungen gewährleistet.

## Teil 1: Berechtigungen auf Spaltenebene

### Aufgabe 1.1: Benutzer und Rollen erstellen
1. Erstelle folgende Benutzer mit Passwörtern:
   - `vorstand_user`: Ein Vorstandsmitglied, das alle Personendaten sehen darf
   - `kassier_user`: Ein Kassier, der finanzrelevante Daten sehen darf
   - `trainer_user`: Ein Trainer, der nur grundlegende Kontaktdaten sehen darf

2. Erstelle folgende Rollen ohne Loginberechtigung:
   - `vorstand_role`
   - `kassier_role`
   - `trainer_role`

3. Weise den Benutzern die entsprechenden Rollen zu.

```sql
-- Beispiellösung für Aufgabe 1.1:
CREATE USER vorstand_user WITH PASSWORD 'vorstand123';
CREATE USER kassier_user WITH PASSWORD 'kassier123';
CREATE USER trainer_user WITH PASSWORD 'trainer123';

CREATE ROLE vorstand_role NOLOGIN;
CREATE ROLE kassier_role NOLOGIN;
CREATE ROLE trainer_role NOLOGIN;

GRANT vorstand_role TO vorstand_user;
GRANT kassier_role TO kassier_user;
GRANT trainer_role TO trainer_user;
```

### Aufgabe 1.2: Spaltenspezifische Leserechte
1. Gewähre der Rolle `vorstand_role` Leserechte auf alle Spalten der Tabelle `person`.
2. Gewähre der Rolle `kassier_role` Leserechte nur auf die Spalten `PersID`, `Name`, `Vorname`, `StatID` (für Mitgliedsbeiträge) der Tabelle `person`.
3. Gewähre der Rolle `trainer_role` Leserechte nur auf die Spalten `PersID`, `Name`, `Vorname`, `Email`, `Telefon` der Tabelle `person`.

```sql
-- Beispiellösung für Aufgabe 1.2:
-- Vorstand: Voller Lesezugriff
GRANT SELECT ON TABLE person TO vorstand_role;

-- Kassier: Eingeschränkter Zugriff für Mitgliedsbeiträge
GRANT SELECT (PersID, Name, Vorname, StatID) ON TABLE person TO kassier_role;

-- Trainer: Nur Kontaktdaten
GRANT SELECT (PersID, Name, Vorname, Email, Telefon) ON TABLE person TO trainer_role;
```

### Aufgabe 1.3: Testen der Spaltenberechtigungen
Teste die konfigurierten Berechtigungen:

1. Verbinde dich als `vorstand_user` und führe eine SELECT * Abfrage auf die Tabelle `person` aus.
2. Verbinde dich als `kassier_user` und führe folgende Abfragen aus:
   - `SELECT PersID, Name, Vorname, StatID FROM person LIMIT 5;` (sollte funktionieren)
   - `SELECT * FROM person LIMIT 5;` (sollte teilweise fehlschlagen)
3. Verbinde dich als `trainer_user` und führe ähnliche Tests durch.

```sql
-- Als vorstand_user:
SELECT * FROM person LIMIT 5;

-- Als kassier_user:
SELECT PersID, Name, Vorname, StatID FROM person LIMIT 5;
SELECT * FROM person LIMIT 5; -- Sollte Fehler für nicht erlaubte Spalten geben

-- Als trainer_user:
SELECT PersID, Name, Vorname, Email, Telefon FROM person LIMIT 5;
SELECT Geburtsdatum FROM person LIMIT 5; -- Sollte fehlschlagen
```

## Teil 2: Berechtigungen für Aktualisierungen

### Aufgabe 2.1: Spaltenspezifische Schreibrechte
1. Gewähre der Rolle `vorstand_role` UPDATE-Rechte auf alle Spalten der Tabelle `person`.
2. Gewähre der Rolle `trainer_role` UPDATE-Rechte nur auf die Spalte `Telefon` der Tabelle `person`.
3. Der Kassier soll keine Änderungsrechte erhalten.

```sql
-- Beispiellösung für Aufgabe 2.1:
-- Vorstand: Volle Änderungsrechte
GRANT UPDATE ON TABLE person TO vorstand_role;

-- Trainer: Darf nur Telefonnummern aktualisieren
GRANT UPDATE (Telefon) ON TABLE person TO trainer_role;
```

### Aufgabe 2.2: Testen der Aktualisierungsrechte
Teste die konfigurierten UPDATE-Berechtigungen:

1. Als `vorstand_user`: Aktualisiere verschiedene Felder eines Datensatzes.
2. Als `trainer_user`: Versuche, die Telefonnummer zu aktualisieren (sollte funktionieren) und dann andere Felder (sollte fehlschlagen).
3. Als `kassier_user`: Versuche, Felder zu aktualisieren (sollte fehlschlagen).

```sql
-- Als vorstand_user:
UPDATE person SET Adresse = 'Neue Adresse 1', Email = 'neu@example.com' 
WHERE PersID = 1;

-- Als trainer_user:
UPDATE person SET Telefon = '123-456789' WHERE PersID = 1; -- Sollte funktionieren
UPDATE person SET Email = 'neu@example.com' WHERE PersID = 1; -- Sollte fehlschlagen

-- Als kassier_user:
UPDATE person SET StatID = 2 WHERE PersID = 1; -- Sollte fehlschlagen
```

## Teil 3: Views als Sicherheitsebene

### Aufgabe 3.1: Erstellen von sicheren Views
Erstelle drei Views für die unterschiedlichen Benutzergruppen:

1. `v_person_vorstand`: Alle Spalten der Tabelle `person`
2. `v_person_kassier`: Nur die für den Kassier relevanten Spalten
3. `v_person_trainer`: Nur die für den Trainer relevanten Spalten

```sql
-- Beispiellösung für Aufgabe 3.1:
CREATE VIEW v_person_vorstand AS 
SELECT * FROM person;

CREATE VIEW v_person_kassier AS 
SELECT PersID, Name, Vorname, StatID FROM person;

CREATE VIEW v_person_trainer AS 
SELECT PersID, Name, Vorname, Email, Telefon FROM person;
```

### Aufgabe 3.2: Berechtigungen auf Views
Konfiguriere die Berechtigungen für die Views:

1. Gewähre der Rolle `vorstand_role` Leserechte auf `v_person_vorstand`
2. Gewähre der Rolle `kassier_role` Leserechte auf `v_person_kassier`
3. Gewähre der Rolle `trainer_role` Leserechte auf `v_person_trainer`
4. Entziehe allen Rollen die direkten Leserechte auf die Tabelle `person`

```sql
-- Beispiellösung für Aufgabe 3.2:
-- Leserechte auf Views gewähren
GRANT SELECT ON v_person_vorstand TO vorstand_role;
GRANT SELECT ON v_person_kassier TO kassier_role;
GRANT SELECT ON v_person_trainer TO trainer_role;

-- Direkte Rechte auf person entziehen
REVOKE SELECT ON TABLE person FROM vorstand_role, kassier_role, trainer_role;
```

### Aufgabe 3.3: Testen der View-Berechtigungen
Teste die konfigurierten View-Berechtigungen:

1. Als verschiedene Benutzer auf die entsprechenden Views zugreifen
2. Versuche als Benutzer auf Views zuzugreifen, für die sie keine Berechtigung haben
3. Versuche als Benutzer direkt auf die Tabelle `person` zuzugreifen

```sql
-- Als vorstand_user:
SELECT * FROM v_person_vorstand LIMIT 5;
SELECT * FROM v_person_kassier LIMIT 5; -- Sollte fehlschlagen
SELECT * FROM person LIMIT 5; -- Sollte fehlschlagen

-- Ähnliche Tests für andere Benutzer
```

## Teil 4: Praxisnahes Datenschutzszenario

### Aufgabe 4.1: Datenschutzkonforme View
Erstelle eine View `v_person_anonym`, die für statistische Auswertungen genutzt werden kann. Diese View soll:
1. Das Geburtsdatum in Altersgruppen umwandeln (z.B. "18-25", "26-35", ...)
2. Die Postleitzahl auf die ersten zwei Ziffern kürzen (regionale Information behalten, aber keine genaue Lokalisierung)
3. Namen und andere identifizierende Merkmale komplett ausschliessen

```sql
-- Beispiellösung für Aufgabe 4.1:
CREATE VIEW v_person_anonym AS 
SELECT 
    -- Anonyme ID
    MD5(PersID::TEXT || 'salt') AS anonym_id,
    
    -- Altersgruppe statt genaues Alter
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(Geburtsdatum)) < 18 THEN 'unter 18'
        WHEN EXTRACT(YEAR FROM AGE(Geburtsdatum)) BETWEEN 18 AND 25 THEN '18-25'
        WHEN EXTRACT(YEAR FROM AGE(Geburtsdatum)) BETWEEN 26 AND 35 THEN '26-35'
        WHEN EXTRACT(YEAR FROM AGE(Geburtsdatum)) BETWEEN 36 AND 50 THEN '36-50'
        WHEN EXTRACT(YEAR FROM AGE(Geburtsdatum)) BETWEEN 51 AND 65 THEN '51-65'
        ELSE 'über 65'
    END AS altersgruppe,
    
    -- Regionsinfo statt genauer PLZ
    LEFT(PLZ, 2) || 'XX' AS region,
    
    -- Status beibehalten für statistische Zwecke
    StatID
FROM 
    person;
```

### Aufgabe 4.2: Berechtigungskonzept für Statistik
1. Erstelle eine neue Rolle `statistik_role` und einen Benutzer `statistik_user`
2. Gewähre diesem Benutzer Zugriff nur auf die anonymisierte View
3. Entwerfe eine Abfrage, die mit der anonymisierten View eine sinnvolle Statistik erstellt

```sql
-- Beispiellösung für Aufgabe 4.2:
CREATE ROLE statistik_role NOLOGIN;
CREATE USER statistik_user WITH PASSWORD 'stat123';
GRANT statistik_role TO statistik_user;

GRANT SELECT ON v_person_anonym TO statistik_role;

-- Als statistik_user:
-- Verteilung der Mitglieder nach Altersgruppen und Region
SELECT 
    altersgruppe, 
    region,
    COUNT(*) AS anzahl
FROM 
    v_person_anonym
GROUP BY 
    altersgruppe, region
ORDER BY 
    altersgruppe, region;
```

## Hinweise zur Bearbeitung

- Achte auf die korrekte GRANT-Syntax für spaltenspezifische Berechtigungen
- Teste alle Berechtigungen ausführlich aus verschiedenen Benutzerrollen heraus
- Beachte, dass einige Operationen möglicherweise Superuser-Rechte erfordern
- Dokumentiere alle Fehlermeldungen bei nicht erlaubten Operationen
- Views bieten eine zusätzliche Sicherheitsebene und können komplexere Berechtigungsszenarien abbilden
- Bei spaltenspezifischen UPDATE-Rechten müssen alle anderen Spalten in der SET-Klausel ausgeschlossen werden

## Zusatzaufgabe (optional)

Recherchiere und implementiere eine der folgenden Erweiterungen:
1. Row-Level Security (RLS) in PostgreSQL, um zeilenbasierte Zugriffskontrollen umzusetzen
2. Dynamische Maskierung von Daten für bestimmte Benutzergruppen
3. Eine hierarchische Berechtigungsstruktur mit erbenden Rollen für eine komplexe Organisation
