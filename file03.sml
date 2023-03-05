(* file02.sml *)

fun readCharStream (stream : TextIO.instream, insertStar : bool) =
  let
    val c = TextIO.input1 stream
  in
    case (c, insertStar) of
      (SOME "#", true) =>
        (TextIO.input1 stream; TextIO.output (stream, "*"); true)
    | (SOME "!", true) => true
    | _ => false
  end


val stream = TextIO.openIn "code01.sml";
val outstream = TextIO.openOut "code02.sml";
val startsWithBang = readCharStream (stream, true);
TextIO.seekStream (stream, TextIO.POS{offset=0, whence=TextIO.SEEK_ABS});
readCharStream (stream, false);
TextIO.output (outstream, "*#!");
TextIO.copyStream (stream, outstream);
TextIO.closeIn stream;
TextIO.closeOut outstream;
