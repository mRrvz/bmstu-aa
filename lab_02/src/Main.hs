import Data.Matrix as M
import Data.Maybe
import Control.Monad
import Text.Printf
import Multiplication

readType :: IO String
readType = do
    printf "1. Умножение матриц обычным способом\n\
    \2. Умножение матриц с транспонированием\n\
    \3. Умножение матриц по Винограду\n\
    \4. Умножение матриц по Винограду (оптимизированный метод)\n"

    n <- getLine
    return n

readSize :: IO (Int, Int)
readSize = do
    printf "Введите количество строк матрицы: \n"
    n <- fmap (\x -> read x :: Int) getLine
    printf "Введите количество столбцов матрицы: \n"
    m <- fmap (\x -> read x :: Int) getLine
    return (n, m)

readMatrixLine :: IO [Int]
readMatrixLine = do
    s <- fmap words getLine
    return $ map (\x -> read x :: Int) s

readMatrix :: Int -> Int -> IO (Matrix Int)
readMatrix m n = do
    printf "Введите матрицу, построчно: \n"
    m' <- replicateM m readMatrixLine
    return $ M.fromLists m'
    
main :: IO ()
main = do
    let size = 601
    (a, b) <- readSize
    (b', c) <- readSize

    if (b /= b') then error 
      "Количество столбцов первой матрицы должно совпадать с количество строк второй матрицы." else return ()

    m1 <- readMatrix a b
    print m1

    m2 <- readMatrix b' c
    print m2

    type' <- readType

    let result = case type' of {
        "1" -> Just $ baseMultiplication m1 m2;
        "2" -> Just $ baseTMultiplication m1 m2;
        "3" -> Just $ winogradMultiplication m1 m2;
        "4" -> Just $ winogradOptimizedMultiplication m1 m2;
        _   -> Nothing;
    }

    print $ fromJust result

    main
