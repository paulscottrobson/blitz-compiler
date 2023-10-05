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
	$(ASM) $(WRAPPER) testing$(S)testing.asm $(BINDIR)ifloat32.library

run: build
	$(EXECUTE)	
	
