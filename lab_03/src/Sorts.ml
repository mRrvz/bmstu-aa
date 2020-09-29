let rec bsort arr = 
  let rec _bsort = function
    | x1 :: x2 :: xs when x1 > x2 -> x2 :: _bsort (x1 :: xs)
    | x1 :: x2 :: xs -> x1 :: _bsort (x2 :: xs)
    | arr -> arr
  in 
  let maybe_sorted = _bsort arr in
    if maybe_sorted = arr then arr
    else bsort maybe_sorted
;;

(*let rec isort arr = arr*)
(*;;*)
let rec isort arr = 
  let rec insert k = function 
     | x :: xs when k < x -> k :: x :: xs
     | x :: xs -> x :: (insert k xs)
     | [] -> []
  in 
    match arr with
    | [] -> []
    | x :: xs -> insert x (isort xs)
;;
    (*let maybe_sorted = _isort arr in*)
      (*if mayber_sorted = arr then arr*)
      (*else isort*)
   
