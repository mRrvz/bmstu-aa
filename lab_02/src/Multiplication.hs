module Multiplication (
    baseMultiplication,
    baseTMultiplication
) where

import Prelude as P
import Data.Matrix as M
import Data.Vector as V

baseTMultiplication :: Matrix Int -> Matrix Int -> Matrix Int
baseTMultiplication m1 m2 =  M.fromList (M.ncols m2) (M.nrows m1) $ V.toList $ _multp m1 (M.transpose m2) 1 where
  _multp m1 m2 i
    | i == M.nrows m1 + 1 = V.fromList []
    | otherwise = P.foldl (\acc j ->
        V.snoc acc $ V.sum (V.zipWith (*) (M.getRow i m1) (M.getRow j m2))) (V.fromList []) [1..M.nrows m2]
            V.++ _multp m1 m2 (i + 1)

baseMultiplication :: Matrix Int -> Matrix Int -> Matrix Int
baseMultiplication m1 m2 = M.fromList (M.ncols m2) (M.nrows m1) $ V.toList $ _multp m1 m2 1 where
  _multp m1 m2 i
    | i == M.nrows m1 + 1 = V.fromList []
    | otherwise = P.foldl (\acc j ->
        V.zipWith (+) acc $ V.zipWith (*) (V.fromList $ P.take (M.nrows m1) $ repeat (M.getElem i j m1)) (M.getRow j m2))
            (V.fromList $ P.take (M.ncols m2) $ repeat 0) [1..M.ncols m1] V.++ _multp m1 m2 (i + 1)
