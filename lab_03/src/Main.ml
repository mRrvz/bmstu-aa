open Sorts;;
open Printf;;

let sqr x = x * x;;

let bubble_array = bsort [ 9; 13; 1; 0; -7; -1; 3; 3; 7; 90; ];;
let insertion_array = isort [ 9; 13; 1; 0; -7; -1; 3; 3; 7; 90; ];;

(*let *)

let main () = 
    (*List.iter (printf "%d ") bubble_array;*)
    List.iter (printf "%d ") insertion_array;
;;

if !Sys.interactive then () else main ();;
