(* wi11 problem 2 *)

(* python-style namespaces using ocaml *)

type name_space = 
| EmptyNameSpace 
| Info of (string * value) list * name_space and 
    value = 
    | Int of int 
    | Method of (name_space -> int -> int)

(* testing...
let top_ns = Info([("derp",Int(1))], EmptyNameSpace)
let sub_ns = Info([("herp",Int(5))], top_ns)
*)

(* python

class SimpleObj1:
    a = 0
    def f(self, i): return i + 1

class SimpleObj2(SimpleObj1):
    def g(self, i): return i + 2

SimpleObj2()

*)

(* conversion of python to ocaml *)

let method_f self i = i + 1;;
let simpleObj1 = Info([("a", Int(0)); ("f", Method(method_f))], EmptyNameSpace)

let method_g self i = i + 2
let simpleObj2 = Info([("g", Method(method_g))], simpleObj1)

(* Problem 2a *)

(* implement: lookup: name_space -> string -> value *)

let rec lookup ns key = 
    let rec find k l = 
        match l with
        | [] -> raise Not_found
        | (key, value)::t -> 
            if key = k then value else (find k t)
    in
    match ns with
    | EmptyNameSpace -> raise Not_found 
    | Info(keys, parent) ->
        try (find key keys)
        with
        | Not_found ->
            (lookup parent key)
;;


(* Problem 2b *)

exception TypeError
let to_int value =
    match value with 
    | Int(i) -> i
    | _      -> raise TypeError

let to_method value = 
    match value with 
    | Method(m) -> m
    | _         -> raise TypeError

(* python

class SimpleObj3:
    a = 10
    def f(self, i): return self.a + i 

OBJ3 = SimpleObj3()

*)

(* redo python in ocaml - self is a namespace! *)

let method_f self i = (to_int (lookup self "a")) + i 

let obj3 = Info([("a", Int(10)); ("f", Method(method_f))], EmptyNameSpace)

(* Problem 2c *)

(* invoke_method: name_space -> string -> int -> int *)

let invoke_method self name i = (to_method (lookup self name)) self i

let f_result = invoke_method obj3 "f" 3
