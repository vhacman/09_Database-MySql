<div align="center">

# Mod05-06 — JOIN e Foreign Key

Relazioni tra tabelle in MySQL: chiavi esterne, `INNER JOIN` e query aggregate su dati collegati.

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
| 1 | `01_create_auto_tables.sql` | `CREATE TABLE` | Crea PROPRIETARI e AUTO con FK (`ON DELETE CASCADE`) |
| 2 | `02_insert_sample_data.sql` | `INSERT` | Inserisce 8 proprietari e 12 auto |
| 3 | `03_queries_esercizi.sql` | `SELECT` + `JOIN` | 4 query con INNER JOIN, filtri e GROUP BY |

---

## Schema

### Tabella: PROPRIETARI

| Campo | Tipo | Vincolo |
|-------|------|---------|
| `id` | `INT AUTO_INCREMENT` | PRIMARY KEY |
| `nome` | `VARCHAR(100)` | NOT NULL |
| `cognome` | `VARCHAR(100)` | NOT NULL |
| `citta` | `VARCHAR(50)` | NOT NULL |

### Tabella: AUTO

| Campo | Tipo | Vincolo |
|-------|------|---------|
| `id` | `INT AUTO_INCREMENT` | PRIMARY KEY |
| `modello` | `VARCHAR(100)` | NOT NULL |
| `targa` | `VARCHAR(20)` | NOT NULL, UNIQUE |
| `prezzo` | `DECIMAL(10,2)` | NOT NULL |
| `proprietario_id` | `INT` | FK → `proprietari.id` ON DELETE CASCADE |

**Relazione:** un proprietario può avere più auto (1:N).

---

## Dettaglio Query — `03_queries_esercizi.sql`

| Query | Descrizione |
|-------|-------------|
| 1 | `INNER JOIN` proprietari-auto: nome, cognome, modello, targa, prezzo |
| 2 | Come query 1 + `WHERE targa LIKE '%RM%'` (targhe romane) |
| 3 | Come query 1 + `WHERE citta = 'LISBON'` (solo Lisbona) |
| 4 | `GROUP BY citta` + `COUNT(*)` — numero di auto per città |

---

## Concetti Coperti

| Categoria | Comandi / Funzioni |
|-----------|--------------------|
| **DDL** | `CREATE TABLE`, `FOREIGN KEY`, `ON DELETE CASCADE`, `UNIQUE` |
| **DML** | `INSERT` |
| **JOIN** | `INNER JOIN ... ON` |
| **Filtri** | `WHERE`, `LIKE` |
| **Aggregate** | `COUNT(*)`, `GROUP BY`, `ORDER BY` |

---

<div align="center">

**Hacman Viorica Gabriela** | Generation Italy — Java Full Stack Developer

[Torna al README principale](../README.md)

</div>
