module Main where

import Data.Vector as V
import Dictionary

main :: IO ()
main = do
    let p = 123

    print $ frequencyAnalysis (V.fromList [(0, "STR0"), (1, "STR1"), (3, "STR3"), (4, "STR4"), 
        (6, "STR6"), (7, "STR7")]) 7 3

