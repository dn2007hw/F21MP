(* mutecompiler.sml
 *
 * COPYRIGHT (c) 2017 The Fellowship of SML/NJ (http://www.smlnj.org)
 * All rights reserved.
 *)

functor Mutecompiler() : MUTECOMPILER =
  struct

  (* compile and execute the contents of a file. *)
  local    
    val printingLimitRefs =
          let open Control.Print
          in [
              printDepth, (* default: 5 *)
              printLength, (* default: 12 *)
              stringDepth, (* default: 70 *)
              intinfDepth (* default: 70 *)
              ]
          end;

    val savedControlPrintOut = ref NONE;

    val savedPrintingLimitSettings = ref NONE;
        
    val compilerOutputPreviousFullLines = ref ([] : string list);
    
    val compilerOutputCurrentLine = ref ([] : string list);

  in
        (* 121 *)
    fun isNewline #"\n" = true
      | isNewline _ = false;

    (* 122 *)
    fun push stack item = stack := item :: ! stack; 

    (* 221 *)
    fun installPrintingLimitSettings settings =
          ListPair.app (op :=) (printingLimitRefs, settings);

    (* 11 *)
    fun saveControlPrintOut () = 
            if isSome (! savedControlPrintOut)
            then ()
            else savedControlPrintOut := SOME (! Control.Print.out);

    (* 12 *)
    fun stashCompilerOutput string
      = case String.fields isNewline string   
         of nil => raise (Fail "impossible ") (* 121 *)
          | [chunk] => push compilerOutputCurrentLine chunk (* 122 *)
          | chunk :: lines
            => (if chunk <> "" then push compilerOutputCurrentLine chunk else ();
                push compilerOutputPreviousFullLines
                     (String.concat (rev (! compilerOutputCurrentLine)));
                let val (last :: others) = rev lines
                in app (push compilerOutputPreviousFullLines)
                       (rev others);
                   compilerOutputCurrentLine
                   := (if last <> "" then [last] else [])
                end);
        
    (* 13 *)
    fun savePrintingLimits () =
            if isSome (! savedPrintingLimitSettings)
            then ()
            else savedPrintingLimitSettings := SOME (map ! printingLimitRefs);

    (* 14 *)
    fun lowerPrintingLimitsToMin () =
          List.app (fn r => r := 0) printingLimitRefs;

    (* 21 *)
    fun restoreControlPrintOut () =
            case ! savedControlPrintOut of
                NONE => ()
              | SOME value => (savedControlPrintOut := NONE;
                               Control.Print.out := value);
    (* 22 *)
    fun restorePrintingLimits () =
            case ! savedPrintingLimitSettings of
                NONE => ()
              | SOME settings => (savedPrintingLimitSettings := NONE;
                                  installPrintingLimitSettings settings); (* 221*)
    
    (* 1 *)
    fun silenceCompiler () =
           (saveControlPrintOut ();  (* 11 *)
            Control.Print.out := { flush = fn () => (), say = stashCompilerOutput }; (* 12 *)
            savePrintingLimits (); (* 13 *)
            lowerPrintingLimitsToMin ()); (* 14 *)

    (* 2 *)    
    fun unsilenceCompiler () = (restoreControlPrintOut (); (* 21 *)
                                restorePrintingLimits ()); (* 22 *)
  end

  end (* functor Mutecompiler *)
