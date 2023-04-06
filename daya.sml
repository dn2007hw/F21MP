(* daya.sml
 *
 * COPYRIGHT (c) 2017 The Fellowship of SML/NJ (http://www.smlnj.org)
 * All rights reserved.
 *)

(*  functor daya() : DAYA = *) 
 structure Daya : DAYA = 
  struct
    local

      val dayachar = ref NONE;
    in

      fun dayafn () = (
        print "daya test"
    );
    end
  end 

