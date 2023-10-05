# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	runtime library makefile.
#		Date :		5th October 2023
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

prelim: common-code
#	$(PYTHON) scripts$(S)constants.py
	$(PYTHON) $(CSCRIPTS)build.py
	$(CCOPY) _library.asm $(BINDIR)runtime.library

common-code:
	$(CCOPY) $(CSOURCE)forward.asm source$(S)common

build: prelim
	$(ASM) $(WRAPPER) testing$(S)testing.asm $(BINDIR)runtime.library $(BINDIR)ifloat32.library $(BINDIR)polynomials.library testing$(S)testend.asm

run: build
	$(EXECUTE) $(FAST)
	
test : prebinary prelim build run

prebinary:
	$(PYTHON) scripts$(S)test_binary.py >build$(S)float.code
	$(PYTHON) $(CSCRIPTS)floatcom.py build$(S)float.code >testing$(S)generated$(S)testcode.dat
