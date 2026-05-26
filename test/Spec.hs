module Main where

import Control.Monad (unless)
import Data.Time (UTCTime (..), addUTCTime, fromGregorian)
import Pomer.Timer (elapsedSeconds, formatElapsed)

main :: IO ()
main = do
  let start = UTCTime (fromGregorian 2026 9 23) 0
  unless (formatElapsed (elapsedSeconds start (addUTCTime 1 start)) == "00:00:01") $
    fail "elapsed time should format as HH:MM:SS"
