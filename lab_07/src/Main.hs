module Main where

import System.IO
import Text.Printf
import Dictionary

menu :: IO String
menu = do
    printf "1. Линейный поиск\n\
    \2. Бинарный поиск\n\
    \3. Частотный анализ\n"

    n <- getLine
    return n


getKey :: IO Int
getKey = do 
    printf "Введите ключ: \n"
    key <- getLine 
    return (read key :: Int)
    

divider :: Int 
divider = 10


main :: IO ()
main = do
    mode <- menu
    key <- getKey
    dictionary <- openFile "data/dataset.txt" ReadMode >>= hGetContents >>= return . generateDict

    let value = case mode of {
        "1" -> simpleSearch dictionary key;
        "2" -> binarySearch dictionary key;
        "3" -> frequencyAnalysis dictionary key divider;
    }
    
    print value
