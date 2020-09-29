let rec bsort arr = 
  let rec _bsort = function
    | x1 :: x2 :: xs when x1 > x2 -> x2 :: _bsort (x1 :: xs)
    | x1 :: x2 :: xs -> x1 :: _bsort (x2 :: xs)
    | arr -> arr
  in 
    let s = _bsort arr in
      if s = arr then s
      else _bsort arr
;;
