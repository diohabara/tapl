(* module Support

   Collects a number of low-level facilities used by the other modules
   in the typechecker/evaluator.
*)

(* ------------------------------------------------------------------------ *)
(* Some pervasive abbreviations -- opened everywhere by convention *)
(* 短縮形の定義 *)

module Pervasive : sig
  val pr : string -> unit
end

(* ------------------------------------------------------------------------ *)
(* Error printing utilities -- opened everywhere by convention *)

module Error : sig
  (* An exception raised by the low-level error printer; exported
     here so that it can be caught in module Main and converted into
     an exit status for the whole program. *)
  (* ポインタに関するエラーが生じた際に使う例外 *)
  exception Exit of int

  (* An element of the type info represents a "file position": a
     file name, line number, and character position within the line.
     Used for printing error messages. *)
  (* ファイル情報に関する要素に使う型 *)
  type info

  (* ダミーに使われる値 *)
  val dummyinfo : info

  (* Create file position info: filename lineno column *)
  (* ファイル情報に関するデータを作る関数 *)
  val createInfo : string -> int -> int -> info

  (* ファイル情報を出力する関数 *)
  val printInfo : info -> unit

  (* A convenient datatype for a "value with file info."  Used in
     the lexer and parser. *)
  (* パーサーで用いるファイル情報に関する型 *)
  type 'a withinfo = { i : info; v : 'a }

  (* Print an error message and fail.  The printing function is called
     in a context where the formatter is processing an hvbox.  Insert
     calls to Format.print_space to print a space or, if necessary,
     break the line at that point. *)
  (* エラーメッセージを出してプログラムを終了する *)
  val errf : (unit -> unit) -> 'a

  (* エラーがどこで起きたかを出力 *)
  val errfAt : info -> (unit -> unit) -> 'a

  (* Convenient wrappers for the above, for the common case where the
     action to be performed is just to print a given string. *)
  (* 上の関数をまとめる関数 *)
  val err : string -> 'a

  (* 同上 *)
  val error : info -> string -> 'a

  (* Variants that print a message but do not fail afterwards *)
  (* 上の場合はプログラムが終了するが警告だけで終了はしない *)
  val warning : string -> unit

  (* 警告がどこで起きたかを出力 *)
  val warningAt : info -> string -> unit
end
