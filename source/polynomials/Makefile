# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	ifloat32 library makefile.
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
	$(PYTHON) scripts$(S)mathconstants.py
	$(PYTHON) scripts$(S)coremaths.py
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)polynomials.library

build: prelim
	$(ASM) $(WRAPPER) testing$(S)testing.asm $(BINDIR)ifloat32.library $(BINDIR)polynomials.library

run: build
	$(EXECUTE) $(FAST)
	
test : prepoly prelim build run

prepoly:
	$(PYTHON) scripts$(S)test_functions.py >build$(S)float.code
	$(PYTHON) $(CSCRIPTS)floatcom.py build$(S)float.code >testing$(S)generated$(S)testcode.dat
