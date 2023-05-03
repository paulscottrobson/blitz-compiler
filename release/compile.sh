#!/bin/bash
# 	*********************************************************
#
# 				Compiles test.bas to temp/pcode.bin
#
# 	*********************************************************
#
#		Convert the test.bas source file to a tokenised format
#
python3 tokenise.py test.bas temp/test.prg
#
#		Concatenate to the compiler
#
python3 cat.py blitz.prg temp/test.prg temp/compile.prg
#
#		Delete the old object file, code.bin and the dump file from the emulator
#
rm -f CODE.BIN dump*.bin
#
#		Now run that script, it will compile it and output the result, exiting
#		via the $FFFF vector and dumping the RAM (useful for debugging)
#
./x16emu -dump R -scale 2 -rtc -debug  -prg temp/compile.prg,801 -run 
#
#		Move it to the temp directory
#
mv CODE.BIN temp/pcode.bin

