{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
  (home
  , login
  , foo
  , createUser
  , getAllUsers
  , foor
  ) where

import Control.Monad
import Web.Scotty (ScottyM, ActionM, get, html, param, text)
import Data.Monoid (mconcat)
import Views.Home (homeView)
import Views.Foor (foorView)
import Database.HDBC
import Database.HDBC.Sqlite3
import Control.Monad.Trans ( MonadIO(liftIO) )
import Data.Convertible


home :: ScottyM ()
home = get "/" homeView

login :: ScottyM()
login = get "/login" $ html "login"

foo :: ScottyM()
foo = get "/foo" $ html "Hello, this is foo!"

-- createUser :: ScottyM()
-- createUser =
-- createUser ::  Connection -> Redis a -> ActionM a -- correct, but not this use case
-- createUser ::  ActionM a -> Connection -> IO() -- need to figure out

createUser ::  ScottyM()
createUser = get "/create/user/:userId/:name" $ do
  name <- param "name"
  userId <- param "userId"
  liftIO $ createUserDB name userId -- monad transform
  html $ mconcat ["<p>/create/user/" , userId , "/" , name ,"</p>"]

getAllUsers = get "/users/all" $ do
  usersL <- liftIO $ getUsersDB
  text <- liftIO $ usersL
  "foo"

foor :: ScottyM()
foor = get "/404"  foorView

-- createUserDB :: a1 -> a0 -> IO()
createUserDB name userId = do
  conn <- connectSqlite3 databaseFilePath
  run conn "INSERT INTO users VALUES (? , ?)" [toSql $ userId, toSql $ name]
  commit conn
  disconnect conn


getUsersDB = do
  conn <- connectSqlite3 databaseFilePath
  usersF <- run conn "SELECT name FROM users VALUES (? )" []
  commit conn
  disconnect conn
  return(usersF)


databaseFilePath = "data/hacktober.db"
