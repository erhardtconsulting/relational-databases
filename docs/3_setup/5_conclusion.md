# Zusammenfassung

In diesem Kapitel hast du deine persönliche Entwicklungsumgebung für den Datenbankunterricht eingerichtet. Hier ist eine Zusammenfassung der Hauptschritte:

1. **DBeaver installiert** – Du verfügst nun über einen leistungsfähigen und universellen Datenbank-Client, mit dem du verschiedene Datenbanktypen verwalten kannst.

2. **Podman eingerichtet** – Mit dieser Container-Runtime kannst du isolierte Umgebungen für deine Datenbankserver betreiben, ohne dein Hauptsystem zu beeinflussen und ohne Root-Rechte zu benötigen.

3. **PostgreSQL-Container gestartet** – Der vorbereitete Container enthält eine vollständige PostgreSQL-Datenbank mit dem Schema und den Daten, die wir im Unterricht verwenden.

4. **Datenbankverbindung hergestellt** – DBeaver ist nun mit der Datenbank verbunden, sodass du SQL-Abfragen ausführen und mit den Tabellen interagieren kannst.

```{mermaid}
flowchart LR
    A[DBeaver Client] <--> B{Port 5432}
    B <--> C[Container: PostgreSQL]
    C --- D[(Datenbank: verein)]
```

## Nächste Schritte

Mit dieser Grundkonfiguration bist du nun bereit, die folgenden Schritte umzusetzen:

- **SQL-Grundlagen erlernen** – Die folgenden Kapitel führen dich in die SQL-Syntax ein, beginnend mit einfachen SELECT-Abfragen bis hin zu komplexeren JOIN-Operationen.

- **Datenbankmodellierung verstehen** – Du wirst lernen, wie die Tabellen in der Vereinsdatenbank strukturiert sind und wie du selbst effiziente Datenbankmodelle erstellen kannst.

- **Eigene Daten verwalten** – Mit den erworbenen Kenntnissen kannst du Daten hinzufügen, ändern, abfragen und löschen.

## Wichtige Befehle im Überblick

Hier sind die wichtigsten Befehle, die du für die Verwaltung des Containers benötigen wirst:

| Zweck | Podman-Befehl |
|-------|--------------|
| Container starten | `podman start db-unterricht` |
| Container stoppen | `podman stop db-unterricht` |
| Status prüfen | `podman ps` |
| Container löschen | `podman rm db-unterricht` |
| Container-Logs anzeigen | `podman logs db-unterricht` |

> **Hinweis**: Solltest du Docker statt Podman verwenden, sind die Befehle identisch - ersetze einfach `podman` durch `docker`.

## Fazit

Mit der eingerichteten Umgebung hast du nun die grundlegende Infrastruktur, um die PostgreSQL-Datenbank zu nutzen und SQL-Abfragen auszuführen. Diese Konfiguration bietet eine konsistente und reproduzierbare Arbeitsumgebung, die es dir ermöglicht, dich auf das Erlernen von Datenbankkonzepten zu konzentrieren, ohne dich mit komplexen Installationsprozessen auseinandersetzen zu müssen.

Der Einsatz von Podman als moderne, rootless Container-Technologie stellt sicher, dass alle Kursteilnehmer mit der gleichen Datenbankstruktur und den gleichen Daten arbeiten können, ohne Kompromisse bei der Sicherheit einzugehen. Dies erleichtert die Zusammenarbeit und den Austausch von Lösungen im Unterricht.
