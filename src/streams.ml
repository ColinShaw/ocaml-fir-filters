(* FIR and Upsampling Filters in OCaml
 * Copyright (c) 2015, Colin Shaw
 * Distributed under the terms of the MIT License 
 *)

module type Stream_Type = sig
    type t
    val to_stream   : t   -> int
    val from_stream : int -> t
end

module type Mono_Interface = sig
    type t
    class init: int -> object
        method read:  t list
        method write: t list -> unit 
    end
end

module type Stereo_Interface = sig
    type t
    class init: int -> object
        method read:  t list * t list
        method write: t list * t list -> unit 
    end
end

module Raw16 = struct
            
    module Mono (M: Stream_Type) : 
                (Mono_Interface with type t := M.t) = struct
        
        let write_int_16_mono (i: int) =          
            output_byte stdout i;  
            output_byte stdout (i lsr 8)
           
        let read_int_16 unit : int =
            let b1 = input_byte stdin in 
            let b2 = input_byte stdin in
            let i = b1 lor (b2 lsl 8) in
            if (b2 land 128) = 0 then i
            else (i - 65536)
    
        let read_int_16_mono (n: int) : int list =
            let rec ri (n: int) (i: int list) : int list =
                if n=0 then i
                else ri (n-1) ((read_int_16 ())::i)
            in
            ri n []

        let write_list (x: M.t list) =
            let f = write_int_16_mono in
            let y = Utils.List.map M.to_stream x in
            Utils.List.iter f y;
            flush stdout

        let read_list (n: int) : M.t list =
            let x = read_int_16_mono n in
            Utils.List.rev_map M.from_stream x

        class init buffer_length = object
            method read = read_list buffer_length
            method write = write_list 
        end 
    
    end
    
    module Stereo (M: Stream_Type) : 
                  (Stereo_Interface with type t := M.t) = struct
    
        let write_int_16_mono (i: int) =          
            output_byte stdout i;  
            output_byte stdout (i lsr 8)
           
        let write_int_16_stereo (i: int * int) =
            let (l,r) = i in
            write_int_16_mono l;
            write_int_16_mono r
    
        let read_int_16 unit : int =
            let b1 = input_byte stdin in 
            let b2 = input_byte stdin in
            let i = b1 lor (b2 lsl 8) in
            if (b2 land 128) = 0 then i
            else (i - 65536)
    
        let read_int_16_stereo (n: int) : int list * int list = 
            let rec ri (n: int) (i: int list) (j: int list) : int list * int list =
                if n=0 then (i,j)
                else ( let l = read_int_16 () in
                       let r = read_int_16 () in
                       ri (n-1) (l::i) (r::j) )
            in 
            ri n [] []
   
        let write_list (x: M.t list * M.t list) =
            let (l,r) = x in
            let f = write_int_16_stereo in
            let l' = Utils.List.map M.to_stream l in
            let r' = Utils.List.map M.to_stream r in
            let y = Utils.List.combine (l',r') in
            Utils.List.iter f y;
            flush stdout

        let read_list (n: int) : M.t list * M.t list =
            let (l,r) = read_int_16_stereo n in
            let l' = Utils.List.rev_map M.from_stream l in
            let r' = Utils.List.rev_map M.from_stream r in
            (l',r')

        class init buffer_length = object
            method read = read_list buffer_length
            method write = write_list 
        end 
    
    end

end

module Raw24 = struct

    module Mono (M: Stream_Type) : 
                (Mono_Interface with type t := M.t) = struct
    
        let write_int_24_mono (i: int) =          
            output_byte stdout i;  
            output_byte stdout (i lsr 8);
            output_byte stdout (i lsr 16)
           
        let read_int_24 unit : int =
            let b1 = input_byte stdin in 
            let b2 = input_byte stdin in
            let b3 = input_byte stdin in
            let i = b1 lor (b2 lsl 8) lor (b3 lsl 16) in
            if (b3 land 128) = 0 then i
            else (i - 16777216)
    
        let read_int_24_mono (n: int) : int list =
            let rec ri (n: int) (i: int list) : int list =
                if n=0 then i
                else ri (n-1) ((read_int_24 ())::i) 
            in
            ri n []

        let write_list (x: M.t list) =
            let f = write_int_24_mono in
            let y = Utils.List.map M.to_stream x in
            Utils.List.iter f y;
            flush stdout

        let read_list (n: int) : M.t list =
            let x = read_int_24_mono n in
            Utils.List.rev_map M.from_stream x

        class init buffer_length = object
            method read = read_list buffer_length
            method write = write_list 
        end 

    end
    
    module Stereo (M: Stream_Type) : 
                  (Stereo_Interface with type t := M.t) = struct
    
        let write_int_24_mono (i: int) =          
            output_byte stdout i;  
            output_byte stdout (i lsr 8);
            output_byte stdout (i lsr 16)
           
        let write_int_24_stereo (i: int * int) =
            let (l,r) = i in
            write_int_24_mono l;
            write_int_24_mono r      
            
        let read_int_24 unit : int =
            let b1 = input_byte stdin in 
            let b2 = input_byte stdin in
            let b3 = input_byte stdin in
            let i = b1 lor (b2 lsl 8) lor (b3 lsl 16) in
            if (b3 land 128) = 0 then i
            else (i - 16777216)
    
        let read_int_24_stereo (n: int) : int list * int list =
            let rec ri (n: int) (i: int list) (j: int list) : int list * int list =
                if n=0 then (i,j)
                else ( let l = read_int_24 () in
                       let r = read_int_24 () in
                       ri (n-1) (l::i) (r::j) )
            in 
            ri n [] []
        
        let write_list (x: M.t list * M.t list) =
            let (l,r) = x in
            let f = write_int_24_stereo in
            let l' = Utils.List.map M.to_stream l in
            let r' = Utils.List.map M.to_stream r in
            let y = Utils.List.combine (l',r') in
            Utils.List.iter f y;
            flush stdout

        let read_list (n: int) : M.t list * M.t list =
            let (l,r) = read_int_24_stereo n in
            let l' = Utils.List.rev_map M.from_stream l in
            let r' = Utils.List.rev_map M.from_stream r in
            (l',r')

        class init buffer_length = object
            method read = read_list buffer_length
            method write = write_list 
        end 
    
    end

end
