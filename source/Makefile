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
ASMOPTS =  $(ASMCTRLS) 
EMULATOR = $(BINDIR)x16emu$(APPSTEM) # -zeroram
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug 
HRUNEMU = $(RUNEMU) -testbench 
EMU_REPO= ..$(S)..$(S)x16-emulator
ROM_REPO= ..$(S)..$(S)x16-rom
HARDWARE = x16
BUILD = build$(S)
RELEASE = ..$(S)release
BTEMP = $(BUILD)temp$(S)
RTMODULES = ifloat32 polynomials runtime $(HARDWARE)_runtime -o_runtime.asm -mruntime
CMMODULES = compiler ifloat32 $(HARDWARE)_compiler -o_blitz.asm -mcompiler
CAT = $(PYTHON) $(SCRIPTDIR)cat.py

all: prelim compiler runtime 

#
#		Build the compiler
#		
compiler: prelim
	$(PYTHON) $(SCRIPTDIR)build.py $(CMMODULES) 
	$(ASM) $(ASMOPTS) _blitz.asm -o $(BUILD)blitz.prg -L $(BUILD)ccode.lst -l $(BUILD)ccode.lbl 
	$(CDEL) dump.bin
	$(CDEL) CODE.BIN
	$(CDEL) $(BTEMP)cout.bin
#
#		Convert basic code to tokenised form
#
basic:
	$(PYTHON) $(SCRIPTDIR)tokenise.py  $(BUILD)test.bas $(BTEMP)basic_code.bin
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
	$(PYTHON) $(SCRIPTDIR)pdis.py $(BTEMP)cout.bin	
#
#		Run/Debug the compiler ; append tokenised BASIC to runtime and start it.
#
cdebug : compiler basic
	$(RUNEMU) -prg $(BTEMP)runcompiler.prg,801 -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
	$(PYTHON) $(SCRIPTDIR)compileinfo.py >$(BTEMP)program.data
#
crun : compiler basic
	$(HRUNEMU) -prg $(BTEMP)runcompiler.prg,801 -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
	$(PYTHON) $(SCRIPTDIR)compileinfo.py >$(BTEMP)program.data
#
#		Compile and Run (and optionally record)
#
rdebug: cdebug runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 

rrun: crun runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(TIME) $(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 

grun: crun runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(TIME) $(RUNEMU) -gif $(BTEMP)blitz.gif -prg $(BTEMP)pcodebin.prg,801 -run 
#
#		Build the runtime
#
runtime:prelim
	$(PYTHON) $(SCRIPTDIR)build.py $(RTMODULES) 
	$(CDEL) WTEST*
	$(ASM) $(ASMOPTS) _runtime.asm -o $(BUILD)runtime.prg
	$(ASM) $(ASMOPTS) _blitz.asm -o $(BUILD)blitz.prg -L $(BUILD)rcode.lst -l $(BUILD)rcode.lbl 
	$(CCOPY) $(BUILD)runtime.prg $(BINDIR)
	$(CDEL) dump*.bin
#
#		Build the compiled ocode
#
pcode: prelim 
	$(PYTHON) $(SCRIPTDIR)pcom.py <$(BTEMP)demo.pcode >$(BTEMP)pcodebin.asm
	$(ASM) $(ASMCTRLS) $(BTEMP)pcodebin.asm -o $(BTEMP)pcodebin.bin
#
#		Run the compiled pcode
#
debugpcode: runtime prelim pcode
	$(CAT) $(BUILD)runtime.prg $(BTEMP)pcodebin.bin $(BTEMP)pcodebin.prg
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run 
#
#		Build / Copy relevant files to Release
#	
release: runtime compiler
	$(CCOPY) $(BUILD)runtime.prg $(RELEASE)
	$(CCOPY) $(BUILD)blitz.prg $(RELEASE) 
	$(CCOPY) $(BINDIR)x16emu $(RELEASE)
	$(CCOPY) $(BINDIR)rom.bin $(RELEASE)
	$(CCOPY) $(SCRIPTDIR)tokenise.py $(RELEASE)
	$(CCOPY) $(SCRIPTDIR)c64tokens.py $(RELEASE)
	$(CCOPY) $(SCRIPTDIR)cat.py $(RELEASE)
	$(CCOPY) ..$(S)TODO $(RELEASE)
	$(CDEL) $(RELEASE)release.zip
	cd $(RELEASE) ; zip -r release.zip *
#
#		A test_pcode.py run
#	
tpcode: prelim
	$(PYTHON) $(SCRIPTDIR)test_pcode.py >$(BTEMP)test.pcode
	$(PYTHON) $(SCRIPTDIR)pcom.py <$(BTEMP)test.pcode >$(BTEMP)pcodebin.asm
	$(ASM) $(ASMOPTS) $(BTEMP)pcodebin.asm -o $(BTEMP)pcodebin.bin

testpcode: runtime prelim tpcode 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)pcodebin.bin $(BTEMP)pcodebin.prg
	$(HRUNEMU) -prg $(BTEMP)pcodebin.prg,801 -run -warp
#
#		Test the floating point mathematics
#
testmaths : prelim
	#$(PYTHON) $(SCRIPTDIR)test_binary.py >$(BTEMP)float.code
	$(PYTHON) $(SCRIPTDIR)floatcom.py $(BTEMP)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	$(PYTHON) $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg $(BTEMP)float.prg,801 -run -warp
	$(PYTHON) $(SCRIPTDIR)stack.py
#
#		Test unary functions / polynomials and the power operator.
#
testfuncs : prelim
	$(PYTHON) $(SCRIPTDIR)test_functions.py >$(BTEMP)float.code
	$(PYTHON) $(SCRIPTDIR)floatcom.py $(BTEMP)float.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	$(PYTHON) $(SCRIPTDIR)build.py ifloat32 polynomials machine_$(HARDWARE) -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg $(BTEMP)float.prg,801 -run -warp
	$(PYTHON) $(SCRIPTDIR)stack.py
#
#		Benchmark the floating point mathematics
#
benchmark : prelim
	$(PYTHON) $(SCRIPTDIR)floatcom.py $(BUILD)benchmark.code >modules$(S)ifloat32$(S)generated$(S)testcode.dat
	$(PYTHON) $(SCRIPTDIR)build.py ifloat32 polynomials $(HARDWARE)_hardware -o_float.asm -mifloat32
	$(ASM) $(ASMOPTS) _float.asm -o $(BTEMP)float.prg
	$(CCOPY) $(BTEMP)float.prg $(BINDIR)
	$(CDEL) dump*.bin
	$(HRUNEMU) -prg $(BTEMP)float.prg,801 -run
	$(PYTHON) $(SCRIPTDIR)stack.py	
#
#		Do stuff before building.
#
prelim: 
	$(CDEL) _*.asm
	$(PYTHON) $(SCRIPTDIR)genx16.py
	$(PYTHON) $(SCRIPTDIR)constants.py
	$(PYTHON) $(SCRIPTDIR)mathconstants.py
	$(PYTHON) $(SCRIPTDIR)coremaths.py
	$(PYTHON) $(SCRIPTDIR)errors.py
	$(PYTHON) $(SCRIPTDIR)c64tokens.py >modules$(S)common$(S)generated$(S)c64tokens.inc
	$(PYTHON) $(SCRIPTDIR)genmapping.py >modules$(S)runtime$(S)generated$(S)links.asm
	$(PYTHON) $(SCRIPTDIR)pcode.py $(RTMODULES)  >modules$(S)common$(S)generated$(S)pcodetokens.inc
	$(PYTHON) $(SCRIPTDIR)vectors.py $(RTMODULES) >modules$(S)runtime$(S)generated$(S)vectors.asm
	$(PYTHON) $(SCRIPTDIR)gencom.py $(CMMODULES) 
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
	$(PYTHON) $(SCRIPTDIR)stack.py
#
#		Show variables (A-Z only)
#
variables:
	$(PYTHON) $(SCRIPTDIR)variables.py