{-# LANGUAGE OverloadedStrings #-}

module Controllers.CreateDb (
                            initDB
                            , createUserDB
                            , createPost
                            ) where

import Database.HDBC
import Database.HDBC.Sqlite3


initDB :: IO ()
initDB = do
  conn <- connectSqlite3 databaseFilePath
  f <- getTables conn
  disconnect conn
  selectOrBuild (length f)
  return ()


selectOrBuild :: Int -> IO ()
selectOrBuild 0 = createTables
selectOrBuild n = checkTables


createTables :: IO ()
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
