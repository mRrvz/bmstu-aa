import Data.Matrix as M
import Data.Maybe
import Text.Printf
import Multiplication

getType :: IO String
getType = do
    printf "1. Умножение матриц обычным способом\n\
    \2. Умножение матриц с транспонированием\n\
    \3. Умножение матриц по Винограду\n\
    \4. Умножение матриц по Винограду (оптимизированный метод)\n"

    n <- getLine
    return n

main :: IO ()
main = do
    let size = 600
    let m1 = fromList size size [1..size * size]
    let m2 = fromList size size [1..size * size]

    --print m1
    --print m2

    --type' <- getType
    --print $ winogradOptimizedMultiplication m1 m2
    print m1

    --let result = case type' of {
        --"1" -> Just $ baseMultiplication m1 m2;
        --"2" -> Just $ baseTMultiplication m1 m2;
        --"3" -> Just $ winogradMultiplication m1 m2;
        --"4" -> Just $ winogradOptimizedMultiplication m1 m2;
        --_   -> Nothing;
    --}

    --print $ fromJust result

    --main
