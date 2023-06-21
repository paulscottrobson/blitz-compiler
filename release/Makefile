# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Build Emulator
#		Date :		21st June 2023
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

.phony : all

#
#		Build release.
#
all: system crossdev
	$(CCOPY) $(BINDIR)x16emu* .
	$(CCOPY) $(BINDIR)rom.bin .
	$(CCOPY) $(BINDIR)*.dll .

	$(CCOPY) $(BINDIR)blitz .
	$(CCOPY) $(BINDIR)blitz.exe .
	
	$(CCOPY) $(BINDIR)tokenise.zip .
	$(CCOPY) ..$(S)TODO .
	$(CCOPY) ..$(S)CHANGES .

	$(CDEL) release.zip
	zip -r -q 	release.zip * 
	zip -d -q release.zip memory.dump Makefile

#
#		Build Linux emulator. Must force build of Windows version manually on Virtualbox or Windows MC.
#
crossdev:
	make -C ../crossdev clean
	make -C ../crossdev emulator
	make -C ../crossdev clean
#
#		Build the original compiler and runtime
#
system:
	make -C ../source
