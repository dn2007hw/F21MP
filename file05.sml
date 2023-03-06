(* file05.sml *)

fun checkSharpbang (stream : TextIO.instream): bool =
  let
    val c = TextIO.input1 stream
  in
   case c of
      SOME #"\n" => checkSharpbang stream
    | SOME #"#" => (
        case TextIO.lookahead stream of
          SOME #"!" => true
        | SOME c => checkSharpbang stream
        | NONE => checkSharpbang stream
        )
    | SOME c => checkSharpbang stream
    | NONE => false
  end

fun isScript fname: bool = 
  let
    val stream = TextIO.openIn fname
    val withsharpbang = checkSharpbang stream
  in 
    TextIO.closeIn stream;
    withsharpbang
  end

fun readFile fname: TextIO.vector = 
let
  val instream = TextIO.openIn fname
  val filecontent = TextIO.inputAll instream
in  
  TextIO.closeIn instream;
  filecontent
end

fun updateFile (fname) (filecontent) = 
let 
  val outstream = TextIO.openOut fname
in
  TextIO.output (outstream, "(");
  TextIO.output (outstream, "*");
  TextIO.output (outstream, ")");
  TextIO.output (outstream, filecontent); 
  TextIO.closeOut outstream
end

fun useSreamFile (fname) = 
let 
  val instream = TextIO.openIn fname
in
  Backend.Interact.useStream instream
end

fun processFile fname = 
let
  val isscript = isScript fname
  val oldcontent = readFile fname
  val newcontent = String.substring (oldcontent, 0, size oldcontent)
in
  (* Control.setSuccML true; *)
  if (isscript) = true  
  then 
  (*
    (updateFile fname newcontent;
    use fname)
    *)
    (updateFile fname newcontent;
    useSreamFile fname)
  else
    print "!* Script file doesn't start with #!. \n"
end


