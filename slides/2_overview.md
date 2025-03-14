---
theme: hftm
footer: 'Übersicht über relationale Datenbanksysteme'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>Relationale Datenbanksysteme</h1>
  <p class="date-author">März 2025 | Autor: Simon Erhardt</p>
</div>

---
# Inhaltsverzeichnis
<!--
- Hilft den Studierenden beim Überblick
-->
1. Einführung in relationale DBMS
2. PostgreSQL
3. MySQL/MariaDB
4. Oracle
5. Microsoft SQL Server
6. SQLite
7. Warum PostgreSQL im Unterricht?
8. Fazit

---
# Einführung in relationale DBMS
<!--
- Kurzer Überblick
-->
- Vielfalt an Systemen für unterschiedliche Anforderungen
- Unterschiede: Lizenzmodelle, Funktionsumfang, Performance
- Auswahlkriterien projektabhängig

---
# Lernziele
<!--
- Klare Ziele
-->
- Wichtigste DBMS kennenlernen
- Geschichte und Merkmale verstehen
- Vor-/Nachteile einschätzen
- Auswahlkriterien anwenden können

---
# PostgreSQL
<!--
- Kernpunkte
-->
- **Ursprung**: UC Berkeley, 1980er ("POST-Ingres")
- **Fokus**: Erweiterbarkeit, Open-Source, aktive Community
- **Stärken**: Komplexe Anwendungen, parallele Zugriffe
- **Features**: 
  - ACID-konform
  - JSON, Geodaten
  - Window-Funktionen, Common Table Expressions (CTEs)

---
# PostgreSQL: Vor-/Nachteile
<!--
- Tabelle prägnant halten
-->
| **Vorteile** | **Nachteile** |
|--------------|---------------|
| Open-Source, große Community | Für kleine Projekte überdimensioniert |
| Hohe Erweiterbarkeit | Weniger kommerzieller Support |
| Sehr standardkonform | |

---
# PostgreSQL: Einsatz
<!--
- Klare Anwendungsfälle
-->
- **Ideal für**:
  - Komplexe Datenstrukturen
  - Große Datenmengen
  - Hohe Datenintegrität
  - Viele parallele Transaktionen

- **Nicht für**:
  - Simple Datenverwaltung
  - Ressourcenknappe Kleinprojekte

---
# MySQL/MariaDB
<!--
- Kernpunkte zur Unterscheidung
-->
- **Ursprung**: 1990er, Michael Widenius (Tochter "My")
- **Abspaltung**: MariaDB nach Oracle-Übernahme (2010)
- **Unterschied**:
  - MySQL: Oracle, duales Lizenzmodell
  - MariaDB: Freie Alternative, API-kompatibel
- **Typisch für**: 
  - PHP-Webprojekte (WordPress, Drupal)
  - Kleine/mittlere Anwendungen

---
# MySQL/MariaDB: Vor-/Nachteile
<!--
- Kurz und knapp
-->
| **Vorteile** | **Nachteile** |
|--------------|---------------|
| Einsteigerfreundlich | Lizenzproblematik (MySQL) |
| Verbreitet bei Hostern | Weniger Funktionsumfang |

---
# MySQL/MariaDB: Einsatz
<!--
- Klare Anwendungsfälle
-->
- **Ideal für**:
  - Webprojekte mit begrenzten Ressourcen
  - CMS-Systeme, Blogs
  - Schnelle Einrichtung

- **Nicht für**:
  - Hochskalierbare Systeme
  - Komplexe Analytik
  - Höchste Transaktionssicherheit

---
# Oracle
<!--
- Enterprise-Fokus
-->
- **Ursprung**: 1970er, Ellison, Miner, Oates
- **Name**: Angeblich CIA-Projektbezug
- **Markt**: Enterprise-Segment
- **Typisch für**:
  - Banken, Versicherungen, Telekom
  - Höchste Performance-Anforderungen
- **Besonderheiten**:
  - Enterprise-Features (Data Guard, RAC)
  - Extreme Skalierbarkeit

---
# Oracle: Vor-/Nachteile
<!--
- Kurz und klar
-->
| **Vorteile** | **Nachteile** |
|--------------|---------------|
| Top-Support weltweit | Sehr hohe Kosten |
| Ausgereifte Hochverfügbarkeit | Komplex und ressourcenhungrig |
| Enterprise-Standard | |

---
# Oracle: Einsatz
<!--
- Prägnante Einsatzfälle
-->
- **Ideal für**:
  - Höchste Ausfallsicherheit
  - Banken/Versicherungen
  - Globalen Support

- **Nicht für**:
  - Budget-Projekte
  - Einfache Anwendungen
  - Kleine Teams

---
# Microsoft SQL Server
<!--
- Microsoft-Kontext
-->
- **Ursprung**: 1989, Sybase-Technologie
- **Besonderheit**: Windows-Integration
- **Typisch für**:
  - Windows-Server
  - .NET-Projekte
  - BI-Lösungen
- **Features**:
  - Microsoft-Produktintegration
  - Power BI, Azure, ML-Services

---
# MSSQL: Vor-/Nachteile
<!--
- Kurz und klar
-->
| **Vorteile** | **Nachteile** |
|--------------|---------------|
| Exzellente Dokumentation | Teures Lizenzmodell |
| Stark in Windows-Umgebungen | Selten außerhalb Microsoft-Welt |
| Azure/Power BI-Integration | |

---
# MSSQL: Einsatz
<!--
- Klare Anwendungsfälle
-->
- **Ideal für**:
  - Microsoft-Umgebungen
  - .NET/Windows/Azure-Stack
  - BI-Analytik

- **Nicht für**:
  - Linux/Container-Fokus
  - Budget-Projekte
  - OpenSource-Präferenz

---
# SQLite
<!--
- Leichtgewichtigkeit betonen
-->
- **Ursprung**: D. Richard Hipp
- **Besonderheit**: Serverlos, Eine-Datei-DB
- **Verbreitung**: Versteckt in vielen Produkten
- **Typisch für**:
  - Mobile Apps
  - Desktop-Programme
  - Embedded-Systeme
- **Features**:
  - Zero-Setup
  - Minimaler Ressourcenverbrauch

---
# SQLite: Vor-/Nachteile
<!--
- Kurz und präzise
-->
| **Vorteile** | **Nachteile** |
|--------------|---------------|
| Einfache Handhabung | Begrenzte Mehrbenutzer-Fähigkeit |
| Wartungsarm | Kaum skalierbar |
| Portabilität (1 Datei) | |

---
# SQLite: Einsatz
<!--
- Klare Anwendungsfälle
-->
- **Ideal für**:
  - Mobile Anwendungen
  - Embedded-Geräte
  - Kleine Desktop-Tools
  - Prototypentwicklung

- **Nicht für**:
  - Mehrbenutzer-Umgebungen
  - Hochskalierbare Systeme
  - Enterprise-Anwendungen

---
# Warum PostgreSQL im Unterricht?
<!--
- Begründung für Kursfokus
-->
- Open-Source: Keine Lizenzeinschränkungen
- Breiter Funktionsumfang für Lernzwecke
- Hohe Zuverlässigkeit und Stabilität
- Praxisrelevante Features für reale Projekte
- Aktive Community und gute Dokumentation

---
# Fazit
<!--
- Zusammenfassung und Abschluss
-->
- Verschiedene DBMS für unterschiedliche Anforderungen
- Auswahl basierend auf:
  - Projektgröße und -komplexität
  - Budget und Umgebung
  - Entwicklungs-Stack
  - Performanceanforderungen
- PostgreSQL als idealer Kompromiss für Unterricht:
  - Kostenfrei mit Enterprise-Features
  - Starke Community
  - Zukunftssicher
