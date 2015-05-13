(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module List = struct

    let rec rev_append (x: 'a list) (y: 'a list) : 'a list =
        match x with
        | h::t -> rev_append t (h::y)
        | [] -> y

    let rev (x: 'a list) : 'a list =
        rev_append x []

    let append (x: 'a list) (y: 'a list) : 'a list =
        rev_append (rev_append x []) y

    let rev_map (f: 'a -> 'b) (x: 'a list) : 'b list =
        let rec mp (x: 'a list) (f: 'a -> 'b) (y: 'b list) : 'b list =
            match x with
            | h::t -> mp t f ((f h)::y)
            | [] -> y
        in 
        mp x f [] 
   
    let map (f: 'a -> 'b) (x: 'a list) : 'b list =
        rev (rev_map f x)
        
    let rec iter (f: 'a -> 'b) (x: 'a list) : unit =
        match x with 
        | h::t -> f h; iter f t
        | [] -> ()

    let rev_split_left (x: ('a * 'a) list) : 'a list =
        let rec sl (x: ('a * 'a) list) (y: 'a list) : 'a list =
            match x with 
            | (h,_)::t -> sl t (h::y)
            | [] -> y
        in 
        sl x []
        
    let split_left (x: ('a * 'a) list) : 'a list =
        rev (rev_split_left x)

    let rev_split_right (x: ('a * 'a) list) : 'a list =
        let rec sr (x: ('a * 'a) list) (y: 'a list) : 'a list =
            match x with
            | (_,h)::t -> sr t (h::y)
            | [] -> y
        in 
        sr x []
        
    let split_right (x: ('a * 'a) list) : 'a list =
        rev (rev_split_right x)
        
    let rec rev_split (x: ('a * 'a) list) : 'a list * 'a list =
        (rev_split_left x, rev_split_right x)
        
    let rec split (x: ('a * 'a) list) : 'a list * 'a list =
        (split_left x, split_right x)

    let rev_combine (x: 'a list * 'a list) : ('a * 'a) list =
        let rec cm (x: 'a list * 'a list) (y: ('a * 'a) list) : ('a * 'a) list =
            match x with
            | (h1::t1,h2::t2) -> cm (t1,t2) ((h1,h2)::y)
            | ([],[]) -> y
            | _ -> failwith "Invariant Violation: Unequal List Length"
        in 
        cm x []

    let combine (x: 'a list * 'a list) : ('a * 'a) list =
        rev (rev_combine x)
      
    let rev_rem_last (x: 'a list) : 'a list =
        let rec rl (x: 'a list) (y: 'a list) : 'a list =
            match x with 
            | h1::h2::t -> rl (h2::t) (h1::y)
            | _ -> y
        in 
        rl x []

    let rem_last (x: 'a list) : 'a list =
        rev (rev_rem_last x)

    let make (x: 'a) (n: int) : 'a list =
        let rec mk (x: 'a) (n: int) (y: 'a list) : 'a list =
            if n>0 then mk x (n-1) (x::y) else y
        in 
        mk x n []
       
    (* Needs a faster method *)
    let rev_pad (x: 'a list) (y: 'a) (n: int) : 'a list =
        let p = make y (n-1) in
        let rec pd (x: 'a list) (y: 'a list) : 'a list =
            match x with
            | h::t -> pd t (h::(append p y)) 
            | [] -> y
        in 
        pd x []

    (* Does not produce what you might expect *)
    let pad (x: 'a list) (y: 'a) (n: int) : 'a list =
        rev (rev_pad x y n)

end
