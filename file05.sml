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

fun readFile fname: vector = 
let
  val instream = TextIO.openIn fname
  val data = TextIO.inputAll instream
in  
  TextIO.closeIn instream;
  data
end

fun updateFile (fname) (data) = 
let 
  val outstream = TextIO.openOut fname
in
  TextIO.output (outstream, "(");
  TextIO.output (outstream, "*");
  TextIO.output (outstream, ")");
  TextIO.output (outstream, data); 
  TextIO.closeOut outstream
end

fun processFile fname = 
let
  val isscript = isScript fname
  val data = readFile fname
  val newdata = String.substring (data, 0, size data)
in
  if (isscript) = true  
  then 
    updateFile fname newdata
  else
    print ""
end


