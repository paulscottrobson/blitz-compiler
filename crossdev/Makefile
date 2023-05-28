# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Build Emulator
#		Date :		10th May 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\documents\common.make
else
include ../documents/common.make
endif

APPNAME = blitz$(APPSTEM)

SOURCES = 	src$(S)core$(S)sys_processor.o  framework$(S)main.o framework$(S)gfx.o framework$(S)debugger.o \
			src$(S)core$(S)sys_debugger.o src$(S)core$(S)hardware.o 
  
CC = g++

.PHONY: all clean emulator prebuild release run

all: emulator

run: emulator
	..$(S)bin$(S)$(APPNAME) binaries/blitz.prg@7FF binaries/basic_code.bin@

run2: emulator
	..$(S)bin$(S)$(APPNAME) binaries/runcompiler.prg@7FF
	
emulator: prebuild $(APPNAME)
	$(CCOPY) $(APPNAME) ..$(S)bin 
	
%.o:%.cpp
	$(CC) $(CADDRESSES) $(CXXFLAGS) -D INCLUDE_DEBUGGING_SUPPORT -I cpu -I framework -I include -c -o $@ $<

clean:
	$(CDEL) $(APPNAME) 
	$(CDEL) src$(S)*.o 
	$(CDEL) framework$(S)*.o

$(APPNAME): $(SOURCES)
	$(CC) $(SOURCES) $(LDFLAGS) $(SDL_LDFLAGS) -o $@

prebuild:
	make -C processor
	make -C keyboard

compiler:
	make -B -C ../source all basic
	$(CCOPY) ../source/build/blitz.prg binaries
	$(CCOPY) ../source/build/runtime.prg binaries
	$(CCOPY) ../source/build/temp/runcompiler.prg binaries