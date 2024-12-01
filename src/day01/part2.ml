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
  let similiarity =
    List.sum
      ~f:(fun l ->
        let count = List.count ~f:(Int.equal l) right_list in
        l * count)
      (module Int)
      left_list
  in
  printf "%d\n" similiarity
