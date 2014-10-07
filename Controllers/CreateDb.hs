{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (initDB) where

import Database.HDBC
import Database.HDBC.Sqlite3



initDB = do
  conn <- connectSqlite3 databaseFilePath
  run conn ("CREATE TABLE podcasts" ++
               " ( id     INTEGER PRIMARY KEY ASC " ++
               " , number INTEGER NOT NULL " ++
               " , topics TEXT NOT NULL " ++
               " , guests TEXT NOT NULL " ++
               " , start_ INTEGER NOT NULL ) ") []
  commit conn
  disconnect conn
  return ()

databaseFilePath = "data/hacktober.db"
