module Application (
    run
) where

import Data.Matrix
import Data.Maybe
import System.Clock
import Text.Printf
import Levenshtein

type Time = Integer

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


calculateTime :: TimeSpec -> TimeSpec -> Time
calculateTime t1 t2 = toNanoSecs $ diffTimeSpec t2 t1

run :: IO ()
run = do
    (s1, s2) <- getStrings
    n <- menu

    start <- getTime Monotonic

    let matrix = case n of {
        "3" -> Just $ levenshteinIterative s1 s2;
        "4" -> Just $ damerauLevenshtein s1 s2;
        _ -> Nothing;
    }

    end <- getTime Monotonic
    let matrix_time = if n `elem` ["3", "4'"] then Just $ calculateTime start end else Nothing

    case matrix of {
        Just matrix -> printf $ show matrix;
        Nothing -> return ();
    }

    start <- getTime Monotonic

    let distance = case n of {
        "1" -> levenshteinRecursion s1 s2;
        "2" -> levenshteinMemoized s1 s2;
        "3" -> getDistance $ fromJust matrix;
        "4" -> getDistance $ fromJust matrix;
    }

    end <- getTime Monotonic
    let time = case matrix_time of {
        Just time -> Just time;
        Nothing -> Just $ calculateTime start end;
    }

    printf "\nДистанция: %d\nВремя: %d (наносек)\n" distance $ fromJust time

    run
