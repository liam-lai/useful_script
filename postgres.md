# Postgres

### trouble shooting process
1. enable slow query log (100 ms)
2. explain analyze query
3. check if it use right index as you image


### some parameter
* random_page_cost
* work_mem
  * total memory allocate to single query. If you see `Recheck Cond` and `lossy block`, then memory you can tune this number.


### get total results rows before limit
```
count(*) OVER() AS full_count
```

### pagination
```
LIMIT ${limit} OFFSET ${offset}
```