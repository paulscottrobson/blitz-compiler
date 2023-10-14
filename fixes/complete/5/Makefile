# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Application makefile
#		Date :		9th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\..\documents\common.make
else
include ../../documents/common.make
endif

all: decode

BASICPRG = Z05_BUBBLE.PRG

libraries:
	make -B -C ..$(S).. libs release

decode:
	$(PYTHON) $(ROOTDIR)source$(S)tools$(S)detokenise$(S)detokenise.py $(BASICPRG)

load:
	$(CDEL) dump*.bin 
	$(EMULATOR) -prg $(BASICPRG)

emu:
	$(CDEL) dump*.bin 
	$(EMULATOR) -prg $(BASICPRG) -run

warp:	
	$(CDEL) dump*.bin 
	$(EMULATOR) -prg $(BASICPRG) -warp -run 

run:
	$(CDEL) dump*.bin
	$(CDEL) OBJECT.BASIC
	$(CCOPY) $(BASICPRG) SOURCE.PRG
	$(COMBASIC) 

basic:
	$(EMULATOR)

