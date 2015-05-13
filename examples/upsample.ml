(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module S = Streams.Raw16.Mono(Types.Stream_Float)
module F = Fir.Array(Types.Fir_Float)
module L = Utils.List

let s = new S.init 1024;;
let f = new F.init Coefficients.upsample;;
let g = (fun x -> 4. *. (f#next x));;

while true do 
    try  ignore(s#write (L.map g (L.pad s#read 0. 4)))
    with End_of_file -> exit 0
done 
