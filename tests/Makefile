# ************************************************************************************************
# ************************************************************************************************
#
#		Name:		Makefile
#		Purpose:	Testing make file
#		Created:	5th April 2023
#		Author:		Paul Robson (paul@robsons.org.uk)
#
# ************************************************************************************************
# ************************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\documents\common.make
TIME=
else
include ../documents/common.make
TIME=time -f=%e 
endif

BINDIR = ..$(S)bin$(S)
SCRIPTDIR = ..$(S)source$(S)scripts$(S)
PROGDIR = ..$(S)source$(S)build$(S)
EMULATOR = $(BINDIR)x16emu$(APPSTEM) # -zeroram
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug 
HRUNEMU = $(RUNEMU) -testbench 
CAT = $(PYTHON) $(SCRIPTDIR)cat.py
TMPDIR = build$(S)

binary : 
	$(CDEL) dump*.bin
	python $@.py >$(TMPDIR)$@.bas
	python $(SCRIPTDIR)tokenise.py $(TMPDIR)$@.bas $(TMPDIR)$@.prg
	$(CAT) $(PROGDIR)blitz.prg $(TMPDIR)$@.prg $(TMPDIR)_compile.prg
	$(RUNEMU)  -prg $(TMPDIR)_compile.prg,801 -run 
	$(CCOPY) CODE.BIN $(TMPDIR)_pcode.bin 
	$(CDEL) CODE.BIN
	$(CAT) $(PROGDIR)runtime.prg $(TMPDIR)_pcode.bin $(TMPDIR)_runnable.prg
	$(RUNEMU) -prg $(TMPDIR)_runnable.prg,801 -run

