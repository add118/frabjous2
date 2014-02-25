-----------------------------------------------------------------------------
-- |
-- Module      :  Transform
-- Copyright   :  (c) University of Saskatchewan 2013
-- 
-- Maintainer  :  ivan.vendrov@usask.ca
--
-- A library of transformations on Haskell source code for use
-- in the Frabjous compiler. This is the only module in the compiler
-- that depends on a particular abstract syntax for Haskell
------------------------------------------------------------------------------
module Transform (linearizeDecl) where

import qualified Language.Haskell.Exts.Parser as Haskell -- needing for working with haskell source code
import qualified Language.Haskell.Exts.Pretty as Haskell -- needed for working with haskell source code
import qualified Language.Haskell.Exts.Syntax as Haskell




-- | converts a haskell declaration to an equivalent one-line declaration 
-- | by inserting braces and semicolons in accordance with the layout rules
linearizeDecl :: String -> Maybe String
linearizeDecl = (fmap ppOneLine . readDecl) where

ppOneLine = Haskell.prettyPrintWithMode oneLineMode where
    oneLineMode = Haskell.defaultMode {Haskell.layout = Haskell.PPNoLayout}


readDecl:: String -> Maybe Haskell.Decl
readDecl str = case Haskell.parseDecl str of 
             Haskell.ParseOk decl -> Just decl
             _ -> Nothing

