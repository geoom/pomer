module Main where

import Pomer.Timer (parseTaskArgs, runCounter)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  runCounter (parseTaskArgs args)
