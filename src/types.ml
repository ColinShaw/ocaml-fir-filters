(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module Fir_Int = struct
    type t = int
    let zero = 0
    let plus = ( + )
    let mult = ( * )
end

module Fir_Float = struct
    type t = float
    let zero = 0.
    let plus = ( +. )
    let mult = ( *. )
end 

module Stream_Int = struct
    type t = int
    let to_stream   = (fun x -> x)
    let from_stream = (fun x -> x)
end

module Stream_Float = struct
    type t = float
    let to_stream   = int_of_float
    let from_stream = float_of_int
end
