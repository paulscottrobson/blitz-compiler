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
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug 
HRUNEMU = $(RUNEMU) -testbench -warp
EMU_REPO= ..$(S)..$(S)x16-emulator
ROM_REPO= ..$(S)..$(S)x16-rom
HARDWARE = x16
RTMODULES = ifloat32 polynomials runtime $(HARDWARE)_hardware $(HARDWARE)_runtime -o_runtime.asm -mruntime
all: runtime

#
#		Build the runtime
#
runtime:prelim
	python $(SCRIPTDIR)build.py $(RTMODULES) 
	$(ASM) $(ASMOPTS) _runtime.asm -o build$(S)runtime.prg
	$(CCOPY) build$(S)runtime.prg $(BINDIR)
	$(CDEL) dump*.bin
#
#		Build the compiled ocode
#
pcode: prelim 
	python $(SCRIPTDIR)pcom.py $(RTMODULES) >build$(S)temp$(S)pcodebin.asm
	$(ASM) $(ASMOPTS) build$(S)temp$(S)pcodebin.asm -o build$(S)temp$(S)pcodebin.bin
#
#		Run the compiled pcode
#
debugpcode: pcode runtime prelim
	cat build$(S)runtime.prg build$(S)temp$(S)pcodebin.bin >build$(S)temp$(S)pcodebin.prg
	$(HRUNEMU) -prg build$(S)temp$(S)pcodebin.prg,801 -run 

#
#		Test the floating point mathematics
#
testmaths : prelim
	python $(SCRIPTDIR)test_binary.py >build$(S)temp$(S)float.code
	python $(SCRIPTDIR)floatcom.py build$(S)temp$(S)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o build$(S)temp$(S)float.prg
	$(CCOPY) build$(S)temp$(S)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg build$(S)temp$(S)float.prg,801 -run -warp
	python $(SCRIPTDIR)stack.py
#
#		Test unary functions / polynomials and the power operator.
#
testfuncs : prelim
	python $(SCRIPTDIR)test_functions.py >build$(S)temp$(S)float.code
	python $(SCRIPTDIR)floatcom.py build$(S)temp$(S)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials machine_$(HARDWARE) -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o build$(S)temp$(S)float.prg
	$(CCOPY) build$(S)temp$(S)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg build$(S)temp$(S)float.prg,801 -run 
	python $(SCRIPTDIR)stack.py
#
#		Benchmark the floating point mathematics
#
benchmark : prelim
	python $(SCRIPTDIR)floatcom.py build$(S)benchmark.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o build$(S)temp$(S)float.prg
	$(CCOPY) build$(S)temp$(S)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	time -f=%e $(HRUNEMU) -prg build$(S)temp$(S)float.prg,801 -run
	python $(SCRIPTDIR)stack.py	
#
#		Do stuff before building.
#
prelim: 
	python $(SCRIPTDIR)constants.py
	python $(SCRIPTDIR)mathconstants.py
	python $(SCRIPTDIR)coremaths.py
	python $(SCRIPTDIR)errors.py
	python $(SCRIPTDIR)c64tokens.py >modules$(S)common$(S)generated$(S)c64tokens.inc
	python $(SCRIPTDIR)genmapping.py >modules$(S)runtime$(S)generated$(S)links.asm
	python $(SCRIPTDIR)pcode.py $(RTMODULES)  >modules$(S)common$(S)generated$(S)pcodetokens.inc
	python $(SCRIPTDIR)vectors.py $(RTMODULES) >modules$(S)runtime$(S)generated$(S)vectors.asm
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