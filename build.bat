@ECHO OFF
set esy_skia_include=%esy_skia_install%/include
@call "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars64.bat"
@echo "Compiling..."
@dune build --root . --verbose

