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

BASICSRC = build$(S)balls.bas

libraries:
	make -C ..

prelim: 
	make -B -C ..$(S)common-source
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
	$(CCOPY) build$(S)code.prg BLITZ.PRG

release:  build
	$(CDEL) OBJECT.PRG
	$(CCOPY) *.PRG $(RELEASEDIR)
	$(CCOPY) build$(S)*.bas $(RELEASEDIR)
	$(CCOPY) $(BINDIR)tokenise.zip $(RELEASEDIR)
	$(CCOPY) $(ROOTDIR)CHANGES.txt $(RELEASEDIR)
	cd $(RELEASEDIR) ; $(CDEL) blitz.zip ; zip -q blitz.zip *
	
run: build	
	$(CDEL) OBJECT.PRG
	$(EXEBASIC)
	$(CCOPY) BLITZ.PRG $(BINDIR)	
	
x16:
	$(EMULATOR)

