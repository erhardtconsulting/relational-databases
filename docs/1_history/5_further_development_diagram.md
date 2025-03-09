# Visuelle Darstellung neuerer Datenbankentwicklungen

## Vektor-Datenbanken für KI und Ähnlichkeitssuche

```mermaid
flowchart LR
    subgraph "Vektor-Datenbank Funktionsweise"
        direction TB
        Input[Eingabedaten] --> Embedding[Embedding-Modell]
        Embedding --> Vektoren[Hochdimensionale Vektoren]
        Vektoren --> Indexierung["Indizierung (ANN)"]
        
        Query[Suchanfrage] --> QueryEmbed[Embedding der Anfrage]
        QueryEmbed --> ÄhnlichkeitsSuche[Ähnlichkeitsberechnung]
        Indexierung --> ÄhnlichkeitsSuche
        ÄhnlichkeitsSuche --> Ergebnisse[Ähnlichste Dokumente]
    end
    
    Vorteile[Vorteile] --> V1[Semantische Suche]
    Vorteile --> V2[Effizient für KI-Anwendungen]
    Vorteile --> V3[Ähnlichkeitsbasierte Abfragen]
    Vorteile --> V4[Multimodale Daten (Text, Bild, Audio)]
    
    Anwendungen[Einsatzgebiete] --> A1[Empfehlungssysteme]
    Anwendungen --> A2[Chatbots & LLMs]
    Anwendungen --> A3[Bildersuche]
    Anwendungen --> A4[Betrugserkennung]
```

## Vektorähnlichkeitssuche im Vergleich zur traditionellen Suche

```mermaid
flowchart TB
    subgraph "Traditionelle Suche"
        TS1[Textsuche] --> TS2[Exakte Übereinstimmung/Keyword]
        TS2 --> TS3["Ergebnisse (basierend auf Wortübereinstimmung)"]
    end
    
    subgraph "Vektor-basierte Suche"
        VS1[Textsuche] --> VS2[Text-zu-Vektor Embedding]
        VS2 --> VS3[Ähnlichkeitsberechnung (z.B. Kosinus-Distanz)]
        VS3 --> VS4["Ergebnisse (basierend auf semantischer Ähnlichkeit)"]
    end
    
    Beispiel1["Traditionell: 'Klimawandel'"] --> TS1
    Beispiel2["Vektor: 'Klimawandel'"] --> VS1
    
    TS3 --> Trad["Findet nur: 'Klimawandel', 'Klimawandels', ..."]
    VS4 --> Vekt["Findet auch: 'Globale Erwärmung', 'CO₂-Emissionen', 'Treibhauseffekt', ..."]
```

## Anwendungsbeispiel: Vektor-DB in einem Empfehlungssystem

```mermaid
flowchart TD
    subgraph "E-Commerce mit Vektor-DB"
        P1[Produkt: Kamera] --> E1[Embedding]
        P2[Produkt: Stativ] --> E2[Embedding]
        P3[Produkt: Objektiv] --> E3[Embedding]
        P4[Produkt: Smartphone] --> E4[Embedding]
        P5[Produkt: Laptop] --> E5[Embedding]
        
        E1 --> VDB[Vektor-Datenbank]
        E2 --> VDB
        E3 --> VDB
        E4 --> VDB
        E5 --> VDB
        
        User[Benutzer betrachtet: Kamera] --> UE[Embedding des betrachteten Produkts]
        UE --> ANN[ANN-Suche nach ähnlichen Produkten]
        VDB --> ANN
        
        ANN --> R1[Empfehlung: Objektiv]
        ANN --> R2[Empfehlung: Stativ]
    end
```

## Blockchain-basierte Datenbanken

```mermaid
flowchart TD
    subgraph "Traditionelle Datenbank"
        direction LR
        TD_Client[Client] <--> TD_Server[Zentraler Server]
        TD_Server --> TD_DB[(Datenbank)]
    end
    
    subgraph "Blockchain Datenbank"
        direction TB
        BC_Client[Client] <--> BC_Network{Blockchain-Netzwerk}
        BC_Network <--> Node1[Knoten 1]
        BC_Network <--> Node2[Knoten 2]
        BC_Network <--> Node3[Knoten 3]
        BC_Network <--> Node4[Knoten 4]
        
        Node1 --> BC_DB1[(Kopie der Blockchain)]
        Node2 --> BC_DB2[(Kopie der Blockchain)]
        Node3 --> BC_DB3[(Kopie der Blockchain)]
        Node4 --> BC_DB4[(Kopie der Blockchain)]
    end
    
    TD_Client -.-> BC_Client
```

## Struktur einer Blockchain-Datenbank

```mermaid
flowchart LR
    subgraph "Blockchain-Struktur"
        B1[Block 1] --> B2[Block 2]
        B2 --> B3[Block 3]
        B3 --> B4[Block 4]
        B4 --> B5[... Block n]
        
        subgraph "Block-Aufbau"
            Header[Block-Header]
            Header --> PrevHash[Hash des vorherigen Blocks]
            Header --> Timestamp[Zeitstempel]
            Header --> MerkleRoot[Merkle-Root-Hash]
            Transaktionen[Transaktionen] --> T1[Transaktion 1]
            Transaktionen --> T2[Transaktion 2]
            Transaktionen --> T3[Transaktion n]
        end
    end
    
    Eigenschaften[Eigenschaften] --> E1[Unveränderlichkeit]
    Eigenschaften --> E2[Dezentrales Vertrauen]
    Eigenschaften --> E3[Transparente Historie]
    Eigenschaften --> E4[Kryptografische Sicherheit]
    
    Anwendungen[Einsatzgebiete] --> A1[Supply-Chain-Tracking]
    Anwendungen --> A2[Grundbücher]
    Anwendungen --> A3[Digitale Identität]
    Anwendungen --> A4[Smart Contracts]
```

## Vergleich: Moderne Datenbankkonzepte

```mermaid
classDiagram
    class "Traditionelle DB" {
        + Zentralisiert
        + CRUD-Operationen
        + Datenzustand fokussiert
        + Hohe Performance
        + Change/Update möglich
    }
    
    class "Vektor-DB" {
        + Ähnlichkeitssuche
        + Hochdimensionale Daten
        + KI-Integration
        + Semantisches Verständnis
        + Multimodale Fähigkeiten
    }
    
    class "Blockchain-DB" {
        + Dezentralisiert
        + Append-only Transaktionen
        + Unveränderliche Historie
        + Konsensmechanismen
        + Kryptografisch gesichert
    }
    
    "Traditionelle DB" -- "Vektor-DB" : ergänzt
    "Traditionelle DB" -- "Blockchain-DB" : kontrastiert
```

Diese Visualisierungen zeigen die neuesten Entwicklungen in der Datenbanklandschaft: Vektor-Datenbanken, die speziell für KI-Anwendungen und Ähnlichkeitssuche optimiert sind, sowie Blockchain-basierte Datenbanken, die durch Dezentralisierung und Unveränderlichkeit neue Sicherheits- und Vertrauensmodelle einführen. Beide Technologien erweitern das Spektrum moderner Datenbanklösungen für spezifische Herausforderungen.
