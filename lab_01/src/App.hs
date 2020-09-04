module App (
    run
) where

import Levenshtein

printMenu :: IO ()
printMenu = do
    print "123"

run :: IO ()
run = do
    printMenu
    putStrLn "S1: "
    --s1 <- getLine
    let s1 = "столб"
    putStrLn "S2: "
    --s2 <- getLine
    let s2 = "сито"
    let matr = levenshteinIterative s1 s2
    mapM_ print matr
    --levenshteinIterative s1 s2 >>= print .
    --mapM_ print $ levenshteinIterative
    --mapM_ print matr
    putStrLn "Distance: "
    print $ getDistance matr
    
    run
    --print $ last $ last matr
