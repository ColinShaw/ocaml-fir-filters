(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module S = Streams.Raw16.Mono(Types.Stream_Float) 
module F = Fir.Array(Types.Fir_Float)

let s = new S.init 4096;;
let f = new F.init Coefficients.filter;;

while true do 
    try  ignore(s#write(Utils.List.map f#next s#read))
    with End_of_file -> exit 0
done 
