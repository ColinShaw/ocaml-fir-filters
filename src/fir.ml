(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module type FIR_Type = sig
    type t
    val zero : t
    val plus : t -> t -> t
    val mult : t -> t -> t
end

module type FIR_Interface = sig
    type t
    class init: t list -> object
        method next: t -> t
    end
end

module List (M: FIR_Type) : 
            (FIR_Interface with type t := M.t) = struct 

    let convolve (f: M.t list * M.t list) : M.t =
        let rec conv (f: M.t list * M.t list) (v: M.t) : M.t =
            match f with
            | (h1::t1,h2::t2) -> conv (t1,t2) (M.plus v (M.mult h1 h2))
            | ([],[]) -> v
            | _ -> failwith "Invariant Violation: Unequal List Length"
        in 
        conv f M.zero

    let load_coefficients (c: M.t list) : M.t list * M.t list =    
        let rec gen_zero_signal (c: M.t list) (s: M.t list) : M.t list =
            match c with
            | h::t -> gen_zero_signal t (M.zero::s)
            | [] -> s
        in 
        (gen_zero_signal c [], c)

    let add_new_sig_elt (v: M.t) (f: M.t list * M.t list) : M.t list * M.t list = 
        let (signal, coeffs) = f in
        (v::(Utils.List.rem_last signal),coeffs)      
    
    class init coefficients = object 
           
        val mutable filt = ([],[])
         
        initializer filt <- load_coefficients coefficients
            
        method next v =
            filt <- add_new_sig_elt v filt;
            convolve filt
        
    end

end

module Array (M: FIR_Type) :
             (FIR_Interface with type t := M.t) = struct

    let mod_special (x: int) (y: int) : int =
        if x >= y then x - y
        else if x < 0 then x + y 
        else x

    class init coefficients = object
    
        val mutable signal = [||]
        val mutable coeffs = [||]
        val mutable length = 0
        val mutable pos = 0
        val mutable sum = M.zero
    
        initializer
            pos <- 0;
            coeffs <- Array.of_list coefficients;
            length <- Array.length coeffs;
            signal <- Array.make length M.zero

        method next v =
            sum <- M.zero;
            signal.(pos) <- v;
            for i = 0 to (length-1) do
                let j = mod_special (pos-i) length in
                let m = M.mult coeffs.(i) signal.(j) in
                sum <- M.plus sum m;
            done;
            pos <- (pos+1) mod length;
            sum
       
    end

end
