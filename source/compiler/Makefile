# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	compiler library makefile.
#		Date :		5th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\..\documents\common.make
else
include ../../documents/common.make
endif


all: build

BASICSRC = build$(S)hello.bas

prelim: tokenise
	make -C ../common-source
	$(PYTHON) scripts$(S)genx16.py
	$(PYTHON) scripts$(S)gencom.py 
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)compiler.library

tokenise:
	$(PYTHON) $(BINDIR)tokenise.zip $(BASICSRC) testing$(S)code$(S)tokenised.dat
	#$(CCOPY) build$(S)PROTEUS7.PRG testing$(S)code$(S)tokenised.dat

build: prelim
	$(ASM) testing$(S)testing.asm $(BINDIR)compiler.library $(BINDIR)common.library $(BINDIR)ifloat32.library testing$(S)testend.asm

run: build
	$(CDEL) CODE.BIN
	$(EXECUTE) 
	$(CCOPY) CODE.BIN ..$(S)runtime$(S)testing$(S)code$(S)code.bin
	$(PYTHON) $(CSCRIPTS)compileinfo.py >testing$(S)code$(S)program.data

basicrun: run	
	make -C ../runtime run

check: run
	cmp code.bin.org CODE.BIN

show:
	$(PYTHON) $(CSCRIPTS)pdis.py CODE.BIN

direct: tokenise
	$(CDEL) dump*.bin ; $(EMULATOR) -prg testing$(S)code$(S)tokenised.dat -run