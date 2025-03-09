# 5. Neuere Entwicklungen: Vektor- und Blockchain-Datenbanken

Die Datenbanklandschaft entwickelt sich stetig weiter. In den letzten Jahren sind neue Technologien in den Vordergrund gerückt, um den Herausforderungen aktueller Anwendungen – insbesondere Künstliche Intelligenz und sichere verteilte Systeme – gerecht zu werden. Zwei Beispiele dafür sind *Vektor-Datenbanken* und *Blockchain-basierte Datenbanken*.

## Vektor-Datenbanken (für KI und Ähnlichkeitssuche) 
Mit dem Aufkommen von KI-Modellen, die Texte, Bilder oder andere Objekte in hochdimensionale Vektoren (Embedding) abbilden, entstand der Bedarf, solche Vektordaten effizient zu speichern und zu durchsuchen. Eine Vektor-Datenbank ist spezialisiert darauf, grosse Mengen von Datenpunkten in Form von numerischen Vektoren zu verwalten und Ähnlichkeitsabfragen darauf rasch zu beantworten {cite}`ibm_vector_db`. Anders als in klassischen DB, wo Abfragen meist auf exakte Werte (z.B. =, <, >) zielen, stehen bei Vektor-DB Ähnlichkeitssuchen im Vordergrund: Man fragt z.B., welche Bild-Embed­dings einem gegebenen Vektor am nächsten sind – sprich welche Bilder dem gesuchten Bild ähneln.

```{mermaid}
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

Vektor-Datenbanken ermöglichen so Funktionen, die für moderne KI-Anwendungen essenziell sind: ähnliche Dokumente finden, Empfehlungen berechnen oder semantische Suchanfragen durchführen. Beispielsweise könnte ein E-Commerce-Shop einen Vektor aus dem Beschreibungstext eines Produkts berechnen und in der DB ablegen; für eine Empfehlung werden dann die nächstliegenden Vektoren (ähnliche Produkte) abgefragt, um *„Kunden, die X ansahen, interessiert auch Y"* anzuzeigen {cite}`cloudflare_vector_db`. Grosse Sprachmodelle (LLMs) nutzen Vektor-Datenbanken, um *Kontextwissen* zu speichern und bei Bedarf ähnliche Texte oder Wissenseinträge abzurufen, was Anwendungen wie intelligente Chatbots unterstützt {cite}`cloudflare_vector_db`.

Technisch setzen Vektor-DBMS auf spezielle Indexstrukturen (wie ANN – Approximate Nearest Neighbors), um aus Millionen von Vektoren die nächsten Nachbarn schnell zu finden. Bekannte Vertreter sind z.B. Facebook FAISS (Bibliothek), Milvus, Pinecone oder Weaviate, die oft als Cloud-Service angeboten werden. Laut einer Prognose von Gartner werden bis 2026 über 30% der Unternehmen Vektor-Datenbanken einsetzen, um KI-Modelle mit ihren geschäftlichen Daten zu untermauern {cite}`ibm_vector_db`. Diese Entwicklung zeigt, dass Vektor-DB nicht mehr nur Nischenlösungen für Tech-Giganten sind, sondern Einzug in breitere Anwendungen halten. Für Informatikstudenten sind Vektor-Datenbanken ein spannendes Feld, da hier Konzepte aus Datenbanken, lineare Algebra und maschinelles Lernen zusammenfliessen.

## Blockchain-basierte Datenbanken 
Blockchain-Technologie, bekannt durch Kryptowährungen wie Bitcoin, hat in den letzten Jahren ebenfalls Einfluss auf die Datenbankwelt genommen. In einer Blockchain werden Daten in Blöcken gespeichert, die kryptographisch verkettet sind – jede Änderung ist nachvollziehbar und nachträgliche Manipulation wird praktisch verhindert. Eine Blockchain kann man vereinfacht als einen dezentralen, unveränderlichen Datenspeicher betrachten. Daraus entstand die Idee der *Blockchain-Datenbanken*, die Eigenschaften klassischer DBMS (Datenabfragen, -verwaltung) mit der fälschungssicheren Verteilung einer Blockchain kombinieren.

Der Hauptunterschied zu traditionellen Datenbanken besteht darin, dass eine Blockchain-Datenbank ohne zentrales Vertrauenswürdiges System auskommt: Alle Knoten im Netzwerk halten eine Kopie der Daten, und ein Konsensverfahren stellt sicher, dass sie sich auf den gleichen Stand einigen. Dadurch wird die Manipulationssicherheit erhöht – jede Transaktion wird mit einem Hash gesichert, und um einen Eintrag zu ändern, müsste man rückwirkend die ganze Kette verändern, was praktisch unmöglich ist {cite}`techtarget_blockchain_db`. In Anwendungsfällen, wo mehrere Parteien ohne gegenseitiges Vertrauen Daten gemeinsam nutzen wollen (z.B. in Lieferketten, bei Grundbuchämtern oder digitalen Identitäten), ist dies ein grosser Vorteil. Datenbankaktionen wie Schreibvorgänge werden transparent und nachvollziehbar, was Auditing und Compliance erheblich erleichtern kann.

Allerdings kommt dieser Vorteil mit Kosten: Aktuelle Blockchain-Datenbanken (oder Distributed Ledger Technologies) sind langsamer und weniger skalierbar als klassische DBMS, insbesondere bei sehr vielen Transaktionen. Auch sind Abfragemöglichkeiten oft eingeschränkter. Ansätze wie BigchainDB versuchen, die Lücke zu schliessen, indem sie auf einer herkömmlichen Datenbank (z.B. MongoDB) aufbauen und diese um eine Blockchain-Schicht für die Unveränderlichkeit und Dezentralität ergänzen {cite}`opensourceforu_bigchaindb`. So wird z.B. die hohe Durchsatzrate einer NoSQL-Datenbank mit den Blockchain-typischen Eigenschaften kombiniert.

In der Praxis findet man blockchain-basierte Datenbanken vor allem dort, wo Vertrauensfragen im Vordergrund stehen: bei Kryptowährungen und Finanztransaktionen (wo die Blockchain selbst die Datenbank ist), in Supply-Chain-Anwendungen (um z.B. den Herkunftsnachweis von Produkten fälschungssicher zu speichern) oder bei dezentralen Anwendungen (dApps) im Web3-Umfeld. Für traditionelle Anwendungen (etwa eine Webshop-Datenbank) ist die Blockchain hingegen meist überdimensioniert und zu träge. Künftige Entwicklungen könnten jedoch dazu führen, dass bestimmte Blockchain-Mechanismen (z.B. unveränderliche Logs, verteilte Konsensalgorithmen) Einzug in Mainstream-Datenbanken halten, um deren Sicherheit und Robustheit zu erhöhen {cite}`progress_multimodel_db`.
