{-# LANGUAGE OverloadedStrings #-}


import Database.HDBC
import Database.HDBC.Sqlite3

conn <- connectSqlite3 "test1.db"

run conn "CREATE TABLE test (id INTEGER NOT NULL, desc VARCHAR(80))" []
run conn "INSERT INTO test (id) VALUES (0)" []

commit conn
disconnect conn
