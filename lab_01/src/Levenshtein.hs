module Levenshtein (
    getDistance,
    levenshteinRecursion,
    levenshteinIterative
) where

type Matrix = [[Int]]
type Distance = Int

data EditInfo = EditInfo { matrix :: Matrix,
                   distance :: Distance
                 } deriving (Show)

min3 :: Int -> Int -> Int -> Int
min3 = (min .) . min

getDistance :: Matrix -> Distance
getDistance = last . last

levenshteinRecursion :: String -> String -> Distance
levenshteinRecursion s1 s2 = helper s1 s2 [[]]
    where helper s1 s2 matrix = 25

levenshteinIterative :: String -> String -> Matrix
levenshteinIterative s1 s2 = reverse $ foldl
    (\mtr i -> if head mtr == [] then [[0..length s1]] else calcRow mtr i : mtr) [[]] [0..length s2]
    where calcRow mtr i = foldl
            (\row j -> row ++ if length row == 0 then [length mtr] else [
                min3 (last row + 1) (head mtr !! j + 1) (head mtr !! (j - 1) +
                if s1 !! (j - 1) == s2 !! (i - 1) then 0 else 1)]
            ) [] [0..length s1]
