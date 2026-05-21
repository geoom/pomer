module Main where

import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.Time (diffUTCTime, getCurrentTime)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

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
    let elapsed = realToFrac (diffUTCTime now start) :: Double
    putStrLn $ formatElapsed elapsed
    threadDelay 1000000

main :: IO ()
main = do
  args <- getArgs
  let mTask = case args of
                []  -> Nothing
                _   -> Just (unwords args)
  runCounter mTask
