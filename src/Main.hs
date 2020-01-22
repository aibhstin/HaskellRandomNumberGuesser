module Main where

import Text.Read (readMaybe)
import Control.Monad (forever)
import System.Exit (exitSuccess)
import System.IO (BufferMode(NoBuffering),
                  hSetBuffering,
                  stdout)
import System.IO.Unsafe
import System.Random (randomRIO)

data InputType a =
    InvalidInput
  | IncorrectGuess Int
  | CorrectGuess
  deriving (Eq, Show)

randomNumber :: Int
randomNumber = unsafePerformIO $ randomRIO (1, 100)


handleInput str = 
  case ((readMaybe str) :: Maybe Int) of
    Just (num) -> handleGuess num randomNumber
    Nothing -> InvalidInput

handleGuess inputNum randomNum = 
  case (inputNum == randomNum) of
    True -> CorrectGuess
    False -> IncorrectGuess inputNum

giveHint num randomNum =
  case (compare num randomNum) of
    LT -> do
      putStrLn "Your guess was too low!"
      return ()
    GT -> do
      putStrLn "Your guess was too high!"
      return ()
    EQ -> do
      putStrLn "If this has printed, something has gone wrong."
      return ()

runGame :: IO ()
runGame = forever $ do
  putStrLn $ "Random number is : " ++ show randomNumber
  putStr "Enter guess: "

  guess <- getLine
  case (handleInput guess) of
    CorrectGuess -> do
      putStrLn "Congratulation! You guessed correctly!"
      exitSuccess
    (IncorrectGuess num) -> do
      putStrLn "You guessed incorrectly."
      giveHint num randomNumber
      return ()
    InvalidInput -> do
      putStrLn "Please enter a valid integer in the range (1-100)"
      return ()

  

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  runGame
