open Base
open Stdio

let is_increasing = List.is_sorted ~compare:Int.compare

let is_decreasing = List.is_sorted ~compare:(Fn.flip @@ Int.compare)

let is_safe_difference l =
  let rec loop l =
    match l with
    | x :: y :: rest ->
      let d = Int.abs (x - y) in
      d >= 1 && d <= 3 && loop (y :: rest)
    | _ -> true
  in
  loop l

let is_safe l = (is_increasing l || is_decreasing l) && is_safe_difference l

let () =
  let lines = In_channel.read_lines "data/day02.txt" in
  let count =
    lines
    |> List.map ~f:(fun line ->
           line |> String.split ~on:' ' |> List.map ~f:Int.of_string)
    |> List.count ~f:is_safe
  in
  printf "%d\n" count
