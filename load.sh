export OCAMLC_LOC=`ocamlc -where`
export esy_skia_build="C:/Users/manas/development/esy-skia/_esy/default/store/b/esy_skia-75ebbdd1" # $(esy b echo '#{esy-skia.install}')
export esy_skia_install="C:/Users/manas/development/esy-skia/_esy/default/store/i/esy_skia-75ebbdd1" # $(esy b echo '#{esy-skia.target_dir}')
export PKG_CONFIG_PATH="$(cygpath -u $esy_skia_install)/lib"
 
export CFLAGS_MINGW=$(pkg-config --cflags skia)

eval $(./msvs-promote-path)

# export PATH=/cygdrive/c/OCaml64/home/manas/.opam/4.07.1+msvc64c/bin:$PATH
