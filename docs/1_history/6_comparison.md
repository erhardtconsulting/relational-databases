# 6. Vergleich und Einsatzgebiete der Datenbankmodelle

Angesichts der Vielfalt von Datenbanktypen stellt sich die Frage, *welche* Datenbank für *welchen* Anwendungsfall geeignet ist. Die folgende Übersichtstabelle fasst die wichtigsten Datenbankarten, ihre Kernmerkmale und typische Einsatzgebiete zusammen:

| Datenbanktyp               | Beispiele                | Geeignete Anwendungsfälle                                          |
| ------------------------------ | ---------------------------- | ---------------------------------------------------------------------- |
| Hierarchische DB           | IBM IMS, Windows Registry    | Stark hierarchische Daten (z.B. Organigramme, Stücklisten); legacy Systeme in Banken/Versicherungen, Verzeichnisdienste (LDAP). |
| Netzwerk-DB                | CODASYL-DB (z.B. IDMS)       | Frühe Unternehmens-DB mit komplexen Many-to-Many-Beziehungen (heute vor allem in Altsystemen, da weitgehend von relational abgelöst). |
| Relationale DB (RDBMS)     | Oracle, MySQL, PostgreSQL    | Allgemeine Geschäftsdaten, transaktionale Systeme (Banken, ERP, Buchungssysteme), strukturierte Daten mit Schema, wenn ACID-Konformität und SQL-Zugriff gefordert sind (Standard in den meisten Anwendungen). |
| Dokumenten-DB              | MongoDB, CouchDB, DynamoDB   | Flexible, schemafreie Daten, z.B. Inhalte von Websites, Konfigurationsdaten, Benutzerprofile, Blog- und CMS-Daten. Überall dort, wo JSON-Daten mit variabler Struktur gespeichert und schnell abgerufen werden sollen. |
| Weitspalten-DB (Column Family) | Apache Cassandra, HBase | Big-Data-Anwendungen mit grossen, breiten Tabellen: Zeitreihen (IoT-Sensoren), Log- und Telemetriedaten, Analyse grosser Datenmengen, wenn verteilte Skalierung und schnelle Schreibzugriffe benötigt werden. |
| Key-Value Store            | Redis, Memcached, Riak      | Einfache Datenzugriffe mit extrem hohen Anforderungen an Durchsatz und Latenz: Caching, Session-Daten, Echtzeit-Datenstreams, Zähler (Likes/Views), Shopping-Carts, schnelle Konfigurationsabrufe. |
| Graph-Datenbank            | Neo4j, Amazon Neptune       | Hochvernetzte Daten: Soziale Netzwerke, Empfehlungs- und Betrugserkennungssysteme, Wissensgraphen, Netzwerk- und Routinginformationen (z.B. Routenplanung, Lieferwege). |
| Vektor-Datenbank           | Pinecone, Weaviate, Milvus  | KI- und ML-Anwendungen: Ähnlichkeitssuche in Multimedia-Daten (Bild-/Textähnlichkeit), semantische Suche, Recommendations, Kontextspeicher für Sprachmodelle (Embeddings-Suche). |
| Blockchain-Datenbank       | BigchainDB, Ethereum (Ledger) | Vertrauenslose, verteilte Datenspeicherung: Kryptowährungstransaktionen, Supply-Chain-Tracking, notarielle Register (Grundbücher, Zertifikate) – überall dort, wo unveränderliche, transparente Nachvollziehbarkeit wichtiger ist als hohe Transaktionsraten. |

*Hinweis:* In der Praxis verschwimmen die Grenzen teils – z.B. unterstützen viele relationale Datenbanken heute JSON-Felder (dokumentenartig), einige NoSQL-DB bieten SQL-ähnliche Abfragesprachen, und sogenannte Multi-Model-Datenbanken versuchen, mehrere dieser Modelle in einem System zu vereinen. Die obige Tabelle dient also als grobe Orientierung.