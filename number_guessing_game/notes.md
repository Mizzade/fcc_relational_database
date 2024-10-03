#### Databases
`number_guess`

#### tables
users:
  - user_id: serial, primary key
  - name: varchar(22), not null

games:
  - game_id: serial, primary key, not null
  - user_id, int, foreign key references users.user_id, not null
  - secret_number: int, not null
    guesses: int, not null

```
                                      Table "public.users"
 Column  |         Type          | Collation | Nullable |                Default
---------+-----------------------+-----------+----------+----------------------------------------
 user_id | integer               |           | not null | nextval('users_user_id_seq'::regclass)
 name    | character varying(22) |           | not null |
Indexes:
    "users_pkey" PRIMARY KEY, btree (user_id)
Referenced by:
    TABLE "games" CONSTRAINT "games_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id)

```

```
    Column     |  Type   | Collation | Nullable |                Default
---------------+---------+-----------+----------+----------------------------------------
 game_id       | integer |           | not null | nextval('games_game_id_seq'::regclass)
 user_id       | integer |           | not null |
 secret_number | integer |           | not null |
 guesses       | integer |           | not null | 0
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)
Foreign-key constraints:
    "games_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id)
```
