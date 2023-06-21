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

RTMODULES = ifloat32 polynomials runtime $(HARDWARE)_runtime -o_runtime.asm -mruntime
CMMODULES = compiler ifloat32 $(HARDWARE)_compiler -o_blitz.asm -mcompiler
REVISION = r43
HARDWARE = x16

BINDIR = ..$(S)bin$(S)
SCRIPTDIR = scripts$(S)
ASMCTRLS = -q -Wall -c -C 
ASMOPTS =  $(ASMCTRLS) 
EMULATOR = $(BINDIR)x16emu$(APPSTEM) # -zeroram
RUNEMU = $(EMULATOR) -rom $(BINDIR)rom.bin -keymap en-gb -dump R -scale 2 -rtc -debug 
HRUNEMU = $(RUNEMU) -testbench 
BUILD = build$(S)
BTEMP = $(BUILD)temp$(S)
CAT = $(PYTHON) $(SCRIPTDIR)cat.py

all: tokapp prelim compiler runtime 

#
#		Build the compiler
#		
compiler: tracker prelim
	$(PYTHON) $(SCRIPTDIR)build.py $(CMMODULES) 
	$(ASM) $(ASMOPTS) _blitz.asm -o $(BUILD)blitz.prg -L $(BUILD)ccode.lst -l $(BUILD)code.lbl 
	$(CCOPY) $(BUILD)blitz.prg $(BINDIR)
	$(CDEL) dump.bin
	$(CDEL) CODE.BIN
	$(CDEL) $(BTEMP)cout.bin
#
#		Build the runtime
#
runtime:tracker prelim
	$(PYTHON) $(SCRIPTDIR)build.py $(RTMODULES) 
	$(CDEL) WTEST*
	$(ASM) $(ASMOPTS) _runtime.asm -o $(BUILD)runtime.prg -L $(BUILD)rcode.lst -l $(BUILD)code.lbl 
	$(CCOPY) $(BUILD)runtime.prg $(BINDIR)
	$(CDEL) dump*.bin 
#
#		Track builds
#
tracker:
	$(PYTHON) $(SCRIPTDIR)tracker.py >modules$(S)common$(S)generated$(S)buildinfo.dat
#
#		Build Tokenise app
#
tokapp:
	$(CCOPY) scripts$(S)tokenise.py __main__.py
	zip -j tokenise.zip __main__.py scripts$(S)c64tokens.py
	$(CCOPY) tokenise.zip $(BINDIR)
	$(CDEL) __main__.py
#
#		Convert basic code to tokenised form
#
basic:tokapp
	$(PYTHON) $(BINDIR)tokenise.zip  $(BUILD)test.bas $(BTEMP)basic_code.bin
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
	$(RUNEMU) -prg $(BTEMP)runcompiler.prg$(RUNADDR) -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
	$(PYTHON) $(SCRIPTDIR)compileinfo.py >$(BTEMP)program.data
#
crun : compiler basic
	$(HRUNEMU) -prg $(BTEMP)runcompiler.prg$(RUNADDR) -run 
	$(CCOPY) CODE.BIN $(BTEMP)cout.bin
	$(CDEL) CODE.BIN
	$(PYTHON) $(SCRIPTDIR)compileinfo.py >$(BTEMP)program.data
#
#		Compile and Run (and optionally record)
#
rdebug: cdebug runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg$(RUNADDR) -run 

rrun: crun runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(TIME) $(RUNEMU) -prg $(BTEMP)pcodebin.prg$(RUNADDR) -run 

grun: crun runtime 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)cout.bin $(BTEMP)pcodebin.prg
	$(CDEL) dump*.bin
	$(TIME) $(RUNEMU) -gif $(BTEMP)blitz.gif -prg $(BTEMP)pcodebin.prg$(RUNADDR) -run 
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
	$(RUNEMU) -prg $(BTEMP)pcodebin.prg$(RUNADDR) -run 
#
#		A test_pcode.py run
#	
tpcode: prelim
	$(PYTHON) $(SCRIPTDIR)test_pcode.py >$(BTEMP)test.pcode
	$(PYTHON) $(SCRIPTDIR)pcom.py <$(BTEMP)test.pcode >$(BTEMP)pcodebin.asm
	$(ASM) $(ASMOPTS) $(BTEMP)pcodebin.asm -o $(BTEMP)pcodebin.bin

testpcode: runtime prelim tpcode 
	$(CAT) $(BUILD)runtime.prg $(BTEMP)pcodebin.bin $(BTEMP)pcodebin.prg
	$(HRUNEMU) -prg $(BTEMP)pcodebin.prg$(RUNADDR) -run -warp
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
	$(HRUNEMU) -prg $(BTEMP)float.prg$(RUNADDR) -run -warp
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
	$(HRUNEMU) -prg $(BTEMP)float.prg$(RUNADDR) -run -warp
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
	$(HRUNEMU) -prg $(BTEMP)float.prg$(RUNADDR) -run
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
#		Update X16 emulator latest revision
#
tools:
	wget -q -c https://github.com/X16Community/x16-emulator/releases/download/$(REVISION)/x16emu_linux-x86_64-$(REVISION).zip -P $(BTEMP)
	wget -q -c https://github.com/X16Community/x16-emulator/releases/download/$(REVISION)/x16emu_win64-$(REVISION).zip -P $(BTEMP)
	cd $(BTEMP) ; unzip -q -o x16emu_linux-x86_64-$(REVISION).zip
	cd $(BTEMP) ; unzip -q -o x16emu_win64-$(REVISION).zip
	$(CDEL) $(BTEMP)*.sym
	$(CDEL) $(BTEMP)*.pdf
	$(CDEL) $(BTEMP)*.zip
	$(CCOPY) $(BTEMP)x16emu $(BINDIR)
	$(CCOPY) $(BTEMP)x16emu.exe $(BINDIR)
	$(CCOPY) $(BTEMP)rom.bin $(BINDIR)	
	$(CCOPY) $(BTEMP)*.dll $(BINDIR)	
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

	