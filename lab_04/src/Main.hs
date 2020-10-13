{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign
import Foreign.C.Types
foreign import ccall "multiplication.h getSize" c_size :: IO Double

main :: IO ()
main = do
        let size = 30000000
        b <- c_size
        print $ "got from C: " ++ show b
