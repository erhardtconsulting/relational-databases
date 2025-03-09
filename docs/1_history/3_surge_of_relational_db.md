# 3. Der Aufstieg relationaler Datenbanken

Anfang der 1970er-Jahre zeichnete sich ein Paradigmenwechsel ab: Weg von den schwerfälligen navigationalen Datenbanken hin zu einem flexibleren, mathematisch fundierten Modell – dem relationalen Datenbankmodell. 1970 veröffentlichte Edgar F. Codd, ein Informatiker bei IBM, ein bahnbrechendes Papier mit dem Titel *"A Relational Model of Data for Large Shared Data Banks"* {cite}`codd_relational`. Darin schlug er vor, Daten in Form von relationalen Tabellen zu organisieren, die durch mathematische Beziehungen (Relationen) miteinander verknüpft sind {cite}`dataversity_history`. Anstatt wie bisher über Zeiger von Datensatz zu Datensatz zu springen, konnten Anfragen nun *deklariert* werden: Man gibt an, was man finden will (z.B. „alle Kunden aus Stadt X mit Kontostand > Y"), und das System ermittelt die Ergebnisse, ohne dass der Benutzer die Navigationsschritte vorgeben muss.

```{mermaid}
erDiagram
    KUNDE {
        int KundenID PK
        string Name
        string Email
        string Stadt
    }
    BESTELLUNG {
        int BestellID PK
        int KundenID FK
        date Datum
        decimal Gesamtbetrag
    }
    PRODUKT {
        int ProduktID PK
        string Name
        decimal Preis
        int Lagerbestand
    }
    BESTELLPOSITION {
        int BestellID PK,FK
        int ProduktID PK,FK
        int Menge
        decimal Einzelpreis
    }
    
    KUNDE ||--o{ BESTELLUNG : "tätigt"
    BESTELLUNG ||--o{ BESTELLPOSITION : "enthält"
    PRODUKT ||--o{ BESTELLPOSITION : "ist Teil von"
```

## Gründe für den Erfolg des relationalen Modells  
Das relationale Modell setzte sich aus mehreren Gründen sehr schnell als dominierende Technologie durch:

- Einfachere Datenabfragen durch SQL: Für relationale Datenbanken wurde die Abfragesprache SQL (Structured Query Language) entwickelt. SQL ermöglichte es, mit vergleichsweise einfachen, englischähnlichen Anweisungen komplexe Fragen an die Daten zu stellen. IBM entwickelte in den 1970ern im Forschungsprojekt *System R* einen Prototyp, der SQL erstmals implementierte {cite}`dataversity_history`. 1986 wurde SQL zum ANSI-Standard erklärt {cite}`dataversity_history`, was die Portabilität von Anwendungen über verschiedene Datenbanksysteme hinweg sicherstellte. Die Standardisierung machte SQL zur weltweit einheitlichen Sprache für Datenbankabfragen und trug massgeblich zur Verbreitung relationaler Systeme in Unternehmen bei.

- Strukturierung und Ad-hoc-Abfragen: Relationale Datenbanken organisieren Daten in Tabellenform (Relationen), mit Zeilen (Tupel) und Spalten (Attribute). Dieses tabellarische Format entspricht intuitiv vielen Anwendungsfällen (z.B. Kundenlisten, Produktkataloge) und erlaubt es, Daten flexibel zu kombinieren. Relationale Systeme können mittels Joins Daten aus mehreren Tabellen dynamisch verknüpfen, was zuvor in hierarchischen/netzwerkbasierten Systemen nur umständlich oder gar nicht möglich war. Dadurch konnten Nutzer spontan Ad-hoc-Abfragen formulieren, ohne die Datenstruktur im Voraus komplett kennen zu müssen.

- Das ACID-Prinzip für Transaktionen: Relationale DBMS implementierten frühzeitig strenge Garantien für die Korrektheit von Transaktionen. Diese werden durch die ACID-Eigenschaften beschrieben: *Atomicity, Consistency, Isolation, Durability* (Atomarität, Konsistenz, Isolation, Dauerhaftigkeit). Vereinfacht bedeutet das: Jede Transaktion wird vollständig oder gar nicht ausgeführt; der Datenbestand bleibt stets in einem konsistenten Zustand; gleichzeitig ablaufende Transaktionen beeinflussen sich nicht gegenseitig; und einmal bestätigte Änderungen gehen auch bei Systemausfällen nicht verloren {cite}`metisdata_acid`. Diese Eigenschaften sorgen für hohe Zuverlässigkeit und Datenintegrität in Mehrbenutzerumgebungen – ein entscheidender Vorteil für kritische Anwendungen in Wirtschaft und Verwaltung. Mit ACID-garantierten Transaktionen konnten Unternehmen darauf vertrauen, dass z.B. Banküberweisungen oder Bestellvorgänge korrekt und vollständig gespeichert werden. Diese Verlässlichkeit war ein wichtiges Argument für den Siegeszug relationaler Systeme {cite}`dataversity_history`.

- Performance und Skalierbarkeit: Obwohl frühe Skeptiker bezweifelten, dass ein so abstraktes System performant sein könnte, bewiesen Forschungsprojekte wie *INGRES* an der UC Berkeley, dass relationale DBMS effizient arbeiten können {cite}`dataversity_history`. Schon in den 1980er-Jahren erreichten relationale Systeme dank Optimierungstechniken (Indexierung, ausgeklügelte Abfrageoptimierer etc.) eine Performance, die die älteren Systeme übertraf. Mit dem Aufkommen immer leistungsfähigerer Hardware wuchsen relationale Datenbanken zudem in ihrer Skalierbarkeit, d.h. sie konnten immer grössere Datenmengen und Nutzerzahlen handhaben.

Durch diese Vorteile verdrängten relationale Datenbanken bis Mitte der 1980er die vorherigen Modelle nahezu vollständig im Neumarkt. Navigationale Systeme wie CODASYL wurden kaum noch weiterentwickelt. Grosse Softwareanbieter wie IBM (DB2), Oracle, Microsoft (SQL Server) und Sybase brachten kommerzielle relationale DBMS auf den Markt, die in Unternehmen zum Standard wurden. 1984 erhielt Codd für seine Arbeiten den Turing Award – die höchste Auszeichnung in der Informatik – was die Bedeutung des relationalen Modells unterstreicht. Bis in die 2000er-Jahre hinein galten relationale Datenbanksysteme (RDBMS) als quasi alternativlos für die meisten Datenhaltungsbedürfnisse. Sie bildeten das Fundament für betriebliche Informationssysteme, Webanwendungen und Datenanalysen weltweit.
