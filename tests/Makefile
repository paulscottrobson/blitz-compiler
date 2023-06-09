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
EMULATOR = $(BINDIR)x16emu$(APPSTEM) # -zeroram
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug -testbench -warp
CAT = $(PYTHON) $(SCRIPTDIR)cat.py
TMPDIR = build$(S)

all: binary compare unary variables parenthesis arrays

system:
	make -C ../source

binary : system
	$(call run_test,$@)

compare: system
	$(call run_test,$@)

unary: system
	$(call run_test,$@)

parenthesis: system
	$(call run_test,$@)

variables: system
	$(call run_test,$@)

arrays: system
	$(call run_test,$@)

define run_test
	$(CDEL) dump*.bin
	$(PYTHON) $1.py >$(TMPDIR)$1.bas
	$(PYTHON) $(BINDIR)tokenise.zip $(TMPDIR)$1.bas $(TMPDIR)$1.prg
	$(CAT) $(BINDIR)blitz.prg $(TMPDIR)$1.prg $(TMPDIR)_compile.prg
	$(RUNEMU)  -prg $(TMPDIR)_compile.prg -run 
	$(CCOPY) CODE.BIN $(TMPDIR)_pcode.bin 
	$(CDEL) CODE.BIN
	$(CAT) $(BINDIR)runtime.prg $(TMPDIR)_pcode.bin $(TMPDIR)_runnable.prg
	$(RUNEMU) -prg $(TMPDIR)_runnable.prg -run
	$(CDEL) dump*.bin
endef
