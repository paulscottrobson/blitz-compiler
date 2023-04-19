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
TIME=
else
include ../documents/common.make
TIME=time -f=%e 
endif

BINDIR = ..$(S)bin$(S)
SCRIPTDIR = scripts$(S)
ASMCTRLS = -q -Wall -c -C 
ASMOPTS =  $(ASMCTRLS) -L $(BUILD)code.lst -l $(BUILD)code.lbl 
EMULATOR = $(BINDIR)x16emu$(APPSTEM)
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug 
HRUNEMU = $(RUNEMU) -testbench 
EMU_REPO= ..$(S)..$(S)x16-emulator
ROM_REPO= ..$(S)..$(S)x16-rom
HARDWARE = x16
BUILD = build$(S)
BTEMP = $(BUILD)temp$(S)
RTMODULES = ifloat32 polynomials runtime $(HARDWARE)_hardware $(HARDWARE)_runtime -o_runtime.asm -mruntime
CMMODULES = compiler ifloat32 $(HARDWARE)_hardware $(HARDWARE)_compiler -o_blitz.asm -mcompiler
CAT = python $(SCRIPTDIR)cat.py

all: prelim compiler runtime

#
#		Build the compiler
#		
compiler: prelim
	python $(SCRIPTDIR)build.py $(CMMODULES) 
	$(ASM) $(ASMOPTS) _blitz.asm -o $(BUILD)blitz.prg
	$(CDEL) dump.bin
	$(CDEL) CODE.BIN
	$(CDEL) $(BTEMP)cout.bin
#
#		Convert basic code to tokenised form
#
basic:
	petcat -w2 -o $(BTEMP)basic_code.bin -- $(BUILD)test.bas
	$(CAT) $(BUILD)blitz.prg $(BTEMP)basic_code.bin $(BTEMP)runcompiler.prg
#
#		Hex dump of BASIC code tokenised
#
showbasic: basic	
	hexdump -C $(BTEMP)basic_code.bin
#
#		Decode compiler output (in cout.bin)
#
decode: basic
	python $(SCRIPTDIR)pdis.py $(BTEMP)cout.bin	
#
#		Run/Debug the compiler ; append tokenised BASIC to runtime and start it.
#
cdebug : compiler basic
	$(RUNEMU) -prg $(BTEMP)runcompiler.prg,801 -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
#
crun : compiler basic
	$(HRUNEMU) -prg $(BTEMP)runcompiler.prg,801 -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
#
#		Compile and Run
#
rdebug: runtime cdebug
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 

rrun: runtime crun
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 
#
#		Build the runtime
#
runtime:prelim
	python $(SCRIPTDIR)build.py $(RTMODULES) 
	$(ASM) $(ASMOPTS) _runtime.asm -o $(BUILD)runtime.prg
	$(CCOPY) $(BUILD)runtime.prg $(BINDIR)
	$(CDEL) dump*.bin
#
#		Build the compiled ocode
#
pcode: prelim 
	python $(SCRIPTDIR)pcom.py <$(BTEMP)demo.pcode >$(BTEMP)pcodebin.asm
	$(ASM) $(ASMCTRLS) $(BTEMP)pcodebin.asm -o $(BTEMP)pcodebin.bin
#
#		Run the compiled pcode
#
debugpcode: runtime prelim pcode
	$(CAT) $(BUILD)runtime.prg $(BTEMP)pcodebin.bin $(BTEMP)pcodebin.prg
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 
#
#		A test_pcode.py run
#	
tpcode: prelim
	python $(SCRIPTDIR)test_pcode.py >$(BTEMP)test.pcode
	python $(SCRIPTDIR)pcom.py <$(BTEMP)test.pcode >$(BTEMP)pcodebin.asm
	$(ASM) $(ASMOPTS) $(BTEMP)pcodebin.asm -o $(BTEMP)pcodebin.bin

testpcode: runtime prelim tpcode 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)pcodebin.bin $(BTEMP)pcodebin.prg
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run -warp
#
#		Test the floating point mathematics
#
testmaths : prelim
	#python $(SCRIPTDIR)test_binary.py >$(BTEMP)float.code
	python $(SCRIPTDIR)floatcom.py $(BTEMP)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg $(BTEMP)float.prg,801 -run -warp
	python $(SCRIPTDIR)stack.py
#
#		Test unary functions / polynomials and the power operator.
#
testfuncs : prelim
	python $(SCRIPTDIR)test_functions.py >$(BTEMP)float.code
	python $(SCRIPTDIR)floatcom.py $(BTEMP)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials machine_$(HARDWARE) -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg $(BTEMP)float.prg,801 -run -warp
	python $(SCRIPTDIR)stack.py
#
#		Benchmark the floating point mathematics
#
benchmark : prelim
	python $(SCRIPTDIR)floatcom.py $(BUILD)benchmark.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	python $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(TIME) -f=%e $(HRUNEMU) -prg $(BTEMP)float.prg,801 -run
	python $(SCRIPTDIR)stack.py	
#
#		Do stuff before building.
#
prelim: 
	$(CDEL) _*.asm
	python $(SCRIPTDIR)constants.py
	python $(SCRIPTDIR)mathconstants.py
	python $(SCRIPTDIR)coremaths.py
	python $(SCRIPTDIR)errors.py
	python $(SCRIPTDIR)c64tokens.py >modules$(S)common$(S)generated$(S)c64tokens.inc
	python $(SCRIPTDIR)genmapping.py >modules$(S)runtime$(S)generated$(S)links.asm
	python $(SCRIPTDIR)pcode.py $(RTMODULES)  >modules$(S)common$(S)generated$(S)pcodetokens.inc
	python $(SCRIPTDIR)vectors.py $(RTMODULES) >modules$(S)runtime$(S)generated$(S)vectors.asm
	python $(SCRIPTDIR)gencom.py $(CMMODULES) 
#
#		Update tools
#	
tools: 
	cd $(EMU_REPO) ; git pull ; make
	cd $(ROM_REPO) ; git pull ; make
	$(CCOPY) $(EMU_REPO)$(S)x16emu$(APPSTEM) $(BINDIR)
	$(CCOPY) $(ROM_REPO)$(S)$(BUILD)x16$(S)rom.bin $(BINDIR)
#
#		Show stack
#
stack:
	python $(SCRIPTDIR)stack.py
#
#		Show variables (A-Z only)
#
variables:
	python $(SCRIPTDIR)variables.py