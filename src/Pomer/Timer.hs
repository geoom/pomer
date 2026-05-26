module Pomer.Timer where

import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.Time (UTCTime, diffUTCTime, getCurrentTime)

-- | Format as HH:MM:SS.
formatElapsed :: Double -> String
formatElapsed seconds =
  let totalSeconds = floor seconds :: Int
      hours = totalSeconds `div` 3600
      minutes = (totalSeconds `mod` 3600) `div` 60
      secs = totalSeconds `mod` 60
   in pad hours ++ ":" ++ pad minutes ++ ":" ++ pad secs
  where
    pad n = (if n < 10 then "0" else "") ++ show n

elapsedSeconds :: UTCTime -> UTCTime -> Double
elapsedSeconds start now = realToFrac (diffUTCTime now start)

-- | Print elapsed time.
runCounter :: Maybe String -> IO ()
runCounter mTask = do
  start <- getCurrentTime
  case mTask of
    Just task -> putStrLn $ "Task: " ++ task
    Nothing   -> return ()
  putStrLn "Counter started. Press Ctrl+C to stop."
  forever $ do
    now <- getCurrentTime
    putStrLn $ formatElapsed (elapsedSeconds start now)
    threadDelay 1000000
