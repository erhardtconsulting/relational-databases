# Visuelle Darstellung alternativer Datenbankmodelle (NoSQL)

## NoSQL-Datenbanktypen im Überblick

```mermaid
flowchart TD
    NoSQL[NoSQL-Datenbanken] --> Doc[Dokumentenorientierte DB]
    NoSQL --> Col[Spaltenorientierte DB]
    NoSQL --> KV[Key-Value Stores]
    NoSQL --> Graph[Graph-Datenbanken]
    
    Doc --> Doc1[MongoDB]
    Doc --> Doc2[CouchDB]
    Doc --> Doc3[Amazon DynamoDB]
    
    Col --> Col1[Apache Cassandra]
    Col --> Col2[Apache HBase]
    Col --> Col3[Google Bigtable]
    
    KV --> KV1[Redis]
    KV --> KV2[Memcached]
    KV --> KV3[Amazon DynamoDB]
    
    Graph --> G1[Neo4j]
    Graph --> G2[Amazon Neptune]
    Graph --> G3[ArangoDB]
    
    style NoSQL fill:#f9f,stroke:#333,stroke-width:2px
    style Doc fill:#bbf,stroke:#333
    style Col fill:#fbf,stroke:#333
    style KV fill:#bfb,stroke:#333
    style Graph fill:#fbb,stroke:#333
```

## Dokumentenorientierte Datenbanken

```mermaid
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
    
    Vorteile[Vorteile] --> V1[Flexibles Schema]
    Vorteile --> V2[Natürliche Abbildung von Objekten]
    Vorteile --> V3[Eingebettete Daten ohne Joins]
    Vorteile --> V4[Hohe Schreibperformance]
    
    Anwendungen[Einsatzgebiete] --> A1[Content Management]
    Anwendungen --> A2[Benutzerprofile]
    Anwendungen --> A3[Produktkataloge]
    Anwendungen --> A4[Mobile Apps]
```

## Spaltenorientierte Datenbanken (Wide-Column Stores)

```mermaid
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
    
    Eigenschaften[Eigenschaften] --> E1[Spalten in Familien gruppiert]
    Eigenschaften --> E2[Horizontal skalierbar]
    Eigenschaften --> E3[Effizient für große Datenmengen]
    Eigenschaften --> E4[Zeilenorientierter Zugriff möglich]
    
    Anwendungen[Einsatzgebiete] --> A1[Big Data]
    Anwendungen --> A2[Zeitreihendaten]
    Anwendungen --> A3[Sensorendaten]
    Anwendungen --> A4[Log-Analyse]
```

## Key-Value Stores

```mermaid
flowchart TB
    subgraph "Key-Value Store"
        direction TB
        K1["session_123"] --> V1["{ userId: 456, loggedIn: true, lastAccess: '2023-05-01T12:34:56Z' }"]
        K2["product_789"] --> V2["{ name: 'Laptop', price: 999.99, stock: 12 }"]
        K3["counter:views"] --> V3["1234567"]
        K4["cache:image_42"] --> V4["[Binärdaten]"]
    end
    
    Eigenschaften[Eigenschaften] --> E1[Sehr einfache Struktur]
    Eigenschaften --> E2[Extrem hohe Performance]
    Eigenschaften --> E3[Leicht zu skalieren]
    Eigenschaften --> E4[In-Memory-Option]
    
    Anwendungen[Einsatzgebiete] --> A1[Caching]
    Anwendungen --> A2[Sitzungsdaten]
    Anwendungen --> A3[Echtzeit-Anwendungen]
    Anwendungen --> A4[Zähler und Status]
```

## Graph-Datenbanken

```mermaid
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
    
    Eigenschaften[Eigenschaften] --> E1[Knoten = Entitäten]
    Eigenschaften --> E2[Kanten = Beziehungen]
    Eigenschaften --> E3[Effizient für verbundene Daten]
    Eigenschaften --> E4[Komplexe Traversierung]
    
    Anwendungen[Einsatzgebiete] --> A1[Soziale Netzwerke]
    Anwendungen --> A2[Empfehlungssysteme]
    Anwendungen --> A3[Betrugserkennung]
    Anwendungen --> A4[Wissensnetze]
```

## NoSQL vs. Relationale Datenbanken: Eigenschaften

```mermaid
classDiagram
    class "Relationale DB" {
        + Strukturiertes Schema
        + ACID-Transaktionen
        + Normalisierte Daten
        + SQL-Abfragesprache
        + Vertikale Skalierung
        + Tabellen & Joins
    }
    
    class "NoSQL DB" {
        + Flexibles/Schema-frei
        + BASE (Eventual Consistency)
        + Denormalisierte Daten
        + Eigene Abfragesprachen
        + Horizontale Skalierung
        + Verschiedene Datenmodelle
    }
    
    "Relationale DB" <|--|> "NoSQL DB" : unterschiedliche Paradigmen
```

Diese Visualisierungen zeigen die unterschiedlichen Ansätze der NoSQL-Datenbankmodelle im Vergleich zu relationalen Datenbanken. Jedes Modell ist für bestimmte Anwendungsfälle optimiert und bietet spezifische Vor- und Nachteile.
