let sqr x = x * x;;

let main () = 
    print_string "Hello, world!";
    print_int (sqr 5);
;;

if !Sys.interactive then () else main ();;
