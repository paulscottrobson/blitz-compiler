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
	make $(MAKEOPTS) -B -C  tools
	make $(MAKEOPTS) -B -C  common-source
	make $(MAKEOPTS) -B -C  ifloat32
	make $(MAKEOPTS) -B -C  polynomials
	make $(MAKEOPTS) -B -C  runtime
	make $(MAKEOPTS) -B -C  compiler

release:
	make $(MAKEOPTS) -B -C  application release
