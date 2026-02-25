<div align="center">

# modulo07 — LEFT JOIN, Integrità Referenziale, Self Join

Tecniche avanzate di MySQL: join tra più tabelle, comportamento delle chiavi esterne in caso di cancellazione e self join con alias.

</div>

---

## File SQL

| File | Argomento | Descrizione |
|------|-----------|-------------|
| `esercizio5.sql` | LEFT JOIN | Query su tre tabelle (CITY, PERSON, AUTO) con LEFT JOIN |
| `esercizio6.sql` | FK constraints | Confronto pratico `ON DELETE CASCADE` vs `ON DELETE RESTRICT` |
| `esercizio7.sql` | Self Join | Stessa tabella PERSON interrogata con alias; relazione padre-figlio |

> Ogni file è autonomo e crea/ricrea il proprio schema internamente.

---

## esercizio5.sql — LEFT JOIN

### Schema

| Tabella | Campo chiave | Relazione |
|---------|-------------|-----------|
| `CITY` | `id` PK | — |
| `PERSON` | `CITY_ID` FK | → `CITY.id` ON DELETE SET NULL |
| `AUTO` | `OWNER_ID` FK | → `PERSON.id` ON DELETE SET NULL |

### Query

| Query | Descrizione |
|-------|-------------|
| 1 | Tutte le persone con le rispettive auto (anche chi non ne ha) — `LEFT JOIN AUTO` |
| 2 | Solo persone di Lisbona con auto — `LEFT JOIN AUTO` + `INNER JOIN CITY` + `WHERE` |
| 3 | Persone con auto > 20.000 € o senza auto — `LEFT JOIN` + `WHERE cost > 20000 OR cost IS NULL` |

**Concetto chiave:** il `LEFT JOIN` conserva tutte le righe della tabella sinistra anche quando non c'è corrispondenza nella destra (auto NULL per chi non ne possiede).

---

## esercizio6.sql — Integrità Referenziale

Confronto tra due comportamenti della FK al momento della cancellazione del padre.

| Strategia | Comportamento | Tabelle usate |
|-----------|--------------|---------------|
| `ON DELETE CASCADE` | Le auto vengono cancellate automaticamente insieme alla persona | `PERSON_CASCADE`, `AUTO_CASCADE` |
| `ON DELETE RESTRICT` | La cancellazione della persona viene bloccata se ha auto associate | `PERSON_RESTRICT`, `AUTO_RESTRICT` |

**Concetto chiave:** `RESTRICT` mantiene l'integrità richiamando un errore (`Error 1451`); `CASCADE` propaga automaticamente la cancellazione alle righe figlio.

---

## esercizio7.sql — Self Join

### Schema: PERSON

| Campo | Tipo | Note |
|-------|------|------|
| `id` | `INT AUTO_INCREMENT` | PRIMARY KEY |
| `name` | `VARCHAR(100)` | |
| `surname` | `VARCHAR(100)` | |
| `job` | `VARCHAR(100)` | Professione |
| `salary` | `DECIMAL(10,2)` | Stipendio |
| `city` | `VARCHAR(100)` | |
| `gender` | `VARCHAR(20)` | |
| `father_id` | `INT` | Auto-riferimento → `PERSON.id` |

### Query

| Query | Descrizione |
|-------|-------------|
| 1 | Ogni persona abbinata a chi fa lo stesso lavoro ma guadagna meno (`P1.JOB = P2.JOB AND P2.SALARY < P1.SALARY`) |
| 2 | Ogni persona abbinata a tutte le persone della stessa città (`P1.CITY = P2.CITY AND P1.ID != P2.ID`) |
| 3 | Ogni persona con il proprio padre (`FIGLIO.FATHER_ID = PADRE.ID`), inclusa versione con `LEFT JOIN` per chi non ha padre registrato |

**Concetto chiave:** il self join interroga la stessa tabella due volte usando alias diversi (`P1`, `P2` o `FIGLIO`, `PADRE`) per mettere in relazione righe della stessa tabella tra loro.

---

## Concetti Coperti

| Categoria | Comandi / Tecniche |
|-----------|--------------------|
| **JOIN** | `INNER JOIN`, `LEFT JOIN`, self join con alias |
| **FK constraints** | `ON DELETE CASCADE`, `ON DELETE RESTRICT`, `ON DELETE SET NULL` |
| **Filtri** | `WHERE ... IS NULL`, `WHERE cost > x OR cost IS NULL` |
| **Auto-riferimento** | Colonna `father_id` che punta alla stessa tabella (`PERSON.id`) |

---

<div align="center">

**Hacman Viorica Gabriela** | Generation Italy — Java Full Stack Developer

[Torna al README principale](../README.md)

</div>
