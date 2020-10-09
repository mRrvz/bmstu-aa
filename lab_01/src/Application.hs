module Application (
    run
) where

import Data.Matrix
import Data.Maybe
import System.Clock
import Text.Printf

import Levenshtein
import Analysis

type Time = Integer

menu :: IO String
menu = do
    printf "1. Расстояние Левенштейна: рекурсивный алгоритм\n\
    \2. Расстояние Левенштейна: рекурсивный алгоритм с мемоизацией\n\
    \3. Расстояние Левенштейна: итеративный алгоритм\n\
    \4. Расстояние Дамерау-Левенштейна: итеративный алгоритм\n"

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

    let results = case n of {
        "1" -> levenshteinRecursion s1 s2;
        "2" -> levenshteinMemoized s1 s2;
        _ ->  getResults $ fromJust matrix;
    }

    end <- getTime Monotonic

    let time = case matrix_time of {
        Just time -> Just time;
        Nothing -> Just $ calculateTime start end;
    }

    let memory_usage = case n of {
        "1" -> calcMemory (snd results) (length s1) $ length s2;
        "2" -> calcMatrixMemory (snd results) (length s1) $ length s2;
        _ -> calcMatrixMemory 1 (length s1) $ length s2
    }

    printf "\nДистанция: %d\nВремя: %d (наносек)\nГлубина: %d\nКоличество задействованной памяти: %d (байт)\n"
        (fst results) (fromJust time) (snd results) memory_usage

    run
