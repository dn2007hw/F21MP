(* file01.sml *)

    fun evalLoop source = let
	  val parser = SmlFile.parseOne source
	  (* val cinfo = C.mkCompInfo { source = source, transform = fn x => x } *)
    in
    val _ = Control.print.say
    end  
  
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


    fun evalStream1 (fname, stream) = let
	  val interactive = isTermIn stream
	  val source = Source.newSource (fname, stream, interactive, ErrorMsg.defaultConsumer ())
	  in
	    evalLoop source
	      handle exn => (
		  Source.closeSource source;
		  case exn
		   of EndOfFile => ()
		    | _ => raise exn
		  (* end case *))
	  end


(* 
    val source = Source.newSource (fname, stream, interactive, ErrorMsg.defaultConsumer ())
    val source = Source.newSource ("c.sml", strm1, interactive, ErrorMsg.defaultConsumer ())

    *)
end