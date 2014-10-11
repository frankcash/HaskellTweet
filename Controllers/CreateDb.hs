{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (
                            initDB
                            , createUserDB
                            ) where

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


createUserDB name userId = do
  conn <- connectSqlite3 databaseFilePath
  run conn "INSERT INTO users VALUES (? , ?)" [toSql $ userId, toSql $ name]
  commit conn
  disconnect conn

databaseFilePath = "data/hacktober.db"
