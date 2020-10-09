open Scanf;;
open Printf;;
open Sorts;;

let print_array arr = List.iter (printf "%d ") arr
;;

let rec read_array arr n =
    match n with
    | 0 -> []
    | n -> arr @ [Scanf.scanf "%d\n" (fun x -> x)] @ read_array arr (n - 1)
;;

let print_menu =
    printf "1. Сортировка пузырьком\n2. Сортировка вставками\n3. Быстрая сортировка\n"
;;

let main () =
    print_menu;
    flush stdout;

    let stype = Scanf.scanf "%d\n" (fun x -> x) in
      printf "Введите размер массива: \n"; flush stdout;
    let size = Scanf.scanf "%d\n" (fun x -> x) in
      printf "Введите массив: \n"; flush stdout;
    let arr = read_array [] size in
      printf "Реузультат: \n"; print_array (
        match stype with
        | 1 -> bsort arr
        | 2 -> isort arr
        | 3 -> qsort arr
        | _ -> []
    );
;;

if !Sys.interactive then () else main ();;
