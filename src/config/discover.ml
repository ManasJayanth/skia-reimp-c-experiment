open Configurator.V1

let () =
main ~name:"discover" (fun c ->
let default: Pkg_config.package_conf = { libs = []; cflags = [] } in
let config =
  match Pkg_config.get c with
  | None -> default
  | Some pkg_config ->
     match (Pkg_config.query pkg_config ~package:"skia") with
     | None -> default
     | Some deps -> deps
in

Flags.write_sexp "cxx_flags.sexp" (config.cflags @ [ "-I" ^ Sys.getenv "esy_skia_build" ]);
Flags.write_sexp "opt_flags.sexp" []; (* [ "skia.lib" ]; *)
Flags.write_sexp "c_library_flags.sexp" (config.libs @ ["-L" ^ Sys.getenv "esy_skia_build" ^ "/out/Static"; Sys.getenv "esy_skia_build" ^ "/out/Shared/libskia.a"; ]))
(* Flags.write_sexp "c_library_flags.sexp" (config.libs @ ["-LC:/Users/manas/.esy/3_/i/esy_skia-424cdba7/lib"])) *)
