{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
  (home
  , login
  , foo
  , foor
  ) where

import Views.Home (homeView)
import Views.Foor (foorView)
import Web.Scotty (ScottyM, get, html)

home :: ScottyM ()
home = get "/" homeView

login :: ScottyM()
login = get "/login" $ html "login"

foo :: ScottyM()
foo = get "/foo" $ html "Hello, this is foo!"

-- createUser :: ScottyM()
-- createUser =

foor :: ScottyM()
foor = get "/404"  foorView
