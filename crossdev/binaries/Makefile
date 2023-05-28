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
	$(CCOPY) ../../source/build/blitz.prg binaries
	$(CCOPY) ../../source/build/runtime.prg binaries
	$(CCOPY) ../../source/build/temp/runcompiler.prg binaries
	$(PYTHON) tobinary.py blitz.prg
	$(PYTHON) tobinary.py runtime.prg
	$(CCOPY) *.h ../include