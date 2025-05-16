# Object-Relational Mapping (ORM)

Die meisten modernen Anwendungen sind objektorientiert aufgebaut, während die Daten in relationalen Datenbanken gespeichert werden. Diese grundlegende Diskrepanz zwischen objektorientierter Programmierung und relationalen Datenbanken - bekannt als "Object-Relational Impedance Mismatch" - stellt Entwickler vor eine besondere Herausforderung: Wie überbrückt man die konzeptionelle Lücke zwischen Objekten in der Anwendung und Tabellen in der Datenbank effizient?

Object-Relational Mapping (ORM) ist die Antwort auf diese Herausforderung. ORMs bieten eine Abstraktionsschicht zwischen dem Anwendungscode und der relationalen Datenbank, die es ermöglicht, mit Daten in Form von Objekten zu arbeiten, anstatt SQL-Abfragen manuell zu schreiben.

:::{important} Lernziele
Nach Abschluss dieses Kapitels wirst du:
- Das Konzept und die Grundprinzipien von Object-Relational Mapping verstehen
- Die Vor- und Nachteile von ORMs im Vergleich zu direktem SQL-Zugriff beurteilen können
- Grundlegende Mapping-Strategien zwischen Objekten und Datenbanktabellen kennen
- Die Rolle von ORM-Frameworks in modernen Anwendungen einordnen können
- Die Bedeutung von Schemaversionierung in datenbankbasierten Anwendungen erfassen
- Wissen, wann ORMs an ihre Grenzen stossen und direktes SQL die bessere Wahl ist
:::

## Warum sind ORMs für Entwickler relevant?

Als Softwareentwickler stehst du häufig vor der Herausforderung, deine objektorientierten Anwendungen mit relationalen Datenbanken zu verbinden. Ohne geeignete Abstraktionen müsstest du:

- SQL-Abfragen manuell schreiben und in deinen Code einbetten
- Die Ergebnisse dieser Abfragen selbst in Objekte umwandeln
- Änderungen an Objekten zurück in SQL-UPDATE-Anweisungen transformieren
- Beziehungen zwischen Objekten manuell durch JOINs oder mehrere Abfragen abbilden

Dieser Ansatz ist fehleranfällig und erhöht den Wartungsaufwand erheblich. Jede Änderung am Datenbankschema erfordert entsprechende Anpassungen im Code, und das Management komplexer Beziehungen zwischen Objekten wird schnell unübersichtlich.

Object-Relational Mapper lösen diese Probleme, indem sie eine strukturierte Brücke zwischen der objektorientierten und der relationalen Welt schaffen. Sie ermöglichen es dir, dich auf die Geschäftslogik deiner Anwendung zu konzentrieren, während sich das ORM um die Datenpersistenz kümmert.

In diesem Kapitel werden wir die grundlegenden Konzepte und Prinzipien von ORMs betrachten und anhand von repräsentativen Beispielen aus Java und Python veranschaulichen. Du wirst lernen, wann der Einsatz eines ORMs sinnvoll ist und wann du besser auf direktes SQL zurückgreifen solltest.

Besonders wichtig wird dabei die Betrachtung der Schemaversionierung sein - ein oft übersehener, aber kritischer Aspekt in der professionellen Softwareentwicklung mit Datenbanken. Wir werden erklären, warum eine kontrollierte Verwaltung von Datenbankschemas in professionellen Umgebungen dem automatischen Schema-Management durch ORMs vorzuziehen ist.
