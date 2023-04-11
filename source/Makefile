# ************************************************************************************************
# ************************************************************************************************
#
#		Name:		Makefile
#		Purpose:	Main make file
#		Created:	11th April 2023
#		Author:		Paul Robson (paul@robsons.org.uk)
#
# ************************************************************************************************
# ************************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\documents\common.make
else
include ../documents/common.make
endif

BINDIR = ..$(S)bin$(S)
SCRIPTDIR = scripts$(S)
ASMOPTS = -q -Wall -c -C  -L build$(S)code.lst -l build$(S)code.lbl -Wall 
EMULATOR = $(BINDIR)x16emu$(APPSTEM)
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug #-testbench
HRUNEMU = $(RUNEMU) -testbench -warp
EMU_REPO= ..$(S)..$(S)x16-emulator
ROM_REPO= ..$(S)..$(S)x16-rom
HARDWARE = x16

all: float

float : prelim
	python $(SCRIPTDIR)test_functions.py >build$(S)temp$(S)float.code
	python $(SCRIPTDIR)floatcom.py build$(S)temp$(S)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials machine_$(HARDWARE) -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o build$(S)float.prg
	$(CCOPY) build$(S)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(RUNEMU) -prg build$(S)float.prg,801 -run
	python $(SCRIPTDIR)stack.py

#
#		Do stuff before building.
#
prelim: 
	python $(SCRIPTDIR)constants.py
	python $(SCRIPTDIR)mathconstants.py
	python $(SCRIPTDIR)coremaths.py
#
#		Update tools
#	
tools: 
	cd $(EMU_REPO) ; git pull ; make
	cd $(ROM_REPO) ; git pull ; make
	$(CCOPY) $(EMU_REPO)$(S)x16emu$(APPSTEM) $(BINDIR)
	$(CCOPY) $(ROM_REPO)$(S)build$(S)x16$(S)rom.bin $(BINDIR)
#
#		Show stack
#
stack:
	python $(SCRIPTDIR)stack.py