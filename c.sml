
(* c.sml *)

fun cube x = x * x * x ;
fun square x = x * x ;
(* 
  operator domain: {flush:unit -> unit, say:string -> unit} ref
                    * {flush:unit -> unit, say:string -> unit}
  operand:         {flush:unit -> unit, say:string -> unit} ref * string

*)