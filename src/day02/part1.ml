open Base
open Stdio

let is_increasing = List.is_sorted ~compare:Int.compare

let is_decreasing = List.is_sorted ~compare:(Fn.flip @@ Int.compare)

let is_safe l =
  let rec loop l =
    match l with
    | x :: y :: rest ->
      let d = Int.abs (x - y) in
      d >= 1 && d <= 3 && loop (y :: rest)
    | _ -> true
  in
  loop l

let () =
  let lines = In_channel.read_lines "data/day02.txt" in
  let count =
    lines
    |> List.map ~f:(fun line ->
           line |> String.split ~on:' ' |> List.map ~f:Int.of_string)
    |> List.filter ~f:(fun levels ->
           (is_increasing levels || is_decreasing levels) && is_safe levels)
    |> List.length
  in
  printf "%d\n" count
