{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
  (home
  , login
  , foo
  , createUser
  , foor
  ) where

import Web.Scotty (ScottyM, ActionM, get, html, param)
import Data.Monoid (mconcat)
import Views.Home (homeView)
import Views.Foor (foorView)


home :: ScottyM ()
home = get "/" homeView

login :: ScottyM()
login = get "/login" $ html "login"

foo :: ScottyM()
foo = get "/foo" $ html "Hello, this is foo!"

-- createUser :: ScottyM()
-- createUser =

createUser :: ScottyM()
createUser = get "/create/user/:userId/:name" $ do
  name <- param "name"
  userId <- param "userId"
  html $ mconcat ["<p>/create/user/" , userId , "/" , name ,"</p>"]



foor :: ScottyM()
foor = get "/404"  foorView
