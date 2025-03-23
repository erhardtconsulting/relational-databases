---
title: "ACID und Transaktionen / Übung 5: Analyse mit PostgreSQL-Systemkatalogtabellen"
author: 
    - Simon Erhardt
date: "23.03.2025"
keywords:
    - ACID
    - Transaktion
---
# Übung 5: Analyse mit PostgreSQL-Systemkatalogtabellen

## Warum ist die Analyse von Transaktionen wichtig?

In komplexen Datenbanksystemen ist es wichtig, laufende Transaktionen, Sperren und potenzielle Probleme überwachen zu können. PostgreSQL bietet verschiedene Systemansichten, die Einblick in den Transaktionsstatus geben.

## Vorbereitung der Umgebung

Für diese Übung benötigst du:

1. Eine laufende PostgreSQL-Datenbank mit der "Verein"-Datenbank (wie in Kapitel 3 eingerichtet)
2. DBeaver oder ein anderes SQL-Tool zur Ausführung von Abfragen
3. Admin-Rechte für den Zugriff auf Systemtabellen (in der Übungsumgebung vorhanden)

## Praktische Übung zur Transaktionsanalyse

### a) Anzeigen aktiver Transaktionen

```sql
-- Zeige alle aktiven Transaktionen
SELECT txid_current(), txid_status(txid_current());

-- Detaillierte Informationen über aktive Transaktionen
SELECT * FROM pg_stat_activity 
WHERE state = 'active' AND query NOT ILIKE '%pg_stat_activity%';
```

### b) Sperrinformationen anzeigen

```sql
-- Zeige alle aktuellen Sperren
SELECT * FROM pg_locks;

-- Zeige blockierte Transaktionen
SELECT blocked_locks.pid AS blocked_pid,
       blocked_activity.usename AS blocked_user,
       blocking_locks.pid AS blocking_pid,
       blocking_activity.usename AS blocking_user,
       blocked_activity.query AS blocked_statement,
       blocking_activity.query AS blocking_statement
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_locks.pid = blocked_activity.pid
JOIN pg_catalog.pg_locks blocking_locks 
    ON blocking_locks.locktype = blocked_locks.locktype
    AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
    AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
    AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
    AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
    AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
    AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
    AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
    AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
    AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
    AND blocking_locks.pid != blocked_locks.pid
JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_locks.pid = blocking_activity.pid
WHERE NOT blocked_locks.GRANTED;
```

### c) Transaktions-Timeouts und -Abbrüche

Um Situationen zu vermeiden, in denen Transaktionen zu lange laufen oder blockieren, können Timeouts konfiguriert werden:

```sql
-- Zeige aktuelle Timeout-Einstellungen
SHOW statement_timeout;
SHOW lock_timeout;
SHOW idle_in_transaction_session_timeout;

-- Timeout für Sperren setzen (5 Sekunden)
SET lock_timeout = '5s';

-- Timeout für inaktive Transaktionen setzen (1 Minute)
SET idle_in_transaction_session_timeout = '1min';
```

## Aufgaben

1. Erzeuge absichtlich eine blockierte Transaktion und analysiere sie mit den obigen Abfragen.
2. Experimentiere mit verschiedenen Timeout-Einstellungen und beobachte deren Auswirkungen.
3. Schreibe eine Überwachungsabfrage, die potenziell problematische Transaktionen (z.B. solche, die länger als 5 Minuten laufen) identifiziert.
