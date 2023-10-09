# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Outer makefile
#		Date :		0th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

#
#		Bl**dy Windows.
#
ifeq ($(OS),Windows_NT)
include ..\documents\common.make
else
include ../documents/common.make
endif


all: libraries release

libraries:	
	make $(MAKEOPTS) -C tools
	make $(MAKEOPTS) -C common-source
	make $(MAKEOPTS) -C ifloat32
	make $(MAKEOPTS) -C polynomials
	make $(MAKEOPTS) -C runtime
	make $(MAKEOPTS) -C compiler
	make $(MAKEOPTS) -C application

release:
	make $(MAKEOPTS) -C application release
