(* polymorphic dictionary *)
type 'a dict = Empty | Node of string * 'a * 'a dict * 'a dict

(* binary search oriented tree - left is lt parent *)
let fruitd =
    Node ("grape", 2.65,
        Node ("banana", 1.50,
            Node ("apple", 2.25, Empty, Empty),
            Node ("cherry", 2.75, Empty, Empty)),
        Node ("orange", 0.75,
            Node ("kiwi", 3.99, Empty, Empty),
            Node ("peach", 1.99, Empty, Empty)))

(* implement: val find: 'a dict -> string -> 'a *)
(* such that: find fruitd "cherry" returns 2.75 *)

(* my implementation *)

let rec find_derrick d k = 
    match d with
    | Empty -> raise Not_found
    | Node(key, x, _, _) when key = k -> x
    | Node(key, x, y, z) -> 
        if key > k then (find_derrick y k) else (find_derrick z k)
;;

(* sorin's implementation *)

let rec find_sorin d k = 
    match d with
    | Empty -> raise Not_found
    | Node(k', v', l, r) ->
        if k = k' then v' else
            if k < k' then (find_sorin l k) else (find_sorin r k)
;;

let d = find_derrick fruitd "peach";;
let s = find_sorin fruitd "peach";;

(* implement: val find: 'a dict -> string -> 'a -> 'a dict *)
(* such that: add fruitd "strawberry" 4.00 returns fruitd with "strawberry" added *)

(* my implementation *)

let rec add_derrick d k v =
    match d with 
    | Empty -> Node(k, v, Empty, Empty) (* insert node *)
    | Node(key, _, l, r) when k = key -> Node(k, v, l, r) (* overwrite node *)
    | Node(key, value, l, r) -> 
        if k < key 
        then Node(key, value, (add_derrick l k v), r)
        else Node(key, value, l, (add_derrick r k v))
;;

(*
let d0 = fruitd in
let d1 = add_derrick d0 "banana" 5.0 in
let d2 = add_derrick d1 "mango" 10.25 in 
(find_derrick d2 "banana", find_derrick d2 "mango", find_derrick d2 "cherry");;
*)

(* map: applys function to each item in the list *)
(* returns a list of results *)
let rec map f l =
    match l with
    | [] -> []
    | (h::t) -> (f h)::(map f t)
;;

(* fold: aka reduce, accumulate, or compress *)
(* recusively processing parts of a datastructure *)
(* ouput of previous function is input of next *)
(* curr appears to be applied every time *)
let rec fold f curr l =
    match l with
    | [] -> curr
    | h::t -> fold f (f h curr) t
;;

(* implement: val fold_dict: (string -> 'a -> 'b -> 'b) -> 'a dist -> 'b *)
(* such that: fold fun base dict returns fold left over in order transeral *)
(* if you swap the location of the aggregator, you will switch between inorder and post order *)
let rec fold_dict f b d =
    match d with
    | Empty -> b
    | Node(k, v, l, r) -> 
        let x = (fold_dict f b l) in
        (fold_dict f (f k v x) r)
;;

let a = fold_dict (fun k v b -> v +. b) 0.0 fruitd;;
let b = fold_dict (fun k v b -> b ^ ", " ^ k) "" fruitd;