# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		Makefile
#		Purpose :	Outer makefile
#		Date :		5th October 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

ifeq ($(OS),Windows_NT)
include documents\common.make
else
include documents/common.make
endif

all: tools
	
#
#		Get the most recent version of the emulator & docs. Requires the three
#		repositories to be in the same directory as the blitz repository
#	
tools:
	cd ..$(S)x16-docs ; git pull	
	cd ..$(S)x16-rom ; git pull ; # make doesn't currently build.
	cd ..$(S)x16-emulator ; git pull ; make 
	$(CCOPY) ..$(S)x16-rom$(S)build$(S)x16$(S)rom.bin $(BINDIR)
	$(CCOPY) ..$(S)x16-emulator$(S)x16emu$(APPSTEM) $(BINDIR)