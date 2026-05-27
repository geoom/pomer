module Main where

import Control.Monad (unless)
import Data.Time (UTCTime (..), addUTCTime, fromGregorian)
import Pomer.Timer (elapsedSeconds, formatElapsed, parseTaskArgs)

main :: IO ()
main = do
  let start = UTCTime (fromGregorian 2026 9 23) 0
      elapsedAfter n = elapsedSeconds start (addUTCTime n start)

  checkAll
    [ ("zero elapsed seconds formats as 00:00:00", formatElapsed 0 == "00:00:00")
    , ("one elapsed second formats as 00:00:01", formatElapsed (elapsedAfter 1) == "00:00:01")
    , ("59 seconds does not roll over to a minute", formatElapsed 59 == "00:00:59")
    , ("60 seconds rolls over to one minute", formatElapsed 60 == "00:01:00")
    , ("3599 seconds does not roll over to an hour", formatElapsed 3599 == "00:59:59")
    , ("3600 seconds rolls over to one hour", formatElapsed 3600 == "01:00:00")
    , ("no arguments means no task", parseTaskArgs [] == Nothing)
    , ("a single word is a task label", parseTaskArgs ["write"] == Just "write")
    , ("multiple words join into one task label", parseTaskArgs ["write", "proposal"] == Just "write proposal")
    ]

checkAll :: [(String, Bool)] -> IO ()
checkAll = mapM_ check
  where
    check (label, ok) = unless ok $ fail label
