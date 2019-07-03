# Building skia bindings with MSVC

Toolchain description:
OCaml compiler: Built with MSVC using fdopen's opam switch
C compiler: MSVC
Flexlink toolchain: MSVC
Skia library: built with MSVC converted to unix .a archive with
dlltool and reimp

The idea is to first resolve flexlink related issues. It's tricky to
load vcvars inside Esy's sandbox. So, we use build it outside esy (on
a bash shell)

## Preparing Skia library

1. Download and install esy-skia
2. Download and build reimp. (As explained here http://www.mingw.org/wiki/msvc_and_mingw_dlls)
   a. Download from
   http://wyw.dcweb.cn/download.asp?path=&file=reimp_new.zip
   b. Edit the Makefile and set `CC = x86_64-W64-mingw32-gcc -o $@`
   c. Run make
   d. Add the current path to PATH for convenience (optional)  
3. cd into the build tree and generate the Unix archive file
   ```sh
   $ export ESY_SKIA_BUILD_TREE=`esy echo '#{self.target_dir}'`
   $ cp skia.def $ESY_SKIA_BUILD_TREE/out/Shared
   $ cp $ESY_SKIA_BUILD_TREE/out/Static/skia.dll $ESY_SKIA_BUILD_TREE/out/Shared/skia.dll
   $ dlltool -U -d skia.def -l libskia.a


## Building the bindings

1. Opening Cygwin shell with fdopen's MSVC built OCaml compiler
   switch. MSVC must be available on this shell too. 
   a. Open a cmd.exe prompt with vcvars loaded. Alternatively,
   call vcvars.bat from an existing cmd.exe prompt
   b. Navigate to the fdopen's ocaml installation and open a bash
   shell
   
   ```sh
   C:\OCamlMS64> mintty.exe --
   ```
   
2. Since we are not using esy to build the bindings, esy installed
   skia must be made visible to dune. Inorder to do this, we must set
   $esy_skia_install (install tree) and $esy_skia_build (build
   tree). load.sh contains an example. Edit to as per your needs.
   
   ```sh
   $ source load.sh
   ```
   
3. Run Dune

    ```sh
    $ dune build
    ```
    
    This should build the bindings library, as well as a consuming
    binary (bin_native). You may now run this binary.
    
    ```sh
    $ ./_build/default/bin_native/test_skia.exe
    
    # or
    
    $ dune exec ./bin_native/test_skia.exe
    ```
    
    If this binary, works as expected, it will create a png rendered
    with skia
    
   
