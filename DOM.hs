module DOM where

data Node
  = T String
  | E String [(String, String)] [Node] -- TODO: Maybe [Node].

instance Show Node where
  show (T string) = string
  show (E tag attributes nodes) =
    let
      showAttribute (key, val) = " " ++ key ++ "='" ++ val ++ "'"
    in
         "<" ++ tag ++ mconcat (map showAttribute attributes) ++ ">"
      ++ mconcat (map show nodes)
      ++ "</" ++ tag ++ ">"

data Document = Document [Node]
instance Show Document where
  show (Document nodes) = "<!doctype html>\n" ++ (show $ E "html" [] nodes)

-- Containers
metadata = E "head" []
body = E "body" []
p = E "p" []
h1 = E "h1" []
h2 = E "h2" []
ulWith attrs elements = E "ul" attrs $ map (E "li" []) elements
ulWithId id elements = ulWith [("id", id)] elements
ul elements = ulWith [] elements

-- Sugar
text = T
blank = T ""

-- Sugary elements
title t = E "title" [] [ text t ]
link href t = E "a" [("href", href)] [ text t ]

-- Meta things
refStylesheet filename = E "link" [ ("href", filename)
                                  , ("rel", "stylesheet")
                                  ] []
