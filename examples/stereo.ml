(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module R = Streams.Raw16.Mono(Types.Stream_Float)
module W = Streams.Raw24.Stereo(Types.Stream_Float)

let r = new R.init 4096;;
let w = new W.init 4096;;
let g = (fun x -> 256. *. x);; 

while true do 
    try
        let s = (Utils.List.map g r#read) in
        ignore(w#write (s,s))
    with 
        End_of_file -> exit 0
done 
