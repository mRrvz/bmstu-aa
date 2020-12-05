module Dictionary (
    simpleSearch,
    binarySearch,
    frequencyAnalysis
) where

import qualified Data.Vector as V


simpleSearch :: (Ord a, Eq b) => V.Vector (a, b) -> a -> Maybe b
simpleSearch dict key = simpleSearch' dict key $ V.head dict 
  where
    simpleSearch' dict key curr | key == fst curr = Just $ snd curr
    simpleSearch' dict key curr | V.null dict = Nothing
    simpleSearch' dict key curr | otherwise = simpleSearch' (V.tail dict) key $ V.head dict


binarySearch :: (Ord a, Eq b) => V.Vector (a, b) -> a -> Maybe b 
binarySearch dict key = binarySearch' dict key $ middle dict
  where
    fstHalf dict = V.take ((V.length dict) `div` 2) dict
    sndHalf dict = V.drop ((V.length dict) `div` 2) dict
    middle dict = dict V.! ((V.length dict) `div` 2)

    binarySearch' dict key curr | V.null dict = Nothing
    binarySearch' dict key curr | key == fst curr = Just $ snd curr
    binarySearch' dict key curr | key > fst curr = binarySearch' (sndHalf dict) key (middle $ sndHalf dict)
    binarySearch' dict key curr | key <= fst curr = binarySearch' (fstHalf dict) key $ (middle $ fstHalf dict)


calculateIntervals :: Eq b => V.Vector (Int, b) -> Int -> V.Vector (V.Vector (Int, b))
calculateIntervals dict divider = intervals
  where 
    remainder = V.foldl (\acc x -> acc V.++ (V.fromList [(fst x `mod` divider, x)])) (V.empty) dict
    intervals = V.foldl (
      \acc x ->
        acc V.// [(fst x, acc V.! (fst x) V.++ V.fromList [snd x])])
          (V.generate divider (\x -> V.empty)) remainder


frequencyAnalysis :: Eq b => V.Vector (Int, b) -> Int -> Int -> Maybe b
frequencyAnalysis dict key divider = 
  if V.null $ disiredInterval key divider
  then Nothing 
  else binarySearch (disiredInterval key divider) key
    where
      intervals = calculateIntervals dict divider
      disiredInterval k d = intervals V.! (k `mod` d)
