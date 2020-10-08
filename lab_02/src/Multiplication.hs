module Multiplication
  (
    baseMultiplication
  , baseTMultiplication
  , winogradMultiplication
  , winogradOptimizedMultiplication
  ) where

import Prelude as P
import Data.Matrix as M
import Data.Vector as V
import Control.DeepSeq

baseTMultiplication :: (Num a) => Matrix a -> Matrix a -> Matrix a
baseTMultiplication m1 m2 =  M.fromList (M.nrows m1) (M.ncols m2) $ V.toList $ _multp m1 (M.transpose m2) 1
  where
    _multp m1 m2 i
      | i == M.nrows m1 + 1 = V.fromList []
      | otherwise = P.foldl (\acc j ->
        V.snoc acc $ V.sum (V.zipWith (*) (M.getRow i m1) (M.getRow j m2))) (V.fromList []) [1..M.nrows m2]
          V.++ _multp m1 m2 (i + 1)

baseMultiplication :: (Num a) => Matrix a -> Matrix a -> Matrix a
baseMultiplication m1 m2 = M.fromList (M.nrows m1) (M.ncols m2) $ V.toList $ _multp m1 m2 1
  where
    _multp m1 m2 i
      | i == M.nrows m1 + 1 = V.fromList []
      | otherwise = P.foldl (\acc j ->
        V.zipWith (+) acc $ V.zipWith (*) (V.fromList $ P.take (M.ncols m2) $ repeat (M.getElem i j m1)) (M.getRow j m2))
          (V.fromList $ P.take (M.ncols m2) $ repeat 0) [1..M.ncols m1] V.++ _multp m1 m2 (i + 1)

winogradMultiplication :: (Num a) => Matrix a -> Matrix a -> Matrix a
winogradMultiplication m1 m2 = res
  where
    a = M.nrows m1
    b = M.ncols m1
    c = M.ncols m2

    rows = V.generate a $ \i -> precalc $ M.getRow (i + 1) m1
    cols = V.generate c $ \j -> precalc $ M.getCol (j + 1) m2

    precalc v = P.foldl (\acc i ->
      acc - V.unsafeIndex v i * V.unsafeIndex v (i + 1)) 0 [0, 2 .. V.length v - 2]

    res = M.matrix a c $ \(i, j) ->
      V.unsafeIndex rows (i - 1) + V.unsafeIndex cols (j - 1)
      + subcalc (M.getRow i m1) (M.getCol j m2)
      + if odd b then M.unsafeGet i b m1 * M.unsafeGet b j m2 else 0

    subcalc v1 v2 = P.foldl (\acc i ->
      acc + (V.unsafeIndex v1 (i + 1) + V.unsafeIndex v2 (i))
          * (V.unsafeIndex v1 (i) + V.unsafeIndex v2 (i + 1))) 0 [0, 2 .. V.length v1 - 2]


winogradOptimizedMultiplication :: (Num a) => Matrix a -> Matrix a -> Matrix a
winogradOptimizedMultiplication m1 m2 = res
  where
    a = M.nrows m1
    b = M.ncols m1
    c = M.ncols m2

    m1' = V.generate a $ \i -> M.getRow (i + 1) m1
    m2' = V.generate c $ \j -> M.getCol (j + 1) m2

    rows = V.generate a $ \i -> precalc $ V.unsafeIndex m1' i
    cols = V.generate c $ \j -> precalc $ V.unsafeIndex m2' j

    precalc v = P.foldl (\acc i ->
      acc - V.unsafeIndex v i * V.unsafeIndex v (i + 1)) 0 [0, 2 ..  b - 2]

    res = if odd b
      then M.matrix a c $ \(i, j) ->
        let v1 = V.unsafeIndex m1' (i - 1)
            v2 = V.unsafeIndex m2' (j - 1)
        in V.unsafeIndex rows (i - 1) + V.unsafeIndex cols (j - 1) + subcalc v1 v2 + V.last v1 * V.last v2
      else M.matrix a c $ \(i, j) ->
        let v1 = V.unsafeIndex m1' (i - 1)
            v2 = V.unsafeIndex m2' (j - 1)
        in V.unsafeIndex rows (i - 1) + V.unsafeIndex cols (j - 1) + subcalc v1 v2

    subcalc v1 v2 = P.foldl (\acc i ->
      acc + (V.unsafeIndex v1 (i + 1) + V.unsafeIndex v2 (i))
          * (V.unsafeIndex v1 (i) + V.unsafeIndex v2 (i + 1))) 0 [0, 2 .. b - 2]
