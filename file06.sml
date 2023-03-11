(* file05.sml *)

fun checkSharpbang (stream : TextIO.instream): bool =
  let
    val c = TextIO.input1 stream
  in
   print "checkSharpbang \n";
   case c of
      SOME #"#" => (
        case TextIO.lookahead stream of
          SOME #"!" => true
        | SOME c => checkSharpbang stream
        | NONE => false
        )
    | SOME c => checkSharpbang stream
    | NONE => false
  end

fun isScript fname: bool = 
  let
    val stream = TextIO.openIn fname
    val withsharpbang = checkSharpbang stream
  in 
    print "isScript \n";
    TextIO.closeIn stream;
    withsharpbang
  end

fun readFile fname: TextIO.vector = 
let
  val instream = TextIO.openIn fname
  val filecontent = TextIO.inputAll instream
in  
  print "readFile \n";
  TextIO.closeIn instream;
  filecontent
end

fun readFirstLine fname: int option = 
let
  val instream = TextIO.openIn fname
  val firstline = TextIO.inputLine instream
  val flsize = Option.map size firstline
in  
  print "readFirstLine \n";
  TextIO.closeIn instream;
  flsize
end

fun updateFile (fname) (filecontent) (flsize) = 
let 
  val outstream = TextIO.openOut fname
in
  print "updateFile \n";
  TextIO.output (outstream, "(* ");
  TextIO.output (outstream, String.substring (filecontent, 0, flsize - 1));
  TextIO.output (outstream, " *)\n");
  TextIO.output (outstream, String.substring (filecontent, flsize, size filecontent - flsize));
  TextIO.closeOut outstream
end

fun useSreamFile (fname) = 
let 
  val instream = TextIO.openIn fname
in
  print "useStreamFile \n";
  Backend.Interact.useScriptFile (fname, instream);
  OS.Process.exit OS.Process.success
end

fun processFile fname = 
let
  val isscript = isScript fname
  val oldcontent = readFile fname
  val flsize = readFirstLine fname
in
  print "Begin script.\n";
  if (isscript) = true  
  then 
    (
      updateFile fname oldcontent (Option.valOf flsize);
      useSreamFile fname
    )
  else
      print "!* Script file doesn't start with #!. \n";
  print "End of script processing.\n"
end


