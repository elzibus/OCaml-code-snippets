
(*
  Simple OCaml example to 1) write json to a file, 2) read a json file
  
  Based on https://github.com/ocaml-community/yojson

  The simple dummy data contains 'save' information for a list of two points.
  The contents of the resulting json file is:
  
  {"save":[{"object":"point","x":34,"y":48},{"object":"point","x":12,"y":78}]}
  
 *)

#use "topfind";;
#require "yojson" ;;

(* Prepare the data and write to 'test.json' *)

let entry1 = `Assoc ([("object", `String "point");
                      ("x", `Int 34);
                      ("y", `Int 48)
               ]) ;;

let entry2 = `Assoc ([("object", `String "point");
                      ("x", `Int 12);
                      ("y", `Int 78)
               ]) ;;

let json_write = `Assoc ([("save",
                           `List ([ entry1; entry2 ]))   (* to illustrate that this is a normal OCaml list *)
                   ]) ;;

let () = Yojson.Safe.to_file "test.json" json_write ;;

(* Read back from the json file and display data *)

let parse_cmd cmd =
  let open Yojson.Basic.Util in
  Format.printf "\n" ;
  Format.printf "Object: %s\n" (cmd |> member "object" |> to_string) ;
  Format.printf "x : %d\n"     (cmd |> member "x"      |> to_int) ;
  Format.printf "y : %d\n"     (cmd |> member "y"      |> to_int) ;;

let json_read = Yojson.Basic.from_file "test.json" in
    let open Yojson.Basic.Util in
    let cmd_list = json_read |> member "save" |> to_list in
    List.iter (fun cmd -> parse_cmd cmd ) cmd_list ;;

