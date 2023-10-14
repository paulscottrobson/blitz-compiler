# ************************************************************************************************
# ************************************************************************************************
#
#		Name:		Makefile
#		Purpose:	Testing make file
#		Created:	13th October 2023
#		Author:		Paul Robson (paul@robsons.org.uk)
#
# ************************************************************************************************
# ************************************************************************************************

ifeq ($(OS),Windows_NT)
include ..\..\..\documents\common.make
else
include ../../../documents/common.make
endif

all: binary compare unary variables parenthesis arrays

prelim:

binary : prelim
	$(call run_test,$@)

compare: prelim
	$(call run_test,$@)

unary: prelim
	$(call run_test,$@)

parenthesis: prelim
	$(call run_test,$@)

variables: prelim
	$(call run_test,$@)

arrays: prelim
	$(call run_test,$@)

define run_test
	$(CDEL) dump*.bin
	$(CDEL) CODE.BIN
	$(PYTHON) $1.py >build$(S)test.bas
	$(CCOPY) build$(S)test.bas examples$(S)$1.bas
	$(PYTHON) $(BINDIR)tokenise.zip build$(S)test.bas build$(S)test.prg
	$(ASM) testing$(S)testing.asm $(BINDIR)compiler.library $(BINDIR)common.library $(BINDIR)ifloat32.library testing$(S)testend.asm
	$(EXECUTE)
	$(CCOPY) CODE.BIN ..$(S)..$(S)runtime$(S)testing$(S)code$(S)code.bin
	make -C ../../runtime run
endef
