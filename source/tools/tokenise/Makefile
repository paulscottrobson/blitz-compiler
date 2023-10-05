# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Outer makefile
#		Date :		5th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\..\..\documents\common.make
else
include ../../../documents/common.make
endif

all:	
	$(CCOPY) tokenise.py __main__.py
	zip -j tokenise.zip __main__.py ..$(S)..$(S)common-scripts$(S)c64tokens.py
	$(CCOPY) tokenise.zip $(BINDIR)
	$(CDEL) __main__.py