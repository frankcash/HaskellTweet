{-# LANGUAGE OverloadedStrings #-}

module Views.CreateUser (createUserView) where

import Client.CSS (layoutCss)
import Data.Monoid (mempty)
import Data.Text.Lazy(toStrict)
import Prelude hiding (div, head, id)
import Text.Blaze.Html (Html, toHtml)
import Text.Blaze.Html5 (Html, a, body, button, dataAttribute, div, docTypeHtml,form, h1, h2, head, input, li, link, meta, p, form, script, style, title, ul, (!))
import Text.Blaze.Html5.Attributes (charset, class_, content, href, httpEquiv, id, media, name, placeholder, rel, src, type_)
import Views.Utils (blaze, pet)
import Web.Scotty (ActionM)


layout :: Html -> Html -> Html
layout t b = docTypeHtml $ do
           pet "<!--[if lt IE 7]>      <html class='no-js lt-ie9 lt-ie8 lt-ie7'><p>pls dont use this site.</p><![endif]-->"
           pet "<!--[if IE 7]>         <html class='no-js lt-ie9 lt-ie8'/><p>pls dont use this site.</p><![endif]-->"
           pet "<!--[if IE 8]>         <html class='no-js lt-ie9'><p>pls dont use this site.</p><![endif]-->"
           pet "<!--[if gt IE 8]><!--> <html class='no-js'> <!--<![endif]-->"
           head $ do
             title t
             meta ! charset "utf-8"
             meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge,chrome=1"
             meta ! name "description" ! content "Inspire Text"
             meta ! name "viewport" ! content "width=device-width"
             link ! href "//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" ! rel  "stylesheet" ! media "screen"
             style $ pet $ toStrict layoutCss
           body $ do
             navBar >> b
             script ! src "//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" $ mempty
             script ! src "//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" $ mempty

createUserView :: ActionM ()
createUserView = blaze $ layout "home" $ do
             script ! src "//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" $ mempty
             div ! class_ "container" $ do
               div ! class_ "loginArea" $ do
                 form ! class_ "form-signin" $ do
                  h1 "Create New User:"
                  input ! class_ "form-control username form-space" ! placeholder "username"
                  input ! class_ "form-control pass form-space" ! placeholder "password"
                  script "$('.pass').hover(function(){console.log('f');})"
                  input ! class_ "form-control email form-space" ! placeholder "email address"
                  input ! class_ "form-control blurb form-space" ! placeholder "blurb"
                  button ! type_ "submit"
                         ! class_ "btn btn-lg btn-primary btn-block"  $ "Submit"

navBar :: Html
navBar = div ! class_ "navbar navbar-default navbar-static-top" $ div ! class_ "container" $ do
           div ! class_ "navbar-header" $ do
             button ! type_ "button"
                    ! class_ "navbar-toggle" ! dataAttribute "toggle" "collapse" ! dataAttribute "target" ".navbar-collapse" $ do
               a ! class_ "navbar-brand" ! href "#" $ "λ"
           div ! class_ "navbar-collapse collapse" $ ul ! class_ "nav navbar-nav" $ do
             li $ a ! href "/" $ "Home"
             li $ a ! href "#about" $ "About"
             li ! class_ "active" $ a ! href "/login" $ "Login"
