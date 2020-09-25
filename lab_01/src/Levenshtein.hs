module Levenshtein (
    getResults,
    levenshteinMemoized,
    levenshteinRecursion,
    levenshteinIterative,
    damerauLevenshtein,
) where

import System.Clock
import Data.Matrix

type Distance = Int
type Depth = Int
type Time = IO TimeSpec


min3 :: Int -> Int -> Int -> Int
min3 = (min .) . min


max3 :: Int -> Int -> Int -> Int
max3 = (max .) . max


getResults :: Matrix Int -> (Distance, Depth)
getResults mtr = (getElem (nrows mtr) (ncols mtr) mtr, 0)


levenshteinMemoized :: String -> String -> (Distance, Depth)
levenshteinMemoized s1 s2 = _memoized s1 s2 matrix 0
    where matrix = fromList (length s1 + 1) (length s2 + 1) $ repeat (-1) -- проверить корректность
          _memoized s1 "" _ n = (length s1, n)
          _memoized "" s2 _ n = (length s2, n)
          _memoized s1 s2 mtr n = (score, depth) where
              score = min3 (insert + 1) (delete + 1) (replace + match)
              memoized = (getElem (length s1) (length s2) mtr, n + 1)
              new_mtr = setElem score (length s1, length s2) mtr

              (insert, curr1) = if fst memoized == -1 then _memoized (init s1) s2 new_mtr (n + 1)
                    else memoized
              (delete, curr2) = if fst memoized == -1 then _memoized s1 (init s2) new_mtr (n + 1)
                    else memoized
              (replace, curr3) = if fst memoized == -1 then _memoized (init s1) (init s2) new_mtr (n + 1)
                    else memoized

              match = if last s1 == last s2 then 0 else 1
              depth = max3 curr1 curr2 curr3


levenshteinRecursion :: String -> String -> (Distance, Depth)
levenshteinRecursion s1 s2 = _recursion s1 s2 0
    where _recursion s1 "" n = (length s1, n)
          _recursion "" s2 n = (length s2, n)
          _recursion s1 s2 n = (score, depth) where
              (insert, curr1) = _recursion (init s1) s2 (n + 1)
              (delete, curr2) = _recursion s1 (init s2) (n + 1)
              (replace, curr3) = _recursion (init s1) (init s2) (n + 1)

              match = if last s1 == last s2 then 0 else 1
              score = min3 (insert + 1) (delete + 1) (replace + match)
              depth = max3 curr1 curr2 curr3


levenshteinIterative :: String -> String -> Matrix Int
levenshteinIterative s1 s2 = fromLists $ reverse $ foldl
    (\mtr i -> if head mtr == [] then [[0..length s1]] else calcRow mtr i : mtr) [[]] [0..length s2]
    where calcRow mtr i = foldl (\row j ->
            row ++ if length row == 0 then [length mtr] else [
                min3 (last row + 1) (head mtr !! j + 1) $ head mtr !! (j - 1) +
                    if s1 !! (j - 1) == s2 !! (i - 1) then 0 else 1]
            ) [] [0..length s1]


damerauLevenshtein :: String -> String -> Matrix Int
damerauLevenshtein s1 s2 = fromLists $ reverse $ foldl
    (\mtr i -> if head mtr == [] then [[0..length s1]] else calcRow mtr i : mtr) [[]] [0..length s2]
    where cell mtr row i j = min3 (last row + 1) (head mtr !! j + 1) $ head mtr !! (j - 1) +
                if s1 !! (j - 1) == s2 !! (i - 1) then 0 else 1
          transposition i j = i > 1 && j > 1 && s1 !! (j - 1) == s2 !! (i - 2) && s1 !! (j - 2) == s2 !! (i - 1)
          calcRow mtr i = foldl (\row j -> row ++ [
                if length row == 0 then length mtr
                else if transposition i j then min (cell mtr row i j) (((head $ tail mtr) !! i - 2) + 1)
                else cell mtr row i j]
            ) [] [0..length s1]
