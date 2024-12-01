open Base
open Stdio

let () =
  let lines = In_channel.read_lines "data/day01.txt" in
  let re =
    Re.compile
      Re.(seq [group @@ rep digit; no_group @@ rep space; group @@ rep digit])
  in
  let list_of_pairs =
    List.map
      ~f:(fun line ->
        let matched = Re.exec re line in
        let a = Re.Group.get matched 1 in
        let b = Re.Group.get matched 2 in
        (Int.of_string a, Int.of_string b))
      lines
  in
  let left_list, right_list = List.unzip list_of_pairs in
  let left_sorted = List.sort ~compare:Int.compare left_list in
  let right_sorted = List.sort ~compare:Int.compare right_list in
  let similiarity =
    List.zip_exn left_sorted right_sorted
    |> List.sum ~f:(fun (a, b) -> Int.abs (a - b)) (module Int)
  in
  printf "%d\n" similiarity
