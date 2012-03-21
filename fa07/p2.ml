(* Problem 2 *)

type mix = Int of int | Bool of bool

let ans x = 
    match x with 
    | -2 -> Bool false
    | -1 -> Bool true
    | _ -> Int x 

(* ans = int -> mix = <fun> *)

let ans f g x = 
    if f x then x else g x

(* ans = ('a -> bool) ->('a -> 'a) -> 'a -> 'a = <fun> *)

let ans b f g = 
    (fun x -> (if b then f else g) x)

(* ans = bool -> ('a ->'b)  -> ('a -> 'b) -> 'a -> 'b *)

let rec ans x ys = 
    match ys with
    | [] -> x
    | y::ys' -> ans (y x) ys'

(* ans = 'a -> ('a -> 'a) list -> 'a  *)