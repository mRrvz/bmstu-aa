open Sorts;;
open Printf;;

let sqr x = x * x;;

let x = bsort [ 9; 13; 1; 0; ];;

let main () = 
    List.iter (printf "%d ") x
;;

if !Sys.interactive then () else main ();;
