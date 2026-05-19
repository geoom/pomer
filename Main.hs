module Main where

import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.Time (diffUTCTime, getCurrentTime)
import System.IO (hFlush, stdout)

-- | Format an elapsed time as HH:MM:SS.
formatElapsed :: Double -> String
formatElapsed seconds =
  let totalSeconds = floor seconds :: Int
      hours = totalSeconds `div` 3600
      minutes = (totalSeconds `mod` 3600) `div` 60
      secs = totalSeconds `mod` 60
   in pad hours ++ ":" ++ pad minutes ++ ":" ++ pad secs
  where
    pad n = (if n < 10 then "0" else "") ++ show n

-- | Run a terminal counter that prints elapsed time every second.
runCounter :: IO ()
runCounter = do
  start <- getCurrentTime
  putStrLn "Counter started. Press Ctrl+C to stop."
  forever $ do
    now <- getCurrentTime
    let elapsed = realToFrac (diffUTCTime now start) :: Double
    putStrLn $ formatElapsed elapsed
    threadDelay 1000000

main :: IO ()
main = runCounter
