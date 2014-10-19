module Main where

import Control.Applicative((<$>))
import Controllers.Home (home, login, foo, newUser, createUser, createPostS, getAllUsers, foor)
import Controllers.CreateDb (initDB)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (addBase, noDots, staticPolicy, (>->))
import System.Environment (getEnv)
import Web.Scotty (middleware, scotty)

main :: IO()
main = do
  initDB --creates DB or connects
  scotty 3000 $ do
    middleware $ staticPolicy (noDots >-> addBase "Static/images") -- for favicon.ico
    home >> login >> foo >> createUser >> createPostS >> newUser >> getAllUsers >> foor
