module Analysis (
    calcMemory,
    calcMatrixMemory
) where

type Depth = Int
type MemoryCount = Int

{- Адрес возврата: 8б
   Дистанция и глубина: 16б
   Строки: (4 * размер1) + (4 * размер2) -}
calcMemory :: Depth -> Int -> Int -> MemoryCount
calcMemory depth l1 l2 = depth * (returnPtr + returnVal + stringsMem)
    where stringsMem = 4 * (l1 + l2)
          returnPtr = 8
          returnVal = 16

{- Матрица: 8 * (l1 + 1) * (l2 + 1) -}
calcMatrixMemory :: Depth -> Int -> Int -> MemoryCount
calcMatrixMemory depth l1 l2 = depth * (returnVal + returnPtr + stringsMem + matrixMem)
    where stringsMem = 4 * (l1 + l2)
          matrixMem = 8 * (l1 + 1) * (l2 + 1)
          returnPtr = 8
          returnVal = 16
