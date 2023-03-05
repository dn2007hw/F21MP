(* d.sml *)
    fun isTermIn f = let
	  val (rd, buf) = TextIO.StreamIO.getReader(TextIO.getInstream f)
	  val isTTY = (case rd
		 of TextPrimIO.RD{ioDesc = SOME iod, ...} => (OS.IO.kind iod = OS.IO.Kind.tty)
		  | _ => false
		(* end case *))
	  in
	  (* since getting the reader will have terminated the stream, we need
	   * to build a new stream.
	   *)
	    TextIO.setInstream(f, TextIO.StreamIO.mkInstream(rd, buf));
	    isTTY
	  end



val fname = "c.sml"
(* val fname = "exml03" *)
val strm = TextIO.openIn fname
val interactive = isTermIn strm
val source = Source.newSource (fname, strm, interactive, ErrorMsg.defaultConsumer ())
(* val () = EvalLoop.evalStream ("<instream>", strm) *)
(* val () = Backend.Interact.evalStream fname strm *)
val () = Backend.Interact.useStream strm;

(*

q`val () = TextIO.setInstream (valOf (! usedImpInStreamRef), TextIO.getInstream (valOf (! fileImpInStreamRef)))(*#line 1.1 "^(String.toString scriptFile)"*); val () = ();`)


*)