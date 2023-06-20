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


all: 
	$(CCOPY) ..$(S)..$(S)source$(S)build$(S)blitz.prg .
	$(CCOPY) ..$(S)..$(S)source$(S)build$(S)runtime.prg .
	$(CCOPY) ..$(S)..$(S)source$(S)build$(S)temp$(S)runcompiler.prg .
	$(PYTHON) tobinary.py blitz.prg
	$(PYTHON) tobinary.py runtime.prg
	$(CCOPY) *.h ..$(S)include