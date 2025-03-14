# PostgreSQL
[PostgreSQL](https://www.postgresql.org/) hat seine Wurzeln im POSTGRES-Projekt an der University of California, Berkeley. Seit den 1980er-Jahren entwickelte es sich kontinuierlich weiter. Heute gilt es als eines der fortschrittlichsten Open-Source-Datenbankmanagementsysteme und wird von einer aktiven Community gepflegt {cite}`postgresql_official`.

## Historischer Hintergrund
PostgreSQL entstand aus dem Bedürfnis, die Grenzen älterer relationaler Systeme wie [Ingres](https://de.wikipedia.org/wiki/Ingres_(Datenbanksystem)) zu überwinden. Es wurde entwickelt, um Forschenden und Unternehmen eine erweiterbare, leistungsfähige Datenbank mit modularem Ansatz zu liefern. Der ursprüngliche Name POSTGRES geht auf «POST-Ingres» zurück, was verdeutlichen sollte, dass hier auf Basis der Erfahrungen mit Ingres ein neues Kapitel aufgeschlagen werden sollte. Dieser Fokus auf Forschung und Erweiterbarkeit machte PostgreSQL schon früh flexibel und zukunftsorientiert.

## Einsatzgebiete 
- Geeignet für komplexe Anwendungen mit vielen gleichzeitigen Nutzeranfragen  
- Starke Unterstützung für erweiterte Datentypen (z.B. JSON, Geodaten)  
- Häufig verwendet in Hochschul-Projekten sowie mittelgrossen und grossen Unternehmenseinsätzen  

## Alleinstellungsmerkmale
- ACID-konform (Atomicity, Consistency, Isolation, Durability)  
- Support für fortgeschrittene Funktionen wie Window-Funktionen, Common Table Expressions (CTEs), Stored Procedures in verschiedenen Sprachen  

## Vor- und Nachteile
| Vorteile                                          | Nachteile                                                                                                 |
| ------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |  
| Grosse Community, Open-Source, keine Lizenzkosten | Für simplere Projekte mit geringem Datenaufkommen kann die Einrichtung zu komplex sein                    |
| Erweiterbar mit vielen Modulen und Plugins        | Bei sehr spezifischen Anforderungen teilweise weniger kommerzieller Support als bei proprietären Lösungen |
| Hohe Stabilität, sehr standardkonform             |                                                                                                           |

## Wann einsetzen und wann nicht

### Geeignet, wenn
- Ideal für Projekte mit komplexen Datenstrukturen, grossen Datenmengen und hohen Anforderungen an Datenintegrität.  
- Passend, wenn viele gleichzeitige Transaktionen und hohe Skalierbarkeit benötigt werden.

### Nicht geeignet, wenn  
- Nur eine sehr einfache Datenverwaltung ohne grossen Funktionsumfang und ohne hohe Performance-Anforderungen benötigt wird.  
- Ressourcen in sehr kleinen Projekten knapp sind und der Administrationsaufwand minimal bleiben soll.
