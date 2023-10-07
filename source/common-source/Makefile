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
	$(PYTHON) $(CSCRIPTS)pcode.py >source$(S)generated$(S)pcodetokens.inc
	$(PYTHON) $(CSCRIPTS)c64tokens.py >source$(S)generated$(S)c64tokens.inc
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)common.library

build: prelim
