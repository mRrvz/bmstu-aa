module Levenshtein (
    getDistance,
    levenshteinMemoized,
    levenshteinRecursion,
    levenshteinIterative,
    damerauLevenshtein
) where


import Data.Matrix

type Distance = Int

min3 :: Int -> Int -> Int -> Int
min3 = (min .) . min


getDistance :: Matrix Int -> Distance
getDistance mtr = getElem (nrows mtr) (ncols mtr) mtr


levenshteinMemoized :: String -> String -> Distance
levenshteinMemoized s1 s2 = _memoized s1 s2 matrix
    where matrix = fromList (length s1 + 1) (length s2 + 1) $ repeat (-1) -- проверить корректность
          _memoized s1 "" _ = length s1
          _memoized "" s2 _ = length s2
          _memoized s1 s2 mtr = score where
              score = min3 insert delete match
              memoized = getElem (length s1) (length s2) mtr
              new_mtr = setElem score (length s1, length s2) mtr
              insert = if memoized == -1 then _memoized (init s1) s2 new_mtr + 1 else memoized
              delete = if memoized == -1 then _memoized s1 (init s2) new_mtr + 1 else memoized
              match = if memoized == -1 then _memoized (init s1) (init s2) new_mtr +
                  (if last s1 == last s2 then 0 else 1) else memoized


levenshteinRecursion :: String -> String -> Distance
levenshteinRecursion s1 "" = length s1
levenshteinRecursion "" s2 = length s2
levenshteinRecursion s1 s2 = min3 insert match delete where
    insert = levenshteinRecursion (init s1) s2 + 1
    delete = levenshteinRecursion s1 (init s2) + 1
    match = levenshteinRecursion (init s1) (init s2) + if last s1 == last s2 then 0 else 1


levenshteinIterative :: String -> String -> Matrix Int
levenshteinIterative s1 s2 = fromLists $ reverse $ foldl
    (\mtr i -> if head mtr == [] then [[0..length s1]] else calcRow mtr i : mtr) [[]] [0..length s2]
    where calcRow mtr i = foldl (\row j ->
            row ++ if length row == 0 then [length mtr] else [
                min3 (last row + 1) (head mtr !! j + 1) $ head mtr !! (j - 1) +
                    if s1 !! (j - 1) == s2 !! (i - 1) then 0 else 1]
            ) [] [0..length s1]


damerauLevenshtein :: String -> String -> Matrix Int
damerauLevenshtein s1 s2 = fromLists [[23, 23], [4,5]]
