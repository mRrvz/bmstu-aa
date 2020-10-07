#load "dynlink.cma";; (* you need these to work with *) 
#load "camlp4o.cma";

open Scanf;;
open Printf;;
open Sorts;;

let time f x =
    let t = Sys.time() in
    let fx = f x in
    printf "execution elapsed time: %f sec\n"
        (Sys.time() -. t);
    fx
;;

let arr = range 100

let main () =
    time bsort [1;2;3;4];
    printf "1234"
;;

if !Sys.interactive then () else main ();;
