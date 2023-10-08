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

prelim: 
	$(PYTHON) scripts$(S)genmapping.py >source$(S)generated$(S)links.asm
	$(PYTHON) scripts$(S)vectors.py >source$(S)generated$(S)vectors.asm

	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)runtime.library

build: prelim
	$(ASM) testing$(S)testing.asm $(BINDIR)runtime.library $(BINDIR)common.library $(BINDIR)ifloat32.library  $(BINDIR)polynomials.library testing$(S)testend.asm

checkall: prelim
	$(ASM) testing$(S)testing.asm $(BINDIR)common.library $(BINDIR)ifloat32.library $(BINDIR)polynomials.library \
													$(BINDIR)compiler.library $(BINDIR)runtime.library testing$(S)testend.asm

run: build
	$(EXECUTE) 
	
variables:
	$(PYTHON) $(CSCRIPTS)variables.py
