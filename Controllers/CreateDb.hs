{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (
                            initDB
                            , createUserDB
                            , createPost
                            ) where

import Database.HDBC
import Database.HDBC.Sqlite3


initDB = do
  conn <- connectSqlite3 databaseFilePath
  f <- getTables conn
  disconnect conn
  if length f > 0
    then
      checkTables

    else
      createTables

  -- commit conn
  -- disconnect conn
  return ()


createTables = do
  conn <- connectSqlite3 databaseFilePath
  run conn ("CREATE TABLE users" ++
               " ( uuid INTEGER PRIMARY KEY ASC " ++
               " , name TEXT NOT NULL ) ") []
  commit conn
  disconnect conn
  conn <- connectSqlite3 databaseFilePath
  run conn ("CREATE TABLE posts" ++
               " ( userName INTEGER" ++
               " , post TEXT NOT NULL ) ") []
  commit conn
  disconnect conn

checkTables = do
  conn <- connectSqlite3 databaseFilePath
  run conn ("SELECT * FROM users") []
  commit conn
  disconnect conn


createUserDB name userId = do
  conn <- connectSqlite3 databaseFilePath
  run conn "INSERT INTO users VALUES (? , ?)" [toSql $ userId, toSql $ name]
  commit conn
  disconnect conn

createPost post userId = do
  conn <- connectSqlite3 databaseFilePath
  run conn "INSERT INTO posts VALUES (? , ?)" [toSql $ userId, toSql $ post]
  commit conn
  disconnect conn

databaseFilePath = "data/hacktober.db"
