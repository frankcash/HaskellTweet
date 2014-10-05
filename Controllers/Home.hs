{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
  (home
  , login
  , foo
  ) where

import Views.Home (homeView)
import Web.Scotty (ScottyM, get, html)

home :: ScottyM ()
home = get "/" homeView

login :: ScottyM()
login = get "/login" $ html "login"

foo :: ScottyM()
foo = get "/foo" $ html "Hello, this is foo!"
