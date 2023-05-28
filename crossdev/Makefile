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

BINDIR = ..$(S)bin$(S)
APPNAME = blitz$(APPSTEM)
RELEASE = ../release
SOURCES = 	src$(S)core$(S)sys_processor.o  framework$(S)main.o framework$(S)gfx.o framework$(S)debugger.o \
			src$(S)core$(S)sys_debugger.o src$(S)core$(S)hardware.o 
  
CC = g++

.PHONY: all clean emulator prebuild release run

all: emulator

exec: tokenise compile run

tokenise:
	$(PYTHON) $(BINDIR)tokenise.zip balls.bas source.prg

compile: emulator
	..$(S)bin$(S)$(APPNAME) 

run:
	$(BINDIR)x16emu$(APPSTEM) -prg target.prg,801 -scale 2 -run

emulator: prebuild $(APPNAME)
	$(CCOPY) $(APPNAME) ..$(S)bin 
	
%.o:%.cpp
	$(CC) $(CADDRESSES) $(CXXFLAGS) -D INCLUDE_DEBUGGING_SUPPORT -I cpu -I framework -I include -c -o $@ $<

clean:
	$(CDEL) src$(S)*.o 
	$(CDEL) src$(S)core$(S)*.o 
	$(CDEL) framework$(S)*.o

$(APPNAME): $(SOURCES)
	$(CC) $(SOURCES) $(LDFLAGS) $(SDL_LDFLAGS) -o $@

prebuild:
	make -C processor
	make -C keyboard

update:
	make -B -C ../source
	make -C binaries

#
#		Build / Copy relevant files to Release
#	
release: update emulator
	$(CCOPY) $(BINDIR)x16emu* $(RELEASE)
	$(CCOPY) $(BINDIR)rom.bin $(RELEASE)
	$(CCOPY) $(BINDIR)*.dll $(RELEASE)
	$(CCOPY) $(BINDIR)tokenise.zip $(RELEASE)
	$(CCOPY) ..$(S)TODO $(RELEASE)
	$(CCOPY) blitz* $(RELEASE)
	$(CDEL) $(RELEASE)release.zip
	cd $(RELEASE) ; zip -r release.zip * ; zip -d release.zip *.prg memory.dump
