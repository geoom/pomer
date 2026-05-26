module Main where

import Pomer.Timer (runCounter)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  runCounter $ case args of
    [] -> Nothing
    _ -> Just (unwords args)
