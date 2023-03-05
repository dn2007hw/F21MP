(* file02.sml *)
(* val _ = Control.setSuccML true; *)
(*
fun readCharStream (stream : TextIO.instream) =
  let
    val c = TextIO.input1 stream
  in
    case c of
      SOME #"#" =>
        (
        (*  case TextIO.input1 stream of
          SOME "!" => true
        | _ => false *)
        case TextIO.lookahead stream of
          SOME #"!" => print "Next character is #\n"
        | SOME c => print ("Next character is " ^ Char.toString c ^ "\n")
        | NONE => print "No more characters in stream\n"
        )
    | _ => false
  end
*)

fun readCharStream (stream : TextIO.instream) =
  let
    val c = TextIO.input1 stream
  in
   case c of
      SOME #"#" => print "character is #\n"
    | SOME #"!" => print "character is !\n"
    | SOME c => print ("character is " ^ Char.toString c ^ "\n")
    | NONE => print "No more characters in stream\n"
  end

fun readCharStreamN (stream : TextIO.instream) =
  let
    val c = TextIO.input1 stream
    val n = TextIO.lookahead stream
  in
   case c of
      SOME #"\n" => (print ("New line.\n"); readCharStreamN stream )
    | SOME c => (print ("character is " ^ Char.toString c ^ " and next character is " ^ Char.toString c ^ "\n");  readCharStreamN stream )
    | NONE => print "No more characters in stream\n"
  end

fun readCharStreamN1 (stream : TextIO.instream) =
  let
    val c = TextIO.input1 stream
    val n = TextIO.lookahead stream
  in
   case c of
      SOME #"\n" => (print ("New line.\n"); readCharStreamN1 stream )
    | SOME #"#" => (print ("character is #\n"); (
        case TextIO.lookahead stream of
          SOME #"!" => print ("---!---\n")
          | NONE => ()); readCharStreamN1 stream )
    | SOME c => (print ("character is " ^ Char.toString c ^ "\n");  readCharStreamN1 stream )
    | NONE => print "No more characters in stream\n"
  end

fun readChar (instream : TextIO.instream) =
  case TextIO.input1 instream of
    SOME c => if Char.toString c = "\n" then ()  
              else (print (Char.toString c); readChar (instream))
  | NONE => TextIO.closeIn instream

fun pc () = 
  let
    val stream = TextIO.openIn "code01.sml"
    val _ = readChar stream
  in
    TextIO.closeIn stream
  end

fun pcs () = 
  let
    val stream = TextIO.openIn "code01.sml"
    val _ = readCharStream stream
  in
    TextIO.closeIn stream
  end

fun pcsn () = 
  let
    val stream = TextIO.openIn "code03.sml"
    val _ = readCharStreamN stream
  in
    TextIO.closeIn stream
  end

fun pcsn1 () = 
  let
    val stream = TextIO.openIn "code03.sml"
    val _ = readCharStreamN1 stream
  in
    TextIO.closeIn stream
  end

fun pcsn2 () = 
  let
    val stream = TextIO.openAppend "code03.sml"
  in
    TextIO.output(stream, "This is a message to write to your stream.");
    TextIO.closeOut stream
  end
(*
fun adds () = 
  let
    val stream = TextIO.openIn "code03.sml"
    val newStream = Stream.from (fn () => SOME #"W") :: stream
  in
    TextIO.closeIn stream
  end
*)
(*

fun concatenate(s1: 'a TextIO.instream, s2: 'a TextIO.instream): 'a TextIO.instream =
  case s1 of
    Null       => s2
  | Cons(h, t) => Cons(h, fn () => concatenate(t(), s2))

fun scon () = 
  let
    val stream = TextIO.openIn "code01.sml"
(*)    val _ = fn () => concatenate(stream, stream)) *)
    val _ = concatenate(stream, stream)
  in
    TextIO.closeIn stream
  end
 
*)






(*
val stream = TextIO.openIn "input.txt"
case TextIO.lookahead stream of
  SOME '#' => print "Next character is #\n"
| SOME '!' => print "Next character is !\n"
| SOME c => print ("Next character is " ^ Char.toString c ^ "\n")
| NONE => print "No more characters in stream\n"
TextIO.closeIn stream




if Char.toString c = #"\n" then ()
              else (print (Char.toString c); readUntilNewline ())

  case TextIO.input1 instream of
    SOME c => if Char.toString c = #"\n" then ()
              else (print (Char.toString c); readUntilNewline ())
  | NONE => TextIO.closeIn instream

*)