# Einrichtung der Lernumgebung

In diesem Kapitel lernst du, wie du deine lokale Entwicklungsumgebung für den Datenbankunterricht einrichtest. Wir werden zwei Hauptkomponenten installieren: DBeaver als Client-Tool für die Datenbankadministration und Podman (alternativ Docker) als Container-Runtime, um eine PostgreSQL-Datenbank zu betreiben. Diese standardisierte Umgebung stellt sicher, dass alle Studierenden mit der gleichen Datenbankstruktur arbeiten können, unabhängig vom verwendeten Betriebssystem.

```{mermaid}
graph TD
    A[Einrichtung Lernumgebung] --> B[DBeaver Installation]
    A --> C[Podman Installation]
    C --> D[Container starten]
    B --> E[Verbindung einrichten]
    D --> E
```

## Lernziele
Nach Abschluss dieses Kapitels solltest du:  
- DBeaver als Datenbank-Client installiert haben.  
- Podman als Container-Runtime eingerichtet haben.  
- Den Unterrichts-Container mit der PostgreSQL-Datenbank gestartet haben.  
- Eine Verbindung zwischen DBeaver und der Datenbank hergestellt haben.
