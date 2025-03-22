# SQL-Grundlagen

In diesem Kapitel tauchen wir in die grundlegenden Funktionen der Structured Query Language (SQL) ein – der Standardsprache für die Kommunikation mit relationalen Datenbanken. SQL ist das Werkzeug, mit dem du deine in der Datenbank gespeicherten Informationen abfragen, manipulieren und verwalten kannst.

Egal ob du eine einfache Abfrage durchführst oder komplexe Datenmanipulationen vornimmst, ein solides Verständnis der SQL-Grundlagen ist unverzichtbar für jeden Datenbankentwickler. Diese Fähigkeiten bilden das Fundament, auf dem du später aufbauen wirst, wenn du komplexere Datenbankoperationen durchführst.

```{mermaid}
graph TD
    A[SQL-Grundlagen] --> B[SQL-Datentypen]
    B --> B1[Texte: CHAR, VARCHAR, TEXT]
    B --> B2[Zahlen: INTEGER, NUMERIC]
    B --> B3[Datum/Zeit: DATE, TIME, TIMESTAMP]
    B --> B4[Weitere: UUID, SERIAL, BOOLEAN]
    
    A --> C[Daten abfragen: SELECT]
    C --> C1[Grundlagen und WHERE]
    C --> C2[Sortierung: ORDER BY]
    C --> C3[Begrenzung: LIMIT]
    C --> C4[Aggregatfunktionen]
    C --> C5[Gruppierung: GROUP BY, HAVING]
    
    A --> D[Daten verändern]
    D --> D1[Einfügen: INSERT INTO]
    D --> D2[Aktualisieren: UPDATE]
    D --> D3[Löschen: DELETE]
    
    A --> E[Praxisbeispiele]
```

:::{important} Lernziele
Nach Abschluss dieses Kapitels wirst du:

- Die wichtigsten SQL-Datentypen und ihre Anwendungsbereiche verstehen
- Grundlegende SELECT-Abfragen formulieren können, um Daten gezielt abzurufen
- Daten nach verschiedenen Kriterien filtern und sortieren können
- Aggregatfunktionen wie COUNT, SUM, AVG anwenden können
- Daten mit GROUP BY gruppieren und mit HAVING filtern können
- Neue Datensätze mit INSERT INTO einfügen können
- Bestehende Daten mit UPDATE aktualisieren können
- Datensätze mit DELETE entfernen können
- Praktische Erfahrung mit SQL-Befehlen in PostgreSQL gesammelt haben

Dieses Kapitel konzentriert sich auf die Grundlagen. Fortgeschrittene Konzepte wie Joins, Unterabfragen und Optimierungstechniken werden in späteren Kapiteln behandelt.
:::
