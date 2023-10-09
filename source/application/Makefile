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

all: build	

BASICSRC = build$(S)test.bas

libraries:
	make -C ..

prelim: 
	$(PYTHON) $(CSCRIPTS)build.py
	$(PYTHON) $(BINDIR)tokenise.zip $(BASICSRC) SOURCE.PRG

#
#		This order matters. 00main.header contains the BASIC header followed by the runtime components
# 		(runtime.library ... polynomials.library).
#
#		At the end, eventually, the finished compiled code will be copied over the compiler and library
#		code for this application to make more space available.
#
build: prelim
	$(ASM) 	source$(S)main$(S)00main.header \
			$(BINDIR)runtime.library $(BINDIR)common.library $(BINDIR)ifloat32.library $(BINDIR)polynomials.library \
			$(BINDIR)compiler.library \
			_library.asm \
			source$(S)main$(S)zzfree.footer

release: build
	$(CDEL) OBJECT.PRG
	$(CCOPY) *.PRG $(RELEASEDIR)
	$(CCOPY) build$(S)test.bas $(RELEASEDIR)
	$(CCOPY) $(BINDIR)tokenise.zip $(RELEASEDIR)

run: build	
	$(CDEL) OBJECT.PRG
	$(EXEBASIC)
	$(CCOPY) build$(S)code.prg BLITZ.PRG
	$(CCOPY) BLITZ.PRG $(BINDIR)	
	
x16:
	$(EMULATOR)

