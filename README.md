<div align="center">

# Database — MySQL

Materiale didattico MySQL: DDL, DML, JOIN, integrità referenziale e self join.

</div>

---

## Struttura

| Directory | Contenuto |
|-----------|-----------|
| `Mod01-02-03-04/` | DDL, DML base e query aggregate (tabella PEOPLE) |
| `Mod05-06/` | JOIN tra tabelle con Foreign Key (PROPRIETARI + AUTO) |
| `modulo07/` | LEFT JOIN, integrità referenziale, self join |
| `RIPASSO/` | Ripasso completo: esercizi `sqlex`, database Tropico, teoria SQL |

---

## Script SQL

### Mod01-02-03-04 — DDL, DML e Aggregate

| File | Operazione | Descrizione |
|------|-----------|-------------|
| `01_create_table.sql` | `CREATE TABLE` | Tabella PEOPLE con 8 campi e constraint CHECK |
| `02_insert_10_people.sql` | `INSERT` | Inserimento iniziale di 10 record (3 minorenni) |
| `03_update_roles.sql` | `UPDATE` | Aggiornamento ruoli con `IN` |
| `04_delete_minors.sql` | `DELETE` | Eliminazione minorenni con `DATEDIFF` |
| `05_insert_10_more.sql` | `INSERT` | Inserimento aggiuntivo di 10 record |
| `06_select_queries.sql` | `SELECT` | `WHERE`, `ORDER BY`, `LIKE`, `BETWEEN`, `CONCAT` |
| `07_aggregate_queries.sql` | Aggregate | `GROUP BY`, `AVG`, `MIN`, `MAX`, `COUNT` |

### Mod05-06 — JOIN e Foreign Key

| File | Operazione | Descrizione |
|------|-----------|-------------|
| `01_create_auto_tables.sql` | `CREATE TABLE` | Tabelle PROPRIETARI e AUTO con FK e `ON DELETE CASCADE` |
| `02_insert_sample_data.sql` | `INSERT` | Dati di esempio (8 proprietari, 12 auto) |
| `03_queries_esercizi.sql` | `SELECT` + `JOIN` | `INNER JOIN`, filtri su targa e città, `GROUP BY` + `COUNT` |

### RIPASSO — Esercizi di Ripasso e Database Tropico

Materiale di consolidamento con due serie di esercizi indipendenti.

| File/Serie | Argomento |
|------------|-----------|
| `sqlex00.sql` – `sqlex08.sql` | 9 esercizi progressivi su SELECT, WHERE, JOIN, GROUP BY |
| `ESERCIZI_completi.sql` | Raccolta completa degli esercizi |
| `tropicoMonAmout001.sql` – `tropicoMonAmout015.sql` | 15 esercizi sul database Tropico (tema gestionale isola) |
| `tropico.db` | Database SQLite con dati Tropico per gli esercizi |
| `concetti_teorici.md` | Teoria SQL: proiezione, colonne calcolate, WHERE, IN, GROUP BY, JOIN, subquery |
| `ESERCIZI.odt` / `concetti_teorici.docx` | Documenti di riferimento offline |

---

### modulo07 — LEFT JOIN, Integrità Referenziale, Self Join

| File | Argomento | Descrizione |
|------|-----------|-------------|
| `esercizio5.sql` | LEFT JOIN | Query su CITY + PERSON + AUTO; persone con e senza auto |
| `esercizio6.sql` | FK constraints | Confronto `ON DELETE CASCADE` vs `ON DELETE RESTRICT` |
| `esercizio7.sql` | Self Join | Stessa tabella PERSON con alias; relazione padre-figlio |

---

## Schema delle Tabelle

### PEOPLE (Mod01-02-03-04)

| Campo | Tipo | Note |
|-------|------|------|
| `id` | `INT AUTO_INCREMENT` | Primary Key |
| `firstname` | `VARCHAR(100)` | NOT NULL |
| `lastname` | `VARCHAR(100)` | NOT NULL |
| `dob` | `DATE` | Data di nascita |
| `city` | `VARCHAR(50)` | CHECK: RACCOON VILLE \| LISBON \| NEW YORK |
| `role` | `VARCHAR(50)` | CHECK: RESEARCHER \| FOREST GUARDIAN \| EXPLORER |
| `salary` | `DECIMAL(10,2)` | Default 0.00 |
| `gender` | `VARCHAR(1)` | CHECK: M \| F |

### PROPRIETARI + AUTO (Mod05-06)

| Tabella | Campo chiave | Relazione |
|---------|-------------|-----------|
| `proprietari` | `id` PK | — |
| `auto` | `proprietario_id` FK | → `proprietari.id` ON DELETE CASCADE |

### CITY + PERSON + AUTO (modulo07 — esercizio5)

| Tabella | Campo chiave | Relazione |
|---------|-------------|-----------|
| `CITY` | `id` PK | — |
| `PERSON` | `CITY_ID` FK | → `CITY.id` ON DELETE SET NULL |
| `AUTO` | `OWNER_ID` FK | → `PERSON.id` ON DELETE SET NULL |

---

## Concetti Coperti

| Categoria | Comandi / Funzioni |
|-----------|--------------------|
| **DDL** | `CREATE TABLE`, `DROP TABLE IF EXISTS`, `CHECK`, `DEFAULT` |
| **DML** | `INSERT`, `UPDATE`, `DELETE` |
| **Query** | `SELECT`, `WHERE`, `ORDER BY`, `LIKE`, `BETWEEN`, `IN` |
| **Funzioni** | `CONCAT`, `YEAR`, `CURDATE`, `DATEDIFF` |
| **Aggregate** | `GROUP BY`, `COUNT`, `AVG`, `MIN`, `MAX` |
| **JOIN** | `INNER JOIN`, `LEFT JOIN`, self join con alias |
| **FK** | `FOREIGN KEY`, `ON DELETE CASCADE`, `ON DELETE RESTRICT`, `ON DELETE SET NULL` |

---

## Quick Start

```sql
-- Avvio MySQL
-- mysql -u root -p

-- Creazione database
CREATE DATABASE ex00;
USE ex00;

-- Mod01-02-03-04 (eseguire in ordine)
SOURCE Mod01-02-03-04/01_create_table.sql;
SOURCE Mod01-02-03-04/02_insert_10_people.sql;
SOURCE Mod01-02-03-04/03_update_roles.sql;
SOURCE Mod01-02-03-04/04_delete_minors.sql;
SOURCE Mod01-02-03-04/05_insert_10_more.sql;
SOURCE Mod01-02-03-04/06_select_queries.sql;
SOURCE Mod01-02-03-04/07_aggregate_queries.sql;

-- Mod05-06 (eseguire in ordine)
SOURCE Mod05-06/01_create_auto_tables.sql;
SOURCE Mod05-06/02_insert_sample_data.sql;
SOURCE Mod05-06/03_queries_esercizi.sql;

-- modulo07 (eseguire singolarmente, ogni file è indipendente)
SOURCE modulo07/esercizio5.sql;
SOURCE modulo07/esercizio6.sql;
SOURCE modulo07/esercizio7.sql;

-- RIPASSO — esercizi sqlex (ogni file è indipendente)
SOURCE RIPASSO/sqlex00.sql;
-- ... sqlex01 → sqlex08

-- RIPASSO — esercizi Tropico (ogni file è indipendente, usa tropico.db)
SOURCE RIPASSO/tropicoMonAmout001.sql;
-- ... tropicoMonAmout002 → tropicoMonAmout015
```

**Strumenti consigliati:** MySQL Workbench, DBeaver, phpMyAdmin, CLI

---

<div align="center">

**Hacman Viorica Gabriela** | Generation Italy — Java Full Stack Developer

[Torna al README principale](../README.md)

</div>
