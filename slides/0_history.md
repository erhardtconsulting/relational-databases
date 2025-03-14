---
theme: hftm
footer: 'Die Geschichte der Datenbanken'
---
<!-- _class: lead -->

<div class="header-box">
  <p class="fachbereich">Informatik</p>
  <h1>Die Geschichte der Datenbanken</h1>
  <p class="date-author">März 2025 | Autor: Simon Erhardt</p>
</div>

---
# Inhaltsverzeichnis
<!--
- Hilft den Studierenden beim Überblick
- Folgende Punkte kurz ansprechen
-->
1. Motivation: Wieso Datenbanken?  
2. Wachsende Datenmengen in der Informatik  
3. Frühe Datenbanken (hierarchisch, Netzwerk)  
4. Relationaler Durchbruch  
5. NoSQL-Alternativen  
6. Neue Entwicklungen (Vektor, Blockchain)  
7. Vergleich & Fazit  

---
# Warum Datenbanken?
<!--
- Einstieg in das Thema, erklären wieso man DB benötigt
-->
- Daten sind Grundlage fast jeder IT-Anwendung  
- Verwaltung in simplen Dateien wird schnell unübersichtlich  
- Bedarf an gemeinsamer, konsistenter Datennutzung in Unternehmen  
- Zeitgleich viele Zugriffe, Schutz vor Datenverlust -> DBMS als Lösung  

---
# Wachsende Datenmengen
<!--
- Verdeutlichen, wie gross der Bedarf ist.
-->
- Big Data, IoT, KI – Datenvolumen explodiert ständig  
- Traditionelle Dateiverwaltung (z.B. CSV) stösst an Grenzen  
- DBMS sorgen für Skalierung, leistungsfähige Abfragen, Zugriffskontrolle  
- Datenqualität, Redundanzvermeidung und Sicherheit werden gewährleistet  

---
# Frühe Datenbanken (1960er)
<!--
- Hintergrund: Pioniere wie Charles W. Bachman (IDS), IBM IMS
-->
- Erste DBMS: Integrated Data Store (IDS), IBM IMS (hierarchisches Modell)  
- Motivation: Kontrolle großer Datenmengen, effizienter Zugriff statt simpler Dateiverwaltung  
- Navigationaler Ansatz: Daten in fest verdrahteten Strukturen, Verknüpfungen statt flexibler Abfragen  

---
# Hierarchische & Netzwerk-DB
<!--
- Vor- und Nachteile nennen, IMS als Beispiel für hierarchisches DB-Modell.
- CODASYL-Standard für Netzwerkmodell erwähnt.
-->
- Hierarchische DB (z.B. IMS): Baumbasierte Struktur, effizient, aber unflexibel  
- Netzwerk-DB: Komplexere Verknüpfungen (Viele-zu-Viele), aufwändige Handhabung  
- Nutzung u.a. im Finanzsektor & bei NASA (Saturn V)  

---
# Relationaler Durchbruch (1970er–1980er)
<!--
- Codd und sein Paper "A Relational Model of Data..."
- Vorteile: SQL, Ad-hoc-Abfragen, ACID-Transaktionen
-->
- E.F. Codd: Relationales Modell (Daten als Tabellen/Relationen)  
- SQL als Abfragesprache: Deklarativer Stil, Standardisierung  
- ACID-Garantien (Atomicity, Consistency, Isolation, Durability)  
- Marktanteil: Oracle, IBM DB2, Microsoft SQL Server – bis heute weitverbreitet  

---
# NoSQL-Alternativen (ab 2000er)
<!--
- Hauptkategorien: dokumentenorientiert, spaltenorientiert, Key-Value, Graph
- Idee: Flexibilität, Skalierung, teils Verzicht auf ACID
-->
- Dokumenten-DB (z.B. MongoDB): JSON-Strukturen, schemafrei  
- Spalten-DB (z.B. Cassandra): Big-Data, breite Tabellen, horizontale Skalierung  
- Key-Value Stores (z.B. Redis): Extrem schnelle Zugriffe für Schlüssel-Wert-Paare  
- Graph-DB (z.B. Neo4j): Daten als Knoten und Kanten, ideal für stark vernetzte Strukturen  

---
# Neue Entwicklungen
<!--
- Vektor- und Blockchain-DB
- Relevanz für KI und dezentrale Szenarien
-->
- Vektor-Datenbanken: Speziell für KI und Ähnlichkeitssuche (Embeddings)  
- Blockchain-DB: Dezentrale Ablage, Manipulationsschutz, z.B. für Supply Chains  

---
# Vergleich & Fazit
<!--
- Kurzer Blick auf Einsatzfelder, Ausblick
-->
- Relationale DB für strukturierten ACID-Einsatz  
- NoSQL für hohe Skalierung, flexible Schemas  
- Speziallösungen (Vektor, Blockchain) für KI und unveränderliche/verteilte Szenarien  
- Datenbanken bleiben Kern moderner IT – ständige Weiterentwicklung
