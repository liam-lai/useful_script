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
``` sql
select count(*) OVER() AS full_count
```

### pagination
``` sql
LIMIT ${limit} OFFSET ${offset}
```

### audit on table
https://wiki.postgresql.org/wiki/Audit_trigger

COPY / PASTE Below
``` sql
-- create a schema named "audit"
create schema audit;
revoke create on schema audit from public;

create table audit.logged_actions (
    schema_name text not null,
    table_name text not null,
    user_name text,
    action_tstamp timestamp with time zone not null default current_timestamp,
    action TEXT NOT NULL check (action in ('I','D','U')),
    original_data text,
    new_data text,
    query text
) with (fillfactor=100);

revoke all on audit.logged_actions from public;

-- You may wish to use different permissions; this lets anybody
-- see the full audit data. In Pg 9.0 and above you can use column
-- permissions for fine-grained control.
grant select on audit.logged_actions to public;

create index logged_actions_schema_table_idx 
on audit.logged_actions(((schema_name||'.'||table_name)::TEXT));

create index logged_actions_action_tstamp_idx 
on audit.logged_actions(action_tstamp);

create index logged_actions_action_idx 
on audit.logged_actions(action);

--
-- Now, define the actual trigger function:
--
```
``` sql
CREATE OR REPLACE FUNCTION audit.if_modified_func() RETURNS trigger AS $body$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /*  If this actually for real auditing (where you need to log EVERY action),
        then you would need to use something like dblink or plperl that could log outside the transaction,
        regardless of whether the transaction committed or rolled back.
    */

    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */

    if (TG_OP = 'UPDATE') then
        v_old_data := ROW(OLD.*);
        v_new_data := ROW(NEW.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,original_data,new_data,query) 
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    elsif (TG_OP = 'DELETE') then
        v_old_data := ROW(OLD.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,original_data,query)
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    elsif (TG_OP = 'INSERT') then
        v_new_data := ROW(NEW.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,new_data,query)
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    else
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    end if;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN others THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, audit;

--
-- To add this trigger to a table, use:
-- CREATE TRIGGER tablename_audit
-- AFTER INSERT OR UPDATE OR DELETE ON tablename
-- FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
--
```

Adjust the table name
``` sql
CREATE TRIGGER t_if_modified_trg 
AFTER INSERT OR UPDATE OR DELETE ON table_name
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
```

Result
```

 schema_name |   table_name   | user_name |         action_tstamp         | action |  original_data   |     new_data     |                   query
-------------+----------------+-----------+-------------------------------+--------+------------------+------------------+-------------------------------------------
 public      | source_meeting | digital   | 2021-09-22 14:51:34.833251+10 | I      |                  | (1,,,,,,,,,,,,,) | insert into source_meeting(id) values(1);
 public      | source_meeting | digital   | 2021-09-22 14:52:44.192861+10 | D      | (1,,,,,,,,,,,,,) |                  | delete FROM source_meeting where id = 1  +
             |                |           |                               |        |                  |                  | ;
(2 rows)
```