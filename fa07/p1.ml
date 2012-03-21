(* Problem 1a *)

let ans = 
    let rec foo n f x = 
        if n <= 0 then x else foo (n - 1) f (f x) in
    foo 100 (fun y -> y + 1) 0

(* 
    n   f   x 
    100 y+1 0
    99  '   1
    98  '   2
    ...
    0   '   100
    
    ans = 100 
*)

let ans = 
    let foo =
        let x = 1 in
        (fun y -> let x = x + y in x) in
    (foo 100, foo 1000)

(* ans = (101, 1001) *)

let ans = 
    let rec foo xs ys =
        match xs, ys with 
        | x::xs', y::ys' -> (x, y)::(foo xs' ys') 
        | _,_ -> [] 
    in
    foo [1;2;3] ["a";"b"]

(* 
    appears to be merging lists
    ans = [(1, "a");(2, "b")]
*)

type mix = Int of int | Bool of bool 
let ans = 
    let foo x = 
        match x with
        | 0 -> Bool true
        | -1 -> Bool false
        | _ -> Int x 
    in
    foo 12

(* ans = Int 12 *)

let ans = 
    let f g = fun x -> g (g x) in
    let h = f f (fun x -> x * 10) in
    h 1

(* 
    f g x = g (g x)
    h x = f (f (fun x -> x * 10))

    ans = f (10 * (x * 10))
    ans = (10 * ((10 * (x * 10)) * 10))
    ans = 1000
*)