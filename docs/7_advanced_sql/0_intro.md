# Fortgeschrittenes SQL

In diesem Kapitel erweitern wir deine SQL-Kenntnisse um fortgeschrittene Konzepte, die für die Arbeit mit komplexen Datenbankstrukturen unerlässlich sind. Die Themen bauen auf den SQL-Grundlagen auf und ermöglichen dir, Datenbanken zu erstellen, komplexere Abfragen zu formulieren und aussagekräftige Datenanalysen durchzuführen.

Du wirst lernen, wie du mit der Data Definition Language (DDL) eigene Datenbankstrukturen erstellst, wie du durch verschiedene Join-Typen Daten aus mehreren Tabellen miteinander verknüpfst und wie du mit Aggregatfunktionen und Gruppierungen Daten zusammenfasst und analysierst.

```{mermaid}
graph TD
    A[Fortgeschrittenes SQL] --> B[Data Definition Language]
    B --> B1[CREATE TABLE und Datentypen]
    B --> B2[Constraints: PRIMARY KEY, FOREIGN KEY]
    B --> B3[ALTER TABLE, DROP TABLE]
    B --> B4[Implementierung von ER-Diagrammen]
    
    A --> C[Table Joins]
    C --> C1[INNER JOIN]
    C --> C2[LEFT und RIGHT JOIN]
    C --> C3[FULL JOIN]
    C --> C4[Mehrere Tabellen verknüpfen]
    
    A --> D[Aggregatfunktionen und Gruppierung]
    D --> D1[GROUP BY: Grundlagen]
    D --> D2[Aggregatfunktionen: COUNT, SUM, AVG, MIN, MAX]
    D --> D3[HAVING: Filterung von Gruppen]
    D --> D4[Komplexe Abfragen mit Joins und Gruppierung]
```

:::{important} Lernziele
Nach Abschluss dieses Kapitels wirst du:

- Die Grundkonzepte der Data Definition Language (DDL) verstehen und anwenden können
- Tabellen, Constraints und andere Datenbankobjekte mit SQL-DDL-Befehlen erstellen können
- Verschiedene Join-Typen (INNER, LEFT, RIGHT, FULL) unterscheiden und gezielt einsetzen können
- Daten mit GROUP BY aggregieren und mit HAVING-Klauseln filtern können
- Komplexe Abfragen über mehrere Tabellen der Verein-Datenbank formulieren können
:::

Diese fortgeschrittenen SQL-Konzepte werden dich in die Lage versetzen, fast alle Anforderungen in der Datenbankprogrammierung zu bewältigen. Die Kombination aus Data Definition Language, Joins und Aggregatfunktionen bildet das Herzstück der täglichen Arbeit mit relationalen Datenbanken.
