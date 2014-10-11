{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (initDB) where

import Database.HDBC
import Database.HDBC.Sqlite3


initDB = do
  conn <- connectSqlite3 databaseFilePath
  f <- getTables conn
  if length f > 0
    then
      run conn ("SELECT * FROM users") []
    else
      run conn ("CREATE TABLE users" ++
                   " ( uuid INTEGER PRIMARY KEY ASC " ++
                   " , name TEXT NOT NULL ) ") []
  commit conn
  disconnect conn
  return ()

databaseFilePath = "data/hacktober.db"
