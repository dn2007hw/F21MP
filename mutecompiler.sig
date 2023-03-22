(* mutecompiler.sig
 *
 * COPYRIGHT (c) 2019 The Fellowship of SML/NJ (http://www.smlnj.org)
 * All rights reserved.
 *)

signature MUTECOMPILER =
  sig

    val isNewline : char -> bool
    val push : 'a list ref -> 'a -> unit
    val installPrintingLimitSettings : int list -> unit
    val saveControlPrintOut : unit -> unit
    val stashCompilerOutput : string -> unit
    val savePrintingLimits : unit -> unit
    val lowerPrintingLimitsToMin : unit -> unit
    val restoreControlPrintOut : unit -> unit
    val restorePrintingLimits : unit -> unit   
    val silenceCompiler : unit -> unit
    val unsilenceCompiler : unit -> unit

  end  (* signature MUTECOMPILER *)
