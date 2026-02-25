<div align="center">

# Mod01-02-03-04 — DDL, DML e Query Aggregate

Fondamentali di MySQL: creazione tabella, manipolazione dati e query di selezione con funzioni aggregate.

</div>

---

## Database

```sql
USE ex00;
```

---

## File SQL — Esecuzione in Ordine

| # | File | Operazione | Descrizione |
|---|------|-----------|-------------|
| 1 | `01_create_table.sql` | `CREATE TABLE` | Crea la tabella PEOPLE con 8 campi e constraint `CHECK` |
| 2 | `02_insert_10_people.sql` | `INSERT` | Inserisce 10 persone (3 minorenni con salary = 0) |
| 3 | `03_update_roles.sql` | `UPDATE` | Aggiorna i ruoli usando `IN` (5 RESEARCHER, 5 FOREST GUARDIAN) |
| 4 | `04_delete_minors.sql` | `DELETE` | Elimina i minorenni con `DATEDIFF(CURDATE(), dob) / 365.25 < 18` |
| 5 | `05_insert_10_more.sql` | `INSERT` | Inserisce altri 10 record (totale finale: 17 persone) |
| 6 | `06_select_queries.sql` | `SELECT` | 6 query progressive su WHERE, LIKE, ORDER BY, CONCAT, YEAR |
| 7 | `07_aggregate_queries.sql` | Aggregate | 5 query con GROUP BY, AVG, MIN, MAX, COUNT |

---

## Schema: PEOPLE

| Campo | Tipo | Vincolo | Note |
|-------|------|---------|------|
| `id` | `INT AUTO_INCREMENT` | PRIMARY KEY | |
| `firstname` | `VARCHAR(100)` | NOT NULL | |
| `lastname` | `VARCHAR(100)` | NOT NULL | |
| `dob` | `DATE` | NOT NULL | Data di nascita |
| `city` | `VARCHAR(50)` | NOT NULL, CHECK | `RACCOON VILLE` \| `LISBON` \| `NEW YORK` |
| `role` | `VARCHAR(50)` | NOT NULL, DEFAULT `EXPLORER` | `RESEARCHER` \| `FOREST GUARDIAN` \| `EXPLORER` |
| `salary` | `DECIMAL(10,2)` | NOT NULL, DEFAULT `0.00` | Stipendio mensile in euro |
| `gender` | `VARCHAR(1)` | NOT NULL, CHECK | `M` \| `F` |

---

## Dettaglio Query

### `06_select_queries.sql` — SELECT progressive

| Query | Filtri applicati |
|-------|-----------------|
| 1 | Residenti di RACCOON VILLE |
| 2 | RACCOON VILLE + età > 30 anni |
| 3 | RACCOON VILLE o LISBON + età 20-30 + salary > 2000 |
| 4 | Come query 3 + `ORDER BY salary DESC` |
| 5 | Come query 4 + `lastname LIKE '%e%'` |
| 6 | Come query 5 + `CONCAT(firstname, ' ', lastname) AS citizen` + `YEAR(dob)` |

### `07_aggregate_queries.sql` — Funzioni Aggregate

| Query | Aggregazione |
|-------|-------------|
| 1 | `AVG(salary)` raggruppato per `role` |
| 2 | `AVG(salary)` raggruppato per `role` + `gender` |
| 3 | Come query 2 + `WHERE` esclude under 20 |
| 4 | Come query 3 + `MIN(salary)`, `MAX(salary)` |
| 5 | Come query 4 + `ORDER BY role` |

---

## Concetti Coperti

| Categoria | Comandi / Funzioni |
|-----------|--------------------|
| **DDL** | `CREATE TABLE`, `DROP TABLE IF EXISTS`, `CHECK`, `DEFAULT`, `AUTO_INCREMENT` |
| **DML** | `INSERT`, `UPDATE ... WHERE IN (...)`, `DELETE` |
| **Filtri** | `WHERE`, `AND`, `IN`, `LIKE`, `BETWEEN` |
| **Ordinamento** | `ORDER BY ... ASC / DESC` |
| **Funzioni scalari** | `CONCAT`, `YEAR`, `CURDATE`, `DATEDIFF` |
| **Funzioni aggregate** | `COUNT`, `AVG`, `MIN`, `MAX` |
| **Raggruppamento** | `GROUP BY` su una o più colonne |

---

<div align="center">

**Hacman Viorica Gabriela** | Generation Italy — Java Full Stack Developer

[Torna al README principale](../README.md)

</div>
