(* file05.sml *)

fun updateFile (fname) (instream : TextIO.instream) = 
let 
  val outstream = TextIO.openOut fname
  val filecontent = TextIO.inputAll instream
in
  print "updateFile \n";
  TextIO.output (outstream, filecontent);
  TextIO.closeOut outstream
end

fun eatnll (stream : TextIO.instream): bool =
  let
    val c = TextIO.input1 stream
  in
    case TextIO.lookahead stream of
          SOME #"\n" => ( 
           (* Backend.Interact.useScriptFile ("DAYAs", stream); *)
                        true )
        | SOME c => eatnll stream
        | NONE => false
  end

fun checkSharpbang (stream : TextIO.instream): bool =
  let
    val c = TextIO.input1 stream
  in
   case c of
      SOME #"#" => (
        case TextIO.lookahead stream of
          SOME #"!" => eatnll stream
        | SOME c => checkSharpbang stream
        | NONE => false
        )
    | SOME c => checkSharpbang stream
    | NONE => false
  end
 


fun pf fname = 
let
  val stream = TextIO.openIn fname
  val isscript = checkSharpbang stream
in
  if (isscript) = false  
  then 
    (print "!* Script file doesn't start with #!. \n")
  else
    ( updateFile "exml1" stream )
end

val () = pf "exml0";