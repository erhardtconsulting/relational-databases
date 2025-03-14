# 2. Der Einfluss auf die Informatik und die Welt

## Historische Entwicklung von Datenbanksystemen

```{mermaid}
timeline
        1960 : Integrated Data Store (IDS) von Charles W. Bachman
             : Beginn der Ära der Navigationalen Datenbanken
             : IBM Information Management System (IMS) mit Hierarchisches Datenbankmodell
             : Einsatz von IMS bei der NASA für Saturn V Rakete

        1970 : E.F. Codd veröffentlicht Paper zum Relationalen Model "A Relational Model of Data for Large Shared Data Banks"
             : CODASYL präsentiert Standardentwurf
             : Formalisierung des Netzwerk-Datenbankmodells
             : IBM System R (Prototyp mit SQL) als erste Implementierung des relationalen Modells

        1980 : Siegeszug relationaler Datenbanken
             : Oracle, DB2, SQL Server dominieren den Markt
             : SQL wird ANSI-Standard
             : Standardisierung relationaler Datenbankabfragen

        2000 : Aufkommen der NoSQL-Bewegung, als Antwort auf Skalierungsprobleme relationaler DBs
             : Google veröffentlicht BigTable-Paper
             : Tim Berners-Lee präsentiert Vision von "Linked Data", Grundlagen für spaltenorientierte und Graph-Datenbanken

        2010 : Diversifizierung der NoSQL-Landschaft duch Key-Value Stores, Dokumenten-DBs, Graph-DBs, Column Stores
             : Vektor- und Blockchain-Datenbanken
             : Spezialisierte Lösungen für KI und verteilte Anwendungen
```

Die Einführung von Datenbanksystemen revolutionierte die Art und Weise, wie mit Daten umgegangen wird, und hatte tiefgreifende Auswirkungen auf Informatik und Gesellschaft. Vor der Verfügbarkeit von DBMS wurden Daten meist in einzelnen Dateien oder auf Lochkarten verwaltet; sie galten als Nebenprodukt von Programmen und nicht als zentrales Gut {cite}`dataversity_history`. Mit den ersten Datenbanksystemen änderte sich dies grundlegend: Daten rückten ins Zentrum. Unternehmen und Behörden erkannten schnell den Wert einer zentralen Datenverwaltung. Plötzlich konnten *mehrere Benutzer gleichzeitig* auf gemeinsame Datenbestände zugreifen, ohne sich gegenseitig zu behindern – eine Voraussetzung für moderne Informationssysteme in Banken, Versicherungen, Behörden oder Krankenhäusern.

Wesentliche Vorteile von Datenbanksystemen gegenüber der traditionellen Dateiablage waren: geringere Redundanz, höhere Konsistenz und einfacherer Datenzugriff. Daten mussten nicht mehr in zig Kopien in verschiedenen Dateien gehalten werden, was Inkonsistenzen reduzierte. Zugriffsrechte und Sicherheitsmechanismen im DBMS verbesserten den Schutz sensibler Informationen. Ausserdem konnte man komplexe Anfragen an die Daten stellen, ohne jedes Detail der physischen Speicherung zu kennen – das DBMS übernahm die Aufgabe, die passenden Daten herauszusuchen. Diese Trennung von logischern Datenblick und physischer Speicherung war ein entscheidender Fortschritt.

Ein greifbares Beispiel für den Einfluss von Datenbanken ist das Bankwesen: Bereits in den 1970er-Jahren begannen Banken, ihre Kontodaten in Datenbanksystemen zu führen, um Echtzeit-Abfragen wie Kontostände oder Transaktionshistorien zu ermöglichen. Weltweit wurden kritische Infrastrukturen auf Datenbanken aufgebaut. So vertrauten etwa Flugbuchungssysteme, Warenwirtschaft in Unternehmen und staatliche Melderegister zunehmend auf DBMS. IBMs IMS, obwohl ein Kind der 60er, wickelt bis heute einen Grossteil des weltweiten Bankgeschäfts im Hintergrund ab – *über 95 % der Fortune-1000-Unternehmen nutzen IMS noch in irgendeiner Form, einschliesslich aller fünf grössten US-Banken* {cite}`twobithistory_ims`. Dieser Befund verdeutlicht, wie fundamental die Zuverlässigkeit und Leistungsfähigkeit von Datenbanksystemen für die Weltwirtschaft sind. Ohne Datenbanken wären moderne Anwendungen – von sozialen Netzwerken über Online-Shops bis hin zur wissenschaftlichen Datenanalyse – in ihrer heutigen Form nicht denkbar.
