{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
  (home
  , login
  , foo
  , createUser
  , createPostS
  , getAllUsers
  , foor
  ) where

import Control.Monad
import Web.Scotty (ScottyM, ActionM, get, html, param, text)
import Data.Monoid (mconcat)
import Views.Home (homeView)
import Views.Foor (foorView)
import Controllers.CreateDb (createUserDB, createPost)
import Database.HDBC
import Database.HDBC.Sqlite3
import Control.Monad.Trans ( MonadIO(liftIO) )
import Data.Convertible


home :: ScottyM ()
home = get "/" homeView

login :: ScottyM()
login = get "/login" $ html "login"

foo :: ScottyM()
foo = get "/foo" $ do
  html "Hello, this is foo!"

-- createUser :: ScottyM()
-- createUser =
-- createUser ::  Connection -> Redis a -> ActionM a -- correct, but not this use case
-- createUser ::  ActionM a -> Connection -> IO() -- need to figure out


getAllUsers :: ScottyM()
getAllUsers = get "/users/all" $ do
  html "hi"


createUser ::  ScottyM()
createUser = get "/create/user/:userId/:name" $ do
  name <- param "name"
  userId <- param "userId"
  liftIO $ createUserDB name userId -- monad transform
  html $ mconcat ["<p>/create/user/" , userId , "/" , name , "</p>"]

createPostS :: ScottyM()
createPostS = get "/create/post/:userId/:post" $ do
  post <- param "post"
  userId <- param "userId"
  liftIO $ createPost post userId
  html $ mconcat ["<p>/create/post/" , userId , "/" , post , "</p>"]

foor :: ScottyM()
foor = get "/404"  foorView


getUsersDB = do
  -- TODO: write a function that takes in [(String, SqlValue)] -> HTML for specific row.
  -- need to Lift and Map this function onto results of getUsersDB
  conn <- connectSqlite3 databaseFilePath
  stmt <- prepare conn "SELECT name FROM users VALUES"
  results <- fetchAllRowsAL stmt
  disconnect conn
  return (results)


databaseFilePath = "data/hacktober.db"
