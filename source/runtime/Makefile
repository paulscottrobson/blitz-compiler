# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	runtime library makefile.
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

prelim: common-code
	$(PYTHON) $(CSCRIPTS)errors.py
	$(PYTHON) $(CSCRIPTS)c64tokens.py >source$(S)generated$(S)c64tokens.inc
	$(PYTHON) scripts$(S)genmapping.py >source$(S)generated$(S)links.asm
	$(PYTHON) $(CSCRIPTS)pcode.py >source$(S)generated$(S)pcodetokens.inc
	$(PYTHON) scripts$(S)vectors.py >source$(S)generated$(S)vectors.asm

	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)runtime.library

common-code:
	$(CCOPY) $(CSOURCE)forward.asm source$(S)common

build: prelim
	$(ASM) $(WRAPPER) testing$(S)testing.asm $(BINDIR)runtime.library $(BINDIR)ifloat32.library  $(BINDIR)polynomials.library testing$(S)testend.asm

run: build
	$(EXECUTE) 
	