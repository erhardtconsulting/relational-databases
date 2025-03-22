# ACID und Transaktionen

In diesem Kapitel tauchen wir in die Welt der relationalen Datenbanken und ihr grundlegendes Funktionsprinzip ein: das ACID-Paradigma und Transaktionen. Diese Konzepte bilden das Fundament für zuverlässige Datenbanksysteme und sind entscheidend, um die Datenintegrität zu gewährleisten – selbst in Situationen mit gleichzeitigem Zugriff mehrerer Benutzer oder bei unerwarteten Systemausfällen.

Wir werden die historischen Ursprünge dieser Konzepte betrachten, die einzelnen ACID-Eigenschaften im Detail verstehen und lernen, wie Transaktionen in der Praxis funktionieren und gesteuert werden. Dieses Wissen ist für jeden Datenbankentwickler unerlässlich und bildet die Grundlage für die Konzeption robuster Datenbankanwendungen.

```{mermaid}
graph TD
    A[ACID & Transaktionen] --> B[Ursprünge & Gründe]
    A --> C[ACID-Eigenschaften]
    C --> C1[Atomarität]
    C --> C2[Konsistenz]
    C --> C3[Isolation]
    C --> C4[Dauerhaftigkeit]
    A --> D[Transaktionen in der Praxis]
    D --> D1[Lebenszyklus]
    D --> D2[SQL-Steuerung]
    D --> D3[Isolationsebenen]
    A --> E[Herausforderungen]
    A --> F[Praktische Übungen]
```

:::{important} Lernziele
Nach Abschluss dieses Kapitels wirst du:

- Die Bedeutung und historischen Ursprünge des ACID-Paradigmas verstehen
- Die vier ACID-Eigenschaften (Atomarität, Konsistenz, Isolation, Dauerhaftigkeit) erklären können
- Die Rolle von Transaktionen für die Datenintegrität nachvollziehen
- Transaktionen in SQL definieren und steuern können
- Isolationsebenen und deren Auswirkungen auf Nebenläufigkeit verstehen
- Typische Probleme wie Deadlocks identifizieren und Lösungsstrategien kennen
- Praktische Erfahrung mit Transaktionen in PostgreSQL gesammelt haben
:::
