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
include ..\..\documents\common.make
else
include ../../documents/common.make
endif

BINDIR = ..$(S)..$(S)bin$(S)

all: 
	$(PYTHON) tobinary.py $(BINDIR)blitz.prg blitz_code.h
	$(PYTHON) tobinary.py $(BINDIR)runtime.prg runtime_code.h
