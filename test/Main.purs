module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Text.Smolder.HTML (html, head, meta, link, title, body, h1, p)
import Text.Smolder.HTML.Attributes (lang, charset, httpEquiv, content, name, rel, href)
import Text.Smolder.Markup (on, (#!), Markup, text, unsafeRawText, (!))
import Text.Smolder.Renderer.String (render)

doc :: forall a e. Markup (a -> Eff (console :: CONSOLE | e) Unit)
doc = html ! lang "en" $ do
  head $ do
    meta ! charset "utf-8"
    meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge,chrome=1"
    title $ text "OMG HAI LOL"
    meta ! name "description" ! content "YES OMG HAI LOL\"><script>alert(\"lol pwned\");</script>"
    meta ! name "viewport" ! content "width=device-width"
    link ! rel "stylesheet" ! href "css/screen.css"
  body $ do
    h1 #! on "click" (\_ -> log "click") $ text "OMG HAI LOL"
    p $ text "This is clearly the best HTML DSL ever invented.<script>alert(\"lol pwned\");</script>"
    p $ unsafeRawText "This is <strong>clearly<strong> the <em>best</em> HTML DSL ever invented."

main :: Eff (console :: CONSOLE) Unit
main = log $ render doc
