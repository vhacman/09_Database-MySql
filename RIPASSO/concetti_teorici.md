# Concetti Teorici SQL — Ripasso

---

## 1. SELECT e Proiezione

```sql
SELECT first_name, last_name, happiness_total FROM citizen;
```

La **proiezione** è la scelta delle colonne da visualizzare. Con `SELECT *` si ottengono tutte le colonne; elencando i campi si sceglie esplicitamente quali mostrare.

---

## 2. Colonne Calcolate — Espressioni Aritmetiche

```sql
SELECT name, base_market_price + (base_market_price * 22 / 100) AS prezzo_ivato
FROM resource
WHERE is_processed = false;
```

Nella `SELECT` è possibile usare **espressioni aritmetiche** (`+`, `-`, `*`, `/`) direttamente sui campi per creare colonne calcolate al volo, senza modificare i dati. Il risultato va di solito rinominato con `AS`.

---

## 3. WHERE — Filtraggio delle righe

```sql
WHERE first_name <> 'El Presidente'
WHERE is_rebel = true AND age >= 18
WHERE last_name = 'Castro'
```

La clausola `WHERE` filtra le righe prima di qualsiasi aggregazione. Operatori comuni:
- Confronto: `=`, `<>`, `<`, `>`, `<=`, `>=`
- Logici: `AND`, `OR`, `NOT`
- `<>` equivale a `!=` (diverso da)

---

## 4. Operatore IN

```sql
SELECT name, base_market_price
FROM resource
WHERE name IN ('Mais', 'Oro');
```

`IN` confronta un campo con una **lista di valori**: restituisce le righe in cui il campo corrisponde ad almeno uno dei valori elencati. È equivalente a scrivere più condizioni `OR` ma molto più leggibile.

```sql
-- equivalente a:
WHERE name = 'Mais' OR name = 'Oro'
```

---

## 5. Operatore BETWEEN

```sql
WHERE gender = 'M'
  AND age > 45
  AND happiness_total BETWEEN 40 AND 80;
```

`BETWEEN min AND max` filtra i valori in un **intervallo inclusivo** (estremi compresi). Funziona con numeri, date e stringhe.

```sql
-- equivalente a:
WHERE happiness_total >= 40 AND happiness_total <= 80
```

---

## 6. IS NULL / IS NOT NULL

```sql
WHERE input_resource_id IS NULL
  AND output_resource_id IS NOT NULL
```

`NULL` rappresenta l'assenza di un valore. Non si confronta con `=` o `<>` ma con:
- `IS NULL` — il campo è vuoto/assente
- `IS NOT NULL` — il campo ha un valore

Può essere usato sia nella `WHERE` che come condizione aggiuntiva in un `JOIN`.

```sql
-- nella condizione ON di un JOIN:
INNER JOIN resource ON resource.id = BuildingType.output_resource_id
                    AND BuildingType.input_resource_id IS NULL
```

---

## 7. ORDER BY e LIMIT

```sql
ORDER BY happiness_total DESC LIMIT 10;
```

- `ORDER BY` ordina il risultato: `ASC` (default, crescente) o `DESC` (decrescente).
- `LIMIT n` tronca il risultato alle prime `n` righe — utile per top-N query.

---

## 8. Funzioni Aggregate

| Funzione | Significato |
|---|---|
| `COUNT(*)` | Conta il numero di righe |
| `AVG(campo)` | Calcola la media |
| `SUM(campo)` | Somma i valori |
| `MIN(campo)` | Valore minimo |
| `MAX(campo)` | Valore massimo |

Le funzioni aggregate **collassano più righe in un unico valore**.

```sql
SELECT avg(salary) AS average FROM citizen;
```

---

## 9. GROUP BY — Raggruppamento

```sql
SELECT wealth_level, COUNT(*) AS n, AVG(happiness_total) AS averageHappiness
FROM citizen
GROUP BY wealth_level;
```

`GROUP BY` divide le righe in gruppi basati su uno o più campi, poi applica le funzioni aggregate **per ogni gruppo** separatamente.

**Regola fondamentale:** nella `SELECT`, ogni colonna non aggregata **deve** comparire nel `GROUP BY`.

### GROUP BY su più colonne

```sql
GROUP BY gender, education_level
ORDER BY education_level, gender;
```

Si possono raggruppare su più campi contemporaneamente: ogni combinazione unica di valori forma un gruppo distinto.

---

## 10. Alias (AS) — Colonne e Tabelle

```sql
-- alias di colonna
SELECT COUNT(*) AS n, AVG(salary) AS averageSalary

-- alias di tabella
SELECT bt.name AS buildingName, resource.name AS resourceName
FROM BuildingType bt
INNER JOIN resource ON resource.id = bt.output_resource_id
```

`AS` assegna un nome alternativo a:
- **Colonne calcolate** — per rendere il risultato leggibile.
- **Tabelle** — per abbreviare il nome nelle condizioni `ON`, `WHERE` e `SELECT`. L'alias di tabella può essere scritto anche senza `AS` (es. `FROM BuildingType bt`).

---

## 11. Prodotto Cartesiano (da evitare)

```sql
-- ERRATO
SELECT * FROM citizen, building;
```

Elencare più tabelle nella `FROM` senza una condizione di join produce il **prodotto cartesiano**: ogni riga della prima tabella viene combinata con ogni riga della seconda. Il risultato è enorme e privo di senso semantico.

> Con 1000 cittadini e 50 edifici → 50.000 righe senza significato.

---

## 12. INNER JOIN

```sql
SELECT * FROM building
INNER JOIN buildingType ON building.building_type_id = buildingType.id;
```

`INNER JOIN` collega due tabelle sulla base di una condizione (tipicamente chiave esterna = chiave primaria). Restituisce **solo le righe che hanno una corrispondenza in entrambe le tabelle**.

### JOIN a catena su più tabelle

```sql
FROM resource
INNER JOIN buildingType ON resource.id = buildingType.output_resource_id
INNER JOIN building     ON buildingType.id = building.building_type_id
INNER JOIN citizen      ON citizen.job_building_id = building.id
WHERE resource.name = 'Mais';
```

### Condizione aggiuntiva nell'ON

```sql
INNER JOIN resource ON resource.id = BuildingType.output_resource_id
                    AND BuildingType.input_resource_id IS NULL
```

La clausola `ON` può includere condizioni aggiuntive oltre alla chiave: in questo caso filtra già durante il join invece che nella `WHERE`.

---

## 13. LEFT JOIN

```sql
SELECT * FROM citizen
LEFT JOIN building ON citizen.home_building_id = building.id;
```

`LEFT JOIN` restituisce **tutte le righe della tabella sinistra** (citizen), anche se non esiste una corrispondenza nella tabella destra. Dove manca, le colonne destre appaiono come `NULL`.

| Tipo JOIN | Righe restituite |
|---|---|
| `INNER JOIN` | Solo le righe con corrispondenza in entrambe le tabelle |
| `LEFT JOIN` | Tutte le righe della tabella sinistra + NULL a destra se assente |
| `RIGHT JOIN` | Tutte le righe della tabella destra + NULL a sinistra se assente |

---

## 14. Subquery (Query Annidata)

```sql
SELECT COUNT(*) * 100
       / (SELECT COUNT(*) FROM citizen WHERE age >= 18)
       AS rebelPercentage
FROM citizen
WHERE is_rebel = true AND age >= 18;
```

Una **subquery** è una query `SELECT` annidata all'interno di un'altra query. Può comparire:
- Nella `SELECT` (subquery scalare — restituisce un singolo valore)
- Nella `WHERE` (es. `WHERE id IN (SELECT ...)`)
- Nella `FROM` (tabella derivata)

---

## Riepilogo dei Concetti per Query

| File | Concetti principali |
|---|---|
| `sqlex00` | INNER JOIN tra due tabelle |
| `sqlex01` | GROUP BY, COUNT, AVG |
| `sqlex02` | Subquery scalare, calcolo percentuale |
| `sqlex03` | GROUP BY, AVG, alias colonna |
| `sqlex04` | GROUP BY su più colonne, ORDER BY multiplo |
| `sqlex05` | WHERE con esclusione, ORDER BY DESC, LIMIT |
| `sqlex06` | INNER JOIN su 4 tabelle, WHERE su stringa |
| `sqlex07` | Prodotto cartesiano (errore), INNER JOIN su 4 tabelle, AVG |
| `sqlex08` | LEFT JOIN, valori NULL |
| `tropicoMonAmout002` | Operatore IN, filtro su lista di valori |
| `tropicoMonAmout003` | Colonne calcolate, espressioni aritmetiche, IS NULL/false |
| `tropicoMonAmout004` | SELECT con proiezione e WHERE su stringa |
| `tropicoMonAmout005` | BETWEEN, AND multipli |
| `tropicoMonAmout006` | INNER JOIN con condizione IS NULL nell'ON |
| `tropicoMonAmout006type2` | IS NULL / IS NOT NULL nella WHERE (alternativa al JOIN) |
| `tropicoMonAmout007` | INNER JOIN con alias di tabella |
| `tropicoMonAmout007.1` | INNER JOIN con alias di colonna e di tabella |
