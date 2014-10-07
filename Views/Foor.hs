{-# LANGUAGE OverloadedStrings #-}

module Views.Foor (foorView) where

import Client.CSS (layoutCss)
import Data.Monoid (mempty)
import Data.Text.Lazy(toStrict)
import Prelude hiding (div, head, id)
import Text.Blaze.Html (Html, toHtml)
import Text.Blaze.Html5 (Html, a, body,img, button, dataAttribute, div, docTypeHtml,form, h1, h2, head, input, li, link, meta, p, script, title, ul, (!))
import Text.Blaze.Html5.Attributes (charset, class_, content, href, httpEquiv, id, style, media, name, placeholder, rel, src, type_)
import Views.Utils (blaze, pet)
import Web.Scotty (ActionM)

foorView :: ActionM ()
foorView  = blaze $ do
      img ! src "../../torvalds.png"
