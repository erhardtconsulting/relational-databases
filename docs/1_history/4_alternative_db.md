# 4. Alternative Datenbankmodelle (NoSQL) 

Mit dem Aufkommen des Web 2.0, rasant wachsender Datenmengen und neuer Anforderungsszenarien stiessen relationale Datenbanken ab etwa Mitte der 2000er an Grenzen ihrer Flexibilität und Leistung. Dies führte zur NoSQL-Bewegung („Not only SQL"), die alternative Datenbankmodelle propagierte. NoSQL-Datenbanken verzichten oft auf das starre tabellarische Schema und die ACID-Garantien zugunsten von Horizontale Skalierbarkeit, hoher Geschwindigkeit und flexiblen Datenschemata. Es entstanden verschiedene Kategorien von NoSQL-Datenbanken, von denen die wichtigsten hier vorgestellt werden.

## Dokumentenorientierte Datenbanken
Dokumenten-Datenbanken speichern Daten in semi-strukturierten Dokumenten, meist im JSON- oder XML-Format. Jedes Dokument enthält alle Informationen zu einem Objekt, ähnlich wie ein Datensatz, kann aber intern auch geschachtelte Strukturen aufweisen. Im Gegensatz zur relationalen Tabelle können Dokumente unterschiedliche Felder besitzen – es gibt kein starres Schema, das alle Einträge einhalten müssen. Dies ermöglicht eine grosse Flexibilität: Die Datensätze (Dokumente) können sich im Laufe der Zeit ändern, ohne dass eine schematische Migration notwendig ist.

```{mermaid}
flowchart LR
    subgraph "Dokumentenorientierte DB"
        direction TB
        D1[Nutzer-Dokument 1] --> Felder1["
        {
          id: 101,
          name: 'Max Mustermann',
          email: 'max@example.com',
          profile: {
            avatar: 'url/to/image',
            bio: 'Software-Entwickler'
          },
          adressen: [
            {typ: 'privat', stadt: 'Berlin'},
            {typ: 'arbeit', stadt: 'München'}
          ]
        }"]
        
        D2[Nutzer-Dokument 2] --> Felder2["
        {
          id: 102,
          name: 'Lisa Schmidt',
          email: 'lisa@example.com',
          telefon: '+491234567890'
          /* andere Felder fehlen hier - 
             flexibles Schema */
        }"]
    end
```

Ein praktisches Beispiel sind Nutzerprofile in einer Webanwendung: Ein Nutzer hat evtl. ein Profilbild und mehrere Kontaktadressen, ein anderer nur eine E-Mail – in einer Dokumentendatenbank kann jeder Nutzer genau die Felder haben, die benötigt werden, und alles Relevante wird in einem JSON-Dokument gespeichert. Bekannte dokumentenorientierte DBMS sind MongoDB, CouchDB oder auch Amazon DynamoDB (das sowohl Key-Value- als auch Dokument-Modelle unterstützt). Dokumenten-Datenbanken bieten in der Regel eine mächtige Abfragesprache für Inhalte innerhalb der Dokumente sowie Indexe, um bestimmte Felder effizient zu durchsuchen {cite}`dataversity_history`. 

Einsatzvorteile: Dokumentenorientierte Systeme sind besonders dann sinnvoll, wenn die zu speichernden Objekte heterogen und flexibel sind – etwa bei Content-Management-Systemen, Blogs, Produktkatalogen oder Benutzerdaten, die sich pro Eintrag unterscheiden können. Durch das embedden von zusammengehörenden Daten in einem Dokument werden Lesezugriffe effizient (man erhält alle benötigten Infos auf einmal), und die Struktur lässt sich leicht an neue Anforderungen anpassen {cite}`dataversity_history`. Entwickler schätzen zudem die leichte Abbildung von objektorientierten Datenstrukturen auf Dokumente (Stichwort "Object-JSON-Mapping"), was die Entwicklung von Web- und Mobile-Anwendungen beschleunigen kann {cite}`dataversity_history`.

## Spaltenorientierte Datenbanken
Der Begriff spaltenorientierte Datenbank kann zweierlei bedeuten. In der klassischen Datenbankterminologie spricht man von *spaltenorientierten Speichersystemen* (Column Stores) oft im Zusammenhang mit analytischen relationalen Datenbanken, die Daten spaltenweise auf Datenträger speichern (z.B. SAP HANA, Apache Parquet). Im Kontext von NoSQL jedoch meint man meist Weitspalten-Datenbanken (Wide-Column Stores). Diese haben ihren Ursprung in Googles Bigtable-Papier (2006) und kombinieren Eigenschaften von Key-Value Stores mit tabellenähnlicher Struktur.

```{mermaid}
flowchart TB
    subgraph "Spaltenorientierte DB (Wide-Column)"
        direction LR
        Key1["Schlüssel: userX"] --- CF1[Spaltenfamilie: Profile]
        Key1 --- CF2[Spaltenfamilie: Logs]
        
        CF1 --- C11["Name: 'Max'"]
        CF1 --- C12["Alter: 28"]
        CF1 --- C13["Land: 'DE'"]
        
        CF2 --- C21["2023-05-01: Login"]
        CF2 --- C22["2023-05-02: Kauf"]
        CF2 --- C23["2023-05-03: Feedback"]
        
        Key2["Schlüssel: userY"] --- CF3[Spaltenfamilie: Profile]
        Key2 --- CF4[Spaltenfamilie: Logs]
        
        CF3 --- C31["Name: 'Lena'"]
        CF3 --- C32["Alter: 34"]
        CF3 --- C33["Stadt: 'Hamburg'"]
        
        CF4 --- C41["2023-05-01: Login"]
        CF4 --- C42["2023-05-04: Support"]
    end
```

Eine Spaltenorientierte Datenbank organisiert Daten in Tabellen, aber jede Zeile kann sehr viele, auch unterschiedliche Spalten haben, und ungenutzte Spalten verbrauchen keinen Speicher. Man kann sich dies als flexibles Tabellenmodell vorstellen, bei dem neue Spalten pro Eintrag hinzugefügt werden können, ohne die anderen Einträge zu beeinflussen. Zudem sind die Daten oft nach Spaltenfamilien gruppiert und nach Schlüssel sortiert, was sequentielle Zugriffe beschleunigt. Dieses Modell eignet sich hervorragend für sehr grosse, verteilte Datensätze – Google nutzte Bigtable beispielsweise für ihren Web-Index.

Bekannte Open-Source-Implementierungen sind Apache HBase (auf Hadoop) und Apache Cassandra, welche beide durch verteilte Architekturen auf vielen Knoten horizontal skalieren. Sie sind ausgelegt auf schnelles Schreiben und Lesen von *breiten* Datensätzen (z.B. zeitlich sortierte Messwerte, Logdaten, Sensorendaten). Durch die spaltenorientierte Ablage können Abfragen, die nur bestimmte Attribute betreffen, sehr effizient grosse Datenmengen durchsuchen {cite}`dataversity_history`. Einsatzgebiete sind typischerweise *Big Data*-Anwendungen: Echtzeit-Analysen, das Speichern von Ereignis-Logs, Telemetriedaten oder Customer-Analytics in grossen Web-Services. Auch in Kundenbeziehungs-Management-Systemen (CRM) und Data Warehouses werden spaltenorientierte NoSQL-Datenbanken eingesetzt, wenn sehr viele Attribute pro Eintrag flexibel verwaltet werden müssen {cite}`dataversity_history`.

## Key-Value Stores
Schlüssel-Wert-Datenbanken sind das einfachste und zugleich skalierbarste Modell unter den NoSQL-Systemen. Sie speichern Daten als Paar aus Schlüssel und Wert, ähnlich wie ein grosses assoziatives Array oder eine Hashmap. Ein Client kann einen Wert nur über seinen eindeutigen Schlüssel speichern, abrufen oder löschen. Die Datenbank selbst interpretiert den Wert nicht – dieser kann ein einfacher String, ein JSON-Dokument oder auch Binärdaten sein.

```{mermaid}
flowchart TB
    subgraph "Key-Value Store"
        direction TB
        K1["session_123"] --> V1["{ userId: 456, loggedIn: true, lastAccess: '2023-05-01T12:34:56Z' }"]
        K2["product_789"] --> V2["{ name: 'Laptop', price: 999.99, stock: 12 }"]
        K3["counter:views"] --> V3["1234567"]
        K4["cache:image_42"] --> V4["[Binärdaten]"]
    end
```

Der Fokus liegt auf *sehr schneller* Lese- und Schreiboperation für einzelne Schlüssel. Viele Key-Value Stores wie Redis, Memcached oder Amazons DynamoDB (im Key-Value-Modus) halten die Daten im Arbeitsspeicher oder nutzen effiziente Hashverfahren, um Antwortzeiten von wenigen Millisekunden oder darunter zu erreichen. Dadurch eignen sie sich ideal als Cache-Layer, zur Session-Verwaltung in Webanwendungen oder für Echtzeitanwendungen (z.B. Spiele, Börsenhandel), wo kleine Datenstücke extrem schnell gelesen und geschrieben werden müssen. Auch Shopping-Cart-Daten in Onlineshops oder Benutzerprofile mit variablem Inhalt werden oft in Key-Value Stores gehalten {cite}`dataversity_history` – in diesen Szenarien ist das Schema einfach genug, um auf relationale Strukturen zu verzichten, und die Performance hat oberste Priorität.

Key-Value-Datenbanken glänzen durch horizontale Skalierung: Verteilte Systeme wie Amazons Dynamo legen Datenteile auf vielen Servern ab (sharding) und verwenden Replikation, um Ausfallsicherheit zu garantieren. Allerdings bieten einfache Key-Value Stores meist keine komplexen Abfragefunktionen – man kann nur exakte Schlüssel suchen, keine sekundären Indizes oder Joins wie in anderen Modellen. Trotzdem bilden sie das Rückgrat vieler grosser Web-Plattformen im Hintergrund (Beispiel: Ein „Like"-Zähler in sozialen Netzwerken könnte in einem Key-Value Store gehalten werden, da nur ein Zähler pro Schlüssel verwaltet wird).

## Graph-Datenbanken
Eine weitere wichtige Kategorie alternativer Datenbanken – oft ebenfalls unter NoSQL eingeordnet – sind Graphdatenbanken. Sie sind spezialisiert auf die Speicherung von hoch vernetzten Daten und wurden populär, nachdem Tim Berners-Lee 2006 die Vision von "Linked Data" skizzierte {cite}`dataversity_history`. In einer Graphendatenbank werden Entitäten als Knoten (Nodes) gespeichert und Beziehungen zwischen ihnen als Kanten (Edges), jeweils evtl. mit Eigenschaften versehen. Dieses Modell ist ideal, um komplexe Beziehungsgeflechte abzubilden, beispielsweise soziale Netzwerke (Person A ist Freund von B, folgt C, etc.), Wissensgraphen, Netzwerkstrukturen oder Empfehlungen.

```{mermaid}
graph TD
    subgraph "Graph-Datenbank"
        P1[Person: Anna] -- "FOLGT" --> P2[Person: Ben]
        P1 -- "FREUND_VON" --> P3[Person: Clara]
        P2 -- "ARBEITET_BEI" --> C1[Firma: TechCorp]
        P3 -- "ARBEITET_BEI" --> C1
        P3 -- "KENNT" --> P4[Person: David]
        P4 -- "MAG" --> PR1[Produkt: Smartphone]
        P2 -- "HAT_GEKAUFT" --> PR1
        P1 -- "HAT_BEWERTET" --> PR1
    end
```

Im Gegensatz zu relationalen DB, die viele Joins über Zwischentabellen benötigen würden, sind in Graph-DB die Verbindungen direkt im Datenmodell verankert. Abfragen wie „Finde alle Freunde 2. Grades von Person X" lassen sich sehr effizient entlang der Kanten durchführen, ohne alle Datenbankeinträge scannen zu müssen. Neo4j ist ein bekannter Vertreter von Graphdatenbanken, weitere Beispiele sind Amazon Neptune, ArangoDB (multi-model mit Graph-Komponente) oder Apache Titan/JanusGraph {cite}`dataversity_history`. 

Einsatzfälle für Graph-DBs sind u.a. Soziale Netzwerke, Betrugserkennung (Verbindungen zwischen Transaktionen/Konten nachvollziehen), Empfehlungssysteme (z.B. Produkt A wurde von Kunden gekauft, die auch B kauften) oder Geoinformationssysteme. Graphdatenbanken haben gezeigt, dass sie mit wachsenden Datenmengen skalieren, ohne an Abfragegeschwindigkeit für Beziehungspfad-Suchen einzubüssen {cite}`dataversity_history`. Sie ergänzen damit die Palette der DBMS um eine leistungsfähige Option für Daten, bei denen Beziehungen im Vordergrund stehen.

Zusammenfassung NoSQL: Die verschiedenen NoSQL-Datenbanken entstanden, um die Lücken zu füllen, die relationale DB in bestimmten Szenarien liessen: sei es Flexibilität im Schema (Dokumenten-DB), extreme Geschwindigkeit für einfache Zugriffe (Key-Value), Verteilbarkeit für Big Data (Wide-Column) oder das Managen komplexer Netzwerke (Graph). Oft verzichten NoSQL-Systeme auf vollständige ACID-Transaktionen und setzen stattdessen auf eventual consistency (aus Performancegründen, siehe CAP-Theorem). In der Praxis werden NoSQL-Datenbanken häufig ergänzend zu relationalen Systemen eingesetzt, um spezielle Aufgaben zu lösen, anstatt diese komplett abzulösen.
