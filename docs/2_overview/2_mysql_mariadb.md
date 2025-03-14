# MySQL/MariaDB

[MySQL](https://www.mysql.com/) wurde Mitte der 1990er-Jahre entwickelt und schnell zu einer der meistgenutzten Open-Source-Datenbanken  {cite}`mysql_official`. Nach der Übernahme durch Oracle spaltete sich ein Teil der Entwickler ab und gründete [MariaDB](https://mariadb.com/), um die offene Entwicklung fortzuführen {cite}`mariadb_official`.

## Historischer Hintergrund
MySQL wurde ursprünglich von Michael „Monty“ Widenius, David Axmark und Allan Larsson entwickelt. Der Name „MySQL“ leitet sich von Monty Widenius’ Tochter „My“ ab. Durch seine einfache Handhabung und offene Verfügbarkeit etablierte sich MySQL rasch als beliebte Lösung für Webhosting-Provider. MariaDB entstand später, als Befürchtungen laut wurden, dass MySQL durch den neuen Eigentümer Oracle nicht mehr uneingeschränkt offen weiterentwickelt würde.

## Unterscheidung
- **MySQL** ist weiterhin bei Oracle unter einer dualen Lizenzstrategie erhältlich.  
- **MariaDB** ist als vollständig freie Variante verfügbar und kompatibel zu MySQL, zumindest auf der API-Ebene.  

## Einsatzgebiete
- Oft genutzt in Webprojekten mit PHP-Stacks oder Content-Management-Systemen (WordPress, Drupal, etc.)  
- Beliebt bei kleineren bis mittleren Anwendungen  

## Alleinstellungsmerkmale (MySQL/MariaDB)  
- Einfaches Setup  
- Hohe Verbreitung und grosse Community  

## Vor- und Nachteile

| Vorteile                                                           | Nachteile                                                                   |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------- |
| Geringe Einstiegshürden und sehr dokumentiert                      | Oracle-Lizenzpolitik (bei MySQL) kann je nach Einsatzzweck kompliziert sein |
| MySQL: Viele Hosting-Angebote mit vorinstallierten Umgebungen      | Weniger umfangreiche Funktionen als bei PostgreSQL oder Oracle              |
| MariaDB: Offenere Entwicklungscommunity, schnelle Aktualisierungen |                                                                             |

## Wann einsetzen und wann nicht

### Geeignet, wenn 
- Web-basierte Projekte mit begrenzten Ressourcen, bei denen schnelle Einrichtung und leichte Administration gefragt sind.  
- Content-Management-Systeme oder Blogs mit standardisierten Anforderungen.

### Nicht geeignet, wenn
- Ein sehr grosses und skalierbares System mit fortgeschrittenen Funktionen (z.B. umfassende analytische Abfragen) benötigt wird.  
- Höchste Anforderungen an Transaktionssicherheit oder umfangreiche Enterprise-Funktionen bestehen.
