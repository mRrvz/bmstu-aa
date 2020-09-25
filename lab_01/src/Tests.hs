module Tests where

import Levenshtein

tests :: String -> String -> String -> [Int] -> IO ()
tests s1 s2 descr expected = do
    printf descr

    if getResults $ levenshteinRecursion s1 s2 == expected !! 0 then
        printf "Recursion: OK\n"
    else
        printf "Recursion: FAILED\n"

    if levenshteinMemoized s1 s2 == expected !! 1 then
        printf "Memoized: OK\n"
    else
        printf "Memoized: FAILED\n"

    if getResults $ levenshteinIterative s1 s2 == expected !! 2 then
        printf "Iterative: OK\n"
    else
        printf "Iterative: FAILED\n"

    if getResults $ damerauLevenshtein s1 s2 == exptected !! 3 then
        printf "Damerau: OK\n\n"
    else
        printf "Damerau: FAILED\n\n"


main :: IO ()
main = do
    "kot" "skat"
    "kate" "ktae"
    "abacaba" "aabcaab"
    "sobaka" "sboku"
    "qwerty" "queue"
    "apple" "apple"
    "" "cat"
    "parallels" ""
    "bmstu" "utsmb"
