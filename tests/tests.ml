(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module L = Utils.List;;

assert ( L.rev_append [] [] = [] );;
assert ( L.rev_append [] [1] = [1] );;
assert ( L.rev_append [1] [] = [1] );;
assert ( L.rev_append [1;2] [3] = [2;1;3] );;
assert ( L.rev_append [1] [2;3] = [1;2;3] );;
assert ( L.rev_append [1;2] [3;4] = [2;1;3;4] );;
ignore ( Printf.printf "Utils: rev_append ............ passed\n");;

assert ( L.rev [] = [] );;
assert ( L.rev [1] = [1] );;
assert ( L.rev [1;2] = [2;1] );;
ignore ( Printf.printf "Utils: rev ................... passed\n");;

assert ( L.append [] [] = [] );;
assert ( L.append [] [1] = [1] );;
assert ( L.append [1] [] = [1] );;
assert ( L.append [1;2] [3] = [1;2;3] );;
assert ( L.append [1] [2;3] = [1;2;3] );;
assert ( L.append [1;2] [3;4] = [1;2;3;4] );;
ignore ( Printf.printf "Utils: append ................ passed\n");;

assert ( L.map (fun x -> x * 2) [] = [] );;
assert ( L.map (fun x -> x * 2) [1] = [2] );;
assert ( L.map (fun x -> x * 2) [1;2] = [2;4] );;
ignore ( Printf.printf "Utils: map ................... passed\n");;

assert ( L.rev_map (fun x -> x * 2) [] = [] );;
assert ( L.rev_map (fun x -> x * 2) [1] = [2] );;
assert ( L.rev_map (fun x -> x * 2) [1;2] = [4;2] );;
ignore ( Printf.printf "Utils: rev_map ............... passed\n");;

let x = ref 0;;
assert ( L.iter (fun x -> x:= !x + 1) []; !x = 0 );;
assert ( L.iter (fun x -> x:= !x + 1) [x]; !x = 1 );;
assert ( L.iter (fun x -> x:= !x + 1) [x;x]; !x = 3 );;
assert ( L.iter (fun x -> x:= !x + 1) [x;x;x]; !x = 6 );;
ignore ( Printf.printf "Utils: iter .................. passed\n");;

assert ( L.rev_split_left [] = [] );;
assert ( L.rev_split_left [(1,2)] = [1] );;
assert ( L.rev_split_left [(1,2);(3,4)] = [3;1] );;
ignore ( Printf.printf "Utils: rev_split_left ........ passed\n");;

assert ( L.split_left [] = [] );;
assert ( L.split_left [(1,2)] = [1] );;
assert ( L.split_left [(1,2);(3,4)] = [1;3] );;
ignore ( Printf.printf "Utils: split_left ............ passed\n");;

assert ( L.rev_split_right [] = [] );;
assert ( L.rev_split_right [(1,2)] = [2] );;
assert ( L.rev_split_right [(1,2);(3,4)] = [4;2] );;
ignore ( Printf.printf "Utils: rev_split_right ....... passed\n");;

assert ( L.split_right [] = [] );;
assert ( L.split_right [(1,2)] = [2] );;
assert ( L.split_right [(1,2);(3,4)] = [2;4] );;
ignore ( Printf.printf "Utils: split_right ........... passed\n");;

assert ( L.rev_split [] = ([],[]) );;
assert ( L.rev_split [(1,2)] = ([1],[2]) );;
assert ( L.rev_split [(1,2);(3,4)] = ([3;1],[4;2]) );;
ignore ( Printf.printf "Utils: rev_split ............. passed\n");;

assert ( L.split [] = ([],[]) );;
assert ( L.split [(1,2)] = ([1],[2]) );;
assert ( L.split [(1,2);(3,4)] = ([1;3],[2;4]) );;
ignore ( Printf.printf "Utils: split ................. passed\n");;

assert ( L.rev_combine ([],[]) = [] );;
assert ( L.rev_combine ([1],[2]) = [(1,2)] );;
assert ( L.rev_combine ([1;3],[2;4]) = [(3,4);(1,2)] );;
ignore ( Printf.printf "Utils: rev_combine ........... passed\n");;

assert ( L.combine ([],[]) = [] );;
assert ( L.combine ([1],[2]) = [(1,2)] );;
assert ( L.combine ([1;3],[2;4]) = [(1,2);(3,4)] );;
ignore ( Printf.printf "Utils: combine ............... passed\n");;

assert ( L.rev_rem_last [] = [] );;
assert ( L.rev_rem_last [1] = [] );;
assert ( L.rev_rem_last [1;2] = [1] );;
assert ( L.rev_rem_last [1;2;3] = [2;1] );;
ignore ( Printf.printf "Utils: rev_rem_last .......... passed\n");;

assert ( L.rem_last [] = [] );;
assert ( L.rem_last [1] = [] );;
assert ( L.rem_last [1;2] = [1] );;
assert ( L.rem_last [1;2;3] = [1;2] );;
ignore ( Printf.printf "Utils: rem_last .............. passed\n");;

assert ( L.make 1 0 = [] );;
assert ( L.make 1 1 = [1] );;
assert ( L.make 1 2 = [1;1] );;
ignore ( Printf.printf "Utils: make .................. passed\n");;

assert ( L.rev_pad [] 5 0 = [] );;
assert ( L.rev_pad [] 5 1 = [] );;
assert ( L.rev_pad [] 5 2 = [] );;
assert ( L.rev_pad [1] 5 0 = [1] );;
assert ( L.rev_pad [1] 5 1 = [1] );;
assert ( L.rev_pad [1] 5 2 = [1;5] );;
assert ( L.rev_pad [1] 5 3 = [1;5;5] );;
assert ( L.rev_pad [1;2] 5 0 = [2;1] );;
assert ( L.rev_pad [1;2] 5 1 = [2;1] );;
assert ( L.rev_pad [1;2] 5 2 = [2;5;1;5] );;
assert ( L.rev_pad [1;2] 5 3 = [2;5;5;1;5;5] );;
ignore ( Printf.printf "Utils: rev_pad ............... passed\n");;

assert ( L.pad [] 5 0 = [] );;
assert ( L.pad [] 5 1 = [] );;
assert ( L.pad [] 5 2 = [] );;
assert ( L.pad [1] 5 0 = [1] );;
assert ( L.pad [1] 5 1 = [1] );;
assert ( L.pad [1] 5 2 = [5;1] );;
assert ( L.pad [1] 5 3 = [5;5;1] );;
assert ( L.pad [1;2] 5 0 = [1;2] );;
assert ( L.pad [1;2] 5 1 = [1;2] );;
assert ( L.pad [1;2] 5 2 = [5;1;5;2] );;
assert ( L.pad [1;2] 5 3 = [5;5;1;5;5;2] );;
ignore ( Printf.printf "Utils: pad ................... passed\n");;

module F1 = Fir.List(Types.Fir_Int)
let f1 = new F1.init (Utils.List.make 1 5);;
assert ( f1#next 1 = 1 );;
assert ( f1#next 1 = 2 );;
assert ( f1#next 1 = 3 );;
assert ( f1#next 1 = 4 );;
assert ( f1#next 1 = 5 );;
assert ( f1#next 1 = 5 );;
ignore ( Printf.printf "Fir:   int list .............. passed\n");;

module F2 = Fir.List(Types.Fir_Float)
let f2 = new F2.init (Utils.List.make 1. 5);;
assert ( f2#next 1. = 1. );;
assert ( f2#next 1. = 2. );;
assert ( f2#next 1. = 3. );;
assert ( f2#next 1. = 4. );;
assert ( f2#next 1. = 5. );;
assert ( f2#next 1. = 5. );;
ignore ( Printf.printf "Fir:   float list ............ passed\n");;

module F3 = Fir.Array(Types.Fir_Int)
let f3 = new F3.init (Utils.List.make 1 5);;
assert ( f3#next 1 = 1 );;
assert ( f3#next 1 = 2 );;
assert ( f3#next 1 = 3 );;
assert ( f3#next 1 = 4 );;
assert ( f3#next 1 = 5 );;
assert ( f3#next 1 = 5 );;
ignore ( Printf.printf "Fir:   int array ............. passed\n");;

module F4 = Fir.Array(Types.Fir_Float)
let f4 = new F4.init (Utils.List.make 1. 5);;
assert ( f4#next 1. = 1. );;
assert ( f4#next 1. = 2. );;
assert ( f4#next 1. = 3. );;
assert ( f4#next 1. = 4. );;
assert ( f4#next 1. = 5. );;
assert ( f4#next 1. = 5. );;
ignore ( Printf.printf "Fir:   float array ........... passed\n");;
