# ***********************************************************************************
#
#										Common Build 
#
# ***********************************************************************************
#
#	NB: Windows SDL2 is hard coded.
#
ifeq ($(OS),Windows_NT)
CCOPY = copy
CMAKE = make
CDEL = del /Q
CDELQ = >NUL
APPSTEM = .exe
S = \\
SDLDIR = C:\\sdl2
CXXFLAGS = -I$(SDLDIR)$(S)include$(S)SDL2 -I . -fno-stack-protector -w -Wl,-subsystem,windows -DSDL_MAIN_HANDLED
LDFLAGS = -lmingw32
SDL_LDFLAGS = -L$(SDLDIR)$(S)lib -lSDL2 -lSDL2main -static-libstdc++ -static-libgcc
OSNAME = windows
EXTRAFILES = libwinpthread-1.dll  SDL2.dll
PYTHON = python
else
CCOPY = cp
CDEL = rm -f
CDELQ = 
CMAKE = make
APPSTEM =
S = /
SDL_CFLAGS = $(shell sdl2-config --cflags)
SDL_LDFLAGS = $(shell sdl2-config --libs)
CXXFLAGS = $(SDL_CFLAGS) -O2 -DLINUX  -fmax-errors=5 -I.  
LDFLAGS = 
OSNAME = linux
EXTRAFILES = 
PYTHON = python3
endif
#
#		Directories
#
ROOTDIR =  $(dir $(realpath $(lastword $(MAKEFILE_LIST))))..$(S)
BINDIR = $(ROOTDIR)bin$(S)
SRCDIR = $(ROOTDIR)source$(S)
CSCRIPTS = $(SRCDIR)common-scripts$(S)
CSOURCE =  $(SRCDIR)common-source$(S)
#
#		Current applications.
# 
ASM = 64tass -c -Wall -o build$(S)code.prg -L build$(S)code.lst -l build$(S)code.lbl
PYTHON = python3
EMULATOR = $(BINDIR)x16emu$(APPSTEM) -scale 2 -debug 
EXECUTE = $(CDEL) dump*.bin ; $(EMULATOR) -prg build$(S)code.prg,1000 -run
QEXECUTE = $(EXECUTE) -testbench
FAST = -warp
#
#		Export path to the common scripts.
#
ifeq ($(OS),Windows_NT)
SET PYTHONPATH=$(CSCRIPTS)
else
export PYTHONPATH=$(CSCRIPTS)
endif
#
#		Uncommenting .SILENT will shut the whole build up.
#
ifndef VERBOSE
#.SILENT:
endif