import Data.Matrix as M
import Multiplication

main :: IO ()
main = do
    let m1 = fromList 200 200 [1..1000000]
    let m2 = fromList 200 200 [1..1000000]
    print m1
    print m2
    print $ baseTMultiplication m1 m2
