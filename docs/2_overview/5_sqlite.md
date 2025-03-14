# SQLite
[SQLite](https://sqlite.org/) wurde von D. Richard Hipp entwickelt und ist eine serverlose, dateibasierte Datenbank {cite}`sqlite_official`. Sie ist extrem leichtgewichtig und wird oft in eingebetteten Systemen eingesetzt.

## Historischer Hintergrund
SQLite entstand aus dem Bedarf, eine ultraleichte, serverlose Datenbank zu entwickeln, die ohne komplexe Installation auskommt. D. Richard Hipp wählte bewusst diesen Ansatz, um eine zuverlässige, aber ressourcensparende Technologie zu liefern, insbesondere für eingebettete Geräte. Ein spannender Fakt: SQLite wird in sehr vielen Produkten genutzt, darunter in Betriebssystemen, Webbrowsern und gängigen Softwareanwendungen, oft ohne dass sich die Nutzenden dessen bewusst sind.

## Einsatzgebiete

- Mobile Apps (z.B. iOS, Android)  
- Desktop-Anwendungen und kleinere Projekte  
- Ersetzen komplexer Datei-Formate durch eine integrierte Datenbank  

## Alleinstellungsmerkmale

- Keine Installation eines separaten Datenbankservers nötig  
- Sehr geringer Speicherbedarf und ressourcenschonend  

## Vor- und Nachteile

| Vorteile                                                              | Nachteile                                                                     |
|-----------------------------------------------------------------------| ------------------------------------------------------------------------------|
| - Ideal für prototypische Entwicklung und kleine Projekte             | - Keine zentrale Server-Architektur, daher limitiert in Mehrnutzer-Umgebungen |
| - Einfache Datensicherung und -wiederherstellung (eine einzige Datei) | - Fehlende umfangreiche Skalierbarkeit                                        |

## Wann einsetzen und wann nicht

### Geeignet, wenn
- Man eine sehr schlanke und wartungsarme Datenbanklösung sucht, in der nur wenige Clients gleichzeitig zugreifen müssen.  
- Optimal für den Einsatz in mobilen Apps, eingebetteten Geräten oder kleinen Desktop-Tools.

### Nicht geeignet, wenn  
- Komplexe Berechtigungsmodelle, hochskalierbare Cluster oder umfangreiche Mehrbenutzerfunktionen benötigt werden.  
- Ein zentraler Server für das Datenmanagement verpflichtend ist, z.B. in grossen Unternehmensumgebungen mit vielen gleichzeitigen Zugriffen.
