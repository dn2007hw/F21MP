(* a.sml *)
structure A =
struct

  fun f() =
  let
    val tb = ref("")
  in
      (
        (* Compiler.Control.Print.out := { *)
        Control.Print.out := {
                                        say=fn s => tb := concat [!tb, s],
                                        flush=fn() => ()
                                      } ;
        ()
      )
  end

end

(* Control.Print.out *)