module Application (
    run
) where

import Data.Matrix
import Text.Printf
import Levenshtein

menu :: IO String
menu = do
    printf "1. Левенштейн: рекурсивный алгоритм\n\
    \2. Левенштейн: рекурсивный алгоритм с мемоизацией\n\
    \3. Левенштейн: итеративный алгоритм\n\
    \4. Дамерау-Левенштейн: итеративный алгоритм\n"

    n <- getLine
    return n

getStrings :: IO (String, String)
getStrings = do
    printf "Введите первую строку: \n"
    s1 <- getLine
    printf "Введите вторую строку: \n"
    s2 <- getLine
    return (s1, s2)

run :: IO ()
run = do
    (s1, s2) <- getStrings
    n <- menu

    let matrix = case n of {
        "3" -> levenshteinIterative s1 s2;
        "4" -> damerauLevenshtein s1 s2;
        _ -> fromList 0 0 []
    }

    if null matrix then
        return ()
    else
        printf $ show matrix

    let distance = case n of {
        "1" -> levenshteinRecursion s1 s2;
        "2" -> levenshteinMemoized s1 s2;
        "3" -> getDistance matrix;
        "4" -> getDistance matrix;
    }

    printf "\nДистанция: %d\n" distance

    run
