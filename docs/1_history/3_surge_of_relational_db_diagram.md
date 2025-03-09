# Visuelle Darstellung relationaler Datenbanken

## Timeline der relationalen Datenbankentwicklung

```mermaid
timeline
    title Evolution der relationalen Datenbanken
    1970 : Edgar F. Codd veröffentlicht "A Relational Model of Data for Large Shared Data Banks"
    1970s : IBM entwickelt System R mit erster SQL-Implementierung
    1979 : Oracle bringt erste kommerzielle relationale Datenbank auf den Markt
    1986 : SQL wird ANSI-Standard
    1980s : Relationale DBs verdrängen hierarchische und netzwerkartige Systeme
    1990s : Relationale DBs werden industrieweiter Standard
    2000s : Dominanz relationaler Systeme in Unternehmen
```

## Vorteile des relationalen Datenbankmodells

```mermaid
flowchart TD
    RDBMS[Relationales Datenbanksystem] --> SQL[Einfache Anfragen mit SQL]
    RDBMS --> ACID[ACID-Transaktionen]
    RDBMS --> Struktur[Tabellarische Struktur]
    RDBMS --> Performance[Optimierte Performance]
    
    SQL --> SQL1[Standardisierte Sprache]
    SQL --> SQL2[Deklarative Anfragen]
    SQL --> SQL3[Komplexe Operationen mit einfacher Syntax]
    
    ACID --> A[Atomarität]
    ACID --> C[Konsistenz] 
    ACID --> I[Isolation]
    ACID --> D[Dauerhaftigkeit]
    
    Struktur --> S1[Tabellen mit Zeilen und Spalten]
    Struktur --> S2[Relationen zwischen Tabellen]
    Struktur --> S3[Flexible Ad-hoc-Abfragen]
    
    Performance --> P1[Indexierung]
    Performance --> P2[Abfrageoptimierung]
    Performance --> P3[Hardware-Skalierung]
```

## Paradigmenwechsel: Von navigational zu relational

```mermaid
flowchart LR
    subgraph "Navigationale Datenbanken"
        N1[Hierarchische DBs] --> NP[Probleme]
        N2[Netzwerk DBs] --> NP
        NP --> NP1[Komplexe Navigation]
        NP --> NP2[Starre Struktur]
        NP --> NP3[Programmieraufwand]
    end
    
    subgraph "Relationale Datenbanken"
        RA[Relationales Modell] --> RV[Vorteile]
        RV --> RV1[Deklarative Abfragen]
        RV --> RV2[Flexible Struktur]
        RV --> RV3[Datenunabhängigkeit]
        RV --> RV4[Mathematische Grundlage]
    end
    
    NP --"Paradigmenwechsel (1970er)"--> RA
```

## Datenmodellierung im relationalen Modell

```mermaid
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

Das relationale Modell organisiert Daten in Tabellen mit definierten Beziehungen und ermöglicht durch SQL flexible, deklarative Abfragen. Dank ACID-Garantien und strukturierter Datenorganisation wurde es zum dominierenden Datenbankparadigma für mehrere Jahrzehnte.
