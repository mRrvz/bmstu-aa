import Data.Matrix as M
import Data.Maybe
import Control.Monad
import Control.Parallel
import System.Time
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

secDiff :: ClockTime -> ClockTime -> Float
secDiff (TOD secs1 psecs1) (TOD secs2 psecs2) = fromInteger(psecs2−psecs1) / 1e12 +fromInteger(secs2−secs1)
    
main :: IO ()
main = do
    let size = 200 
    let m1 = M.fromList size size [1..size*size]
    let m2 = M.fromList size size [1..size*size]

    t1 <- getClockTime
    baseMultiplication m1 m2 `seq` (return ())
    t2 <- getClockTime
    printf "%s" $ show $ secDiff t1 t2

    --print $ fromJust result

