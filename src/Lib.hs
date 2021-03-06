module Lib
    ( initGame
    ) where


import Data.List 
    ( intersperse
    , sort
    , nub) 

type Puzzle = String 
type Right = Char
type Wrong = Char
type Guesses = ([Right], [Wrong])

data Status = Undecided | Loss | Win
data Game = Game { puzzle :: Puzzle, guesses :: Guesses } deriving (Show)


-- Utils


replaceIf :: Bool -> a -> a -> a
replaceIf f x y = if f then x else y 


-- UI


obfuscate :: Puzzle -> [Right] -> String
obfuscate p []     = take (length p) $ cycle "_"
obfuscate [] _     = []
obfuscate (x:xs) r = replaceIf (elem x r) x '_' : obfuscate xs r 


stats (r,w) = "\n\n\t\t\tYou have correctly guessed: " ++ (intersperse ',' r) ++   
              "\n\t\t\tYou have incorreclty guessed: " ++ (intersperse ',' w)

-- Mechanics

checkGuess :: Puzzle -> Char -> Bool
checkGuess puzzle guess = elem guess puzzle

updateGuesses :: Puzzle -> Char -> Guesses -> Guesses
updateGuesses puzzle guess (r, w) = if checkGuess puzzle guess 
                                    then (guess:r, w) 
                                    else (r, guess:w)
                          

eval :: Game -> Status
eval (Game { puzzle=p, guesses=(r, w) })
   | (nub . sort) p == sort r = Win
   | length w == 6            = Loss
   | otherwise                = Undecided  


initPuzzle :: IO Game 
initPuzzle = do 
  puzzle' <- getLine
  return $ Game { puzzle = puzzle', guesses = ([], []) } 


turn :: Game -> IO Game 
turn game = do
   let gamePuzzle = intersperse ' ' (obfuscate (puzzle game) (fst $ guesses game))
   putStrLn $ "\n\n\n\t\t\t\t" ++ gamePuzzle
   putStrLn $ stats (guesses game) 
   putStrLn "guess a letter"
   gs <- getChar
   return $ game { guesses = updateGuesses (puzzle game) gs (guesses game) } 
   

play :: Game -> IO ()
play game = do
   putStrLn "Enter a word or phrase"
   t <- turn game
   case eval t of
     Win       -> putStrLn "You Win"
     Loss      -> putStrLn "You Lose"
     Undecided -> play t


initGame :: IO ()
initGame = do 
  g <- initPuzzle
  play g  

