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
	$(PYTHON) detokenise.py >x16font.bas
	$(CCOPY) x16font.bas ../../compiler/build
	$(CCOPY) X16FONT.PRG ../../compiler/build/x16font.prg