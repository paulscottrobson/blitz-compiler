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

#
#		Bl**dy Windows.
#
ifeq ($(OS),Windows_NT)
include documents\common.make
else
include documents/common.make
endif

#
#		The revision of the current release
#
REVISION = r43

all: libs

#
#		Build the library version of the components. 
#
libs:	
	make $(MAKEOPTS) -C source
#
#		Get the most recent version of the emulator & docs. Requires the three
#		repositories to be in the same directory as the blitz repository
#	
gitrev:
	cd ..$(S)x16-docs ; git pull	
	cd ..$(S)x16-rom ; git pull ; # make doesn't currently build.
	cd ..$(S)x16-emulator ; git pull ; make 
	$(CCOPY) ..$(S)x16-rom$(S)build$(S)x16$(S)rom.bin $(BINDIR)
	$(CCOPY) ..$(S)x16-rom$(S)basic$(S)token2.s $(ROOTDIR)documents
	$(CCOPY) ..$(S)x16-emulator$(S)x16emu$(APPSTEM) $(BINDIR)
#
#		Get latest release.
#	
BTEMP = $(BINDIR)temp$(S)

latest:
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
#		Build release
#
release:
	make -B -C source/application/ release
