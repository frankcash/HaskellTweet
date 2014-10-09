{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (initDB) where

import Database.HDBC
import Database.HDBC.Sqlite3



initDB = do
  conn <- connectSqlite3 databaseFilePath
  run conn ("CREATE TABLE users" ++
               " ( uuid INTEGER PRIMARY KEY ASC " ++
               " , name TEXT NOT NULL ) ") []
  commit conn
  disconnect conn
  return ()

databaseFilePath = "data/hacktober.db"
