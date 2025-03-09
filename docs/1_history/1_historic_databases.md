# 1. Historische Entwicklung: Die ersten Datenbanksysteme

In den 1960er-Jahren entstanden die ersten echten Datenbankmanagementsysteme (DBMS). Sie wurden entwickelt, um der wachsenden Menge an digitalen Daten Herr zu werden, die mit einfachen Datei-Systemen nicht mehr effizient verwaltet werden konnten. Charles W. Bachman entwickelte 1960 am Unternehmen General Electric das *Integrated Data Store (IDS)* – oft als das erste Datenbanksystem bezeichnet. Kurz darauf entwickelte IBM als Antwort das *Information Management System (IMS)* {cite}`dataversity_history`. Diese frühen Systeme basierten auf dem sogenannten *navigationalen* Ansatz: Daten wurden in fest verdrahteten Strukturen gespeichert und mithilfe von Verknüpfungen durchsucht, anstatt mit flexiblen Abfragen wie in heutigen Systemen {cite}`thinkautomation_history`. Zwei grundlegende Organisationsformen prägten diese Ära: hierarchische Datenbanken und Netzwerk-Datenbanken.

## Hierarchische Datenbanken 
Hierarchische Datenbanksysteme speichern Daten in einer baumartigen Hierarchie aus Datensätzen. Ähnlich wie in einem Stammbaum oder Verzeichnis hat jeder Datensatz genau einen Elternknoten (ausser dem Wurzelelement) und kann mehrere Kind-Datensätze besitzen {cite}`wikipedia_hierarchisch`. Diese Struktur eignet sich z.B. zur Abbildung von Stücklisten oder Organisationsstrukturen, bei denen natürliche Hierarchien vorliegen. 

```{mermaid}
graph TD
    Wurzel[Wurzel / Root] --> A[Abteilung A]
    Wurzel --> B[Abteilung B]
    A --> A1[Mitarbeiter A1]
    A --> A2[Mitarbeiter A2]
    A --> A3[Mitarbeiter A3]
    B --> B1[Mitarbeiter B1]
    B --> B2[Mitarbeiter B2]
    
    classDef root fill:#f96,stroke:#333,stroke-width:2px;
    classDef department fill:#bbf,stroke:#333,stroke-width:1px;
    classDef employee fill:#dfd,stroke:#333,stroke-width:1px;
    
    class Wurzel root;
    class A,B department;
    class A1,A2,A3,B1,B2 employee;
```

Ein bekanntes Beispiel ist IBMs IMS, das ursprünglich für die NASA entwickelt wurde, um Millionen von Bauteilen der Saturn V Mondrakete zu verwalten {cite}`twobithistory_ims`. IMS repräsentierte die Daten als Baum aus übergeordneten „Master"-Einträgen und untergeordneten „Detail"-Einträgen, was eine effiziente Navigation entlang der Hierarchie erlaubte. Hierarchische Datenbanken erwiesen sich in ihrem Anwendungsbereich als sehr performant, jedoch waren Querverbindungen zwischen verschiedenen Hierarchiezweigen nicht möglich und flexible Abfragen schwierig. Dennoch war IMS ein Meilenstein: 1968 in Betrieb genommen, gilt es als eines der ersten kommerziellen DBMS. Überraschenderweise ist IMS auch heute noch im Einsatz – zahlreiche Grossbanken, Versicherungen und Behörden verwenden es bis heute für geschäftskritische Anwendungen {cite}`twobithistory_ims`.

## Netzwerk-Datenbanken 
Das Netzwerk-Datenbankmodell erweiterte das hierarchische Modell, indem es verzweigte Verknüpfungen zwischen Datensätzen erlaubte. Daten wurden als ein Netzwerk von Datensatztypen organisiert, in dem ein Datensatz mehrere übergeordnete Datensätze haben konnte. Formalisiert wurde dieses Modell durch die *Conference on Data Systems Languages (CODASYL)*, die 1971 einen Standardentwurf präsentierte {cite}`dataversity_history`. 

```{mermaid}
graph TD
    A[Lieferant A] --> M1[Material M1]
    A --> M2[Material M2]
    B[Lieferant B] --> M2
    B --> M3[Material M3]
    
    M1 --> P1[Produkt P1]
    M2 --> P1
    M2 --> P2[Produkt P2]
    M3 --> P2
    M3 --> P3[Produkt P3]
    
    classDef supplier fill:#f96,stroke:#333,stroke-width:1px;
    classDef material fill:#bbf,stroke:#333,stroke-width:1px;
    classDef product fill:#dfd,stroke:#333,stroke-width:1px;
    
    class A,B supplier;
    class M1,M2,M3 material;
    class P1,P2,P3 product;
```

Dabei entstanden Datenbanken nach dem CODASYL-Ansatz, bei denen Programmierer mittels einer speziellen Datenmanipulationssprache (häufig eingebettet in COBOL) Datensätze verknüpfen und traversieren konnten. Ein Datensatztyp konnte als „Eigentümer" in mehreren Beziehungen auftreten, wodurch Viele-zu-Viele-Beziehungen möglich wurden – ein Vorteil gegenüber dem starren Baum des hierarchischen Modells. Ein prominentes frühes Netzwerk-DBMS war Bachmans IDS selbst, das als Vorlage für den CODASYL-Standard diente.

Netzwerk-Datenbanken erlaubten komplexe Verknüpfungen, waren aber sehr aufwändig in der Handhabung. Entwickler mussten genau wissen, wie die Daten physisch verknüpft waren, und sie *navigierten* mit Programmcode von einem Datensatz zum nächsten. Das Suchen von Informationen erfolgte entweder über Primärschlüssel, über das schrittweise Durchlaufen von Verknüpfungen (Sets) oder durch sequentielles Scannen aller Datensätze. Diese manuelle Navigation machte die Arbeit mit Netzwerk-DBMS komplex und fehleranfällig. Infolgedessen verloren CODASYL-Datenbanken im Laufe der 1970er-Jahre an Popularität, als neue, einfacher zu bedienende Ansätze aufkamen {cite}`dataversity_history`.

Zusammenfassend lässt sich sagen, dass die ersten Datenbanksysteme stark von der physischen Datenorganisation geprägt waren. Hierarchische und Netzwerk-Datenbanken legten den Grundstein, zeigten aber auch Schwächen in Bezug auf Flexibilität und Benutzerfreundlichkeit. Diese Schwächen ebneten den Weg für einen Paradigmenwechsel in den 1970ern – hin zum relationalen Modell.
