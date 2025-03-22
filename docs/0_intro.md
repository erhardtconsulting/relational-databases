---
authors:
  - name: Simon Erhardt
    email: simon.erhardt@hftm.ch
    affiliations:
      - id: hftm
        institution: Höhere Fachschule für Technik Mittelland
        department: Informatik
      - erhardt consulting GmbH
---
# Relationale Datenbanken

## Vorwort

Die Welt hat sich in den letzten Jahren rasant technifiziert. Informatiksysteme und vor allem die Verarbeitung und Speicherung von Daten sind derart in unseren Alltag verwoben, dass ein Leben ohne diese Technologien kaum vorstellbar ist. Überall, wo Menschen arbeiten, lernen oder sich informieren, sind Daten involviert. Daten gelten heute gar als das neue Öl – sie treiben Innovation, Wirtschaft und Gesellschaft an und sind zum wertvollen Gut geworden, dessen verantwortungsvoller Umgang entscheidend ist.

Datenbanksysteme bilden den integralen Unterbau dieser datenbasierten Welt. Wenn wir von Grossbetrieben sprechen, die mehrere Millionen Datensätze verwalten, oder von kleinen Firmen, die mit einem strukturierten Adressmanagement arbeiten – relationale oder andere Datenbanken sind stets die Schlüsselkomponente. Wer diese versteht und effizient nutzt, erlangt einen entscheidenden Wissensvorsprung.

Dieses Buch bietet dir eine fundierte Einführung in die Welt der Datenbanken. Es beleuchtet verschiedene Arten von Datenbanksystemen und zeigt dir, wie sich Theorie und praktische Anwendung nahtlos verbinden lassen. Gerade in einer praxisnahen Ausbildung ist es essenziell, nicht nur den theoretischen Unterbau zu kennen, sondern auch konkret mit Datenbanksystemen zu arbeiten. Dieses Buch bildet deshalb auch die Grundlage für den Unterricht an der Höheren Fachschule für Technik Mittelland (HFTM).

Als lehrende Institution fokussiere ich mich auf die Open-Source-Datenbank PostgreSQL, die in der Praxis weit verbreitet ist und damit ein perfektes Übungsfeld für angehende Datenbankentwickler und -administratoren bietet. Die praktischen Beispiele lassen sich mithilfe der beiliegenden Docker-Container schnell und unkompliziert auf dem eigenen Rechner durchführen, sodass du dir in kürzester Zeit einen Einblick in Installation, Konfiguration und erste Abfragen verschaffen kannst.

Damit das Gelernte stets auf dem neuesten Stand bleibt, ist dieses Buch in seiner Online-Version eine lebende Dokumentation. Ich lade dich ein, über Pull-Requests aktiv an der Weiterentwicklung mitzuwirken. Auf diese Weise profitierst du nicht nur selbst von neusten Erkenntnissen und Erweiterungen, sondern förderst auch den Austausch in der Gemeinschaft aller Lernenden und Lehrenden.

Ich wünsche dir spannende Einblicke, viel Erfolg in der Praxis und hoffe, dass dich diese Lektüre auf deinem Weg zum Datenbankprofi tatkräftig unterstützt.

## Danksagungen

Mein besonderer Dank gilt Simeon Liniger, meinem Vorgänger-Dozenten im Bereich Datenbanken an der HFTM. Dank seiner sorgfältigen Vorarbeiten und des inspirierenden Kurses, den er aufgebaut hat, durfte ich auf einem soliden Fundament aufbauen und daraus die Idee für dieses Buch entwickeln.

Ebenso danke ich der Klasse im Frühlingssemester 2024, die mit ihrem konstruktiven Feedback den Anstoss gab, verschiedene Aspekte des Unterrichts zu überdenken und zu optimieren. Eure Fragen und Rückmeldungen haben geholfen, die Inhalte zielgerichtet zu verbessern und praxisnäher zu gestalten.

Ein herzliches Dankeschön auch an Kurt Munter, den Bereichsleiter der Informatik an der HFTM, der stets ein offenes Ohr hat und mich bei Fragen und Anliegen jederzeit unterstützt. Seine Gespräche und Hinweise haben massgeblich dazu beigetragen, das Projekt erfolgreich voranzubringen.

:::{important} Lernziele

1. **Bedeutung erkennen:** Die Lesenden verstehen, weshalb Datenbanken in einer digitalisierten Welt unverzichtbar sind und welche Vorteile sie für Unternehmen und Organisationen bieten.  
2. **Verschiedene Datenbanktypen kennen:** Sie erhalten einen Überblick über relationale und alternative Datenbankmodelle (z. B. NoSQL) und lernen die Einsatzgebiete dieser Technologien einzuschätzen.  
3. **Strukturierung und Modellierung:** Sie sind in der Lage, komplexe Datenstrukturen in relationalen Datenbanken abzubilden, dabei Konzepte wie Normalisierung zu nutzen und sinnvolle Tabellen- sowie Beziehungsschemata zu entwerfen.  
4. **Effiziente Datenverwaltung:** Sie lernen, Daten mithilfe von SQL und praktischen Tools sicher abzulegen, abzufragen und zu verwalten.  
5. **Auswertung und Praxisbezug:** Sie können umfangreiche Abfragen formulieren, Daten analysieren und die gewonnenen Erkenntnisse in praxisnahen Kontexten (z. B. Berichten, Visualisierungen) sinnvoll einsetzen.
:::