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
	$(PYTHON) scripts$(S)constants.py
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)ifloat32.library

build: prelim
	$(ASM) testing$(S)testing.asm $(BINDIR)common.library $(BINDIR)ifloat32.library

run: build
	$(EXECUTE) $(FAST)
	
test : prebinary prelim build run

prebinary:
	$(PYTHON) scripts$(S)test_binary.py >build$(S)float.code
	$(PYTHON) $(CSCRIPTS)floatcom.py build$(S)float.code >testing$(S)generated$(S)testcode.dat
