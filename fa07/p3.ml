(* Problem 3 *)

let rec fac x =
    if x <= 1 
    then 1
    else x * fac (x - 1)

let fac_tail x =
    let rec helper x curr = 
        if x <= 1 
        then curr
        else helper (x - 1) (x * curr)
    in
    helper x 1
;; 

let rec map f xs = 
    match xs with 
    | [] -> []
    | x::xs' -> (f x)::(map f xs')

let map_tail f xs = 
    let rec helper xs ls = 
        match xs with
        | [] -> ls
        | x::xs' -> (helper xs' (ls@(f x)))
    in
    helper xs []

(* fold right *)
let rec foldr f xs b = 
    match xs with
    | [] -> b
    | x::xs' -> f x (foldr f xs' b)

let foldr_tail f xs b = 
    let rec helper xs b =
        match xs with
        | [] -> b 
        | x::xs' -> f x (helper xs' b)
    in 
    helper xs b