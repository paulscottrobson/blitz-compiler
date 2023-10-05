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

BASICSRC = build$(S)balls.bas
all: build

prelim: common-code
	$(PYTHON) $(CSCRIPTS)genx16.py
	$(PYTHON) $(BINDIR)tokenise.zip $(BASICSRC) testing$(S)code$(S)tokenised.dat
	$(PYTHON) $(CSCRIPTS)errors.py
	$(PYTHON) $(CSCRIPTS)pcode.py >source$(S)generated$(S)pcodetokens.inc
	$(PYTHON) $(CSCRIPTS)c64tokens.py >source$(S)generated$(S)c64tokens.inc
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)compiler.library
	$(CCOPY)  scripts$(S)pcodeconstraw.py $(CSCRIPTS)

common-code:
	$(CCOPY) $(CSOURCE)forward.asm source$(S)common

build: prelim
	$(ASM) $(WRAPPER) testing$(S)testing.asm $(BINDIR)compiler.library $(BINDIR)ifloat32.library testing$(S)testend.asm

run: build
	$(CDEL) CODE.BIN
	$(EXECUTE) 
	$(CCOPY) CODE.BIN ..$(S)runtime$(S)testing$(S)code$(S)code.bin
	$(PYTHON) $(CSCRIPTS)compileinfo.py >testing$(S)code$(S)program.data
	
show:
	$(PYTHON) $(CSCRIPTS)pdis.py CODE.BIN


