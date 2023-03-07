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

fun readFileNL fname: int option = 
let
  val instream = TextIO.openIn fname
  val firstline = TextIO.inputLine instream
  val flsize = Option.map size firstline
in  
  TextIO.closeIn instream;
  flsize
end

fun updateFile (fname) (filecontent) (flsize) = 
let 
  val outstream = TextIO.openOut fname
  val localsize = size filecontent
in
  TextIO.output (outstream, "(*");
  TextIO.output (outstream, String.substring (filecontent, 0, flsize - 1));
  TextIO.output (outstream, "*)\n");
  TextIO.output (outstream, String.substring (filecontent, flsize, size filecontent - flsize));
  TextIO.closeOut outstream
end

fun useSreamFile (fname) = 
let 
  val instream = TextIO.openIn fname
in
  Backend.Interact.useScriptFile (fname, instream)
end

fun processFile fname = 
let
  val isscript = isScript fname
  val oldcontent = readFile fname
  val flsize = readFileNL fname
  val newcontent = String.substring (oldcontent, 0, size oldcontent)
in
  if (isscript) = true  
  then 
    (
      updateFile fname oldcontent (Option.valOf flsize);
      useSreamFile fname
    )
  else
    print "!* Script file doesn't start with #!. \n"
end


