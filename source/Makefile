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

all: runtime

runtime :
	python $(SCRIPTDIR)constants.py
	python $(SCRIPTDIR)build.py runtime ifloat32 machine_$(HARDWARE) -o_runtime.asm -mruntime
	$(ASM) $(ASMOPTS) _runtime.asm -o build$(S)runtime.prg
	$(CCOPY) build$(S)runtime.prg $(BINDIR)
	$(CDEL) dump*.bin
#	$(HRUNEMU) -prg build$(S)runtime.prg,801 -run
#	python $(SCRIPTDIR)runtime.py
	
#
#		Update tools
#	
tools: 
	cd $(EMU_REPO) ; git pull ; make
	cd $(ROM_REPO) ; git pull ; make
	$(CCOPY) $(EMU_REPO)$(S)x16emu$(APPSTEM) $(BINDIR)
	$(CCOPY) $(ROM_REPO)$(S)build$(S)x16$(S)rom.bin $(BINDIR)
