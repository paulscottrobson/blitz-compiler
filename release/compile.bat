@echo off
rem 	*********************************************************
rem
rem 				Compiles test.bas to temp\pcode.bin
rem
rem 	*********************************************************
rem
rem		Convert the test.bas source file to a tokenised format
rem
python tokenise.zip test.bas temp\test.prg
rem
rem		Concatenate to the compiler
rem
python cat.py blitz.prg temp\test.prg temp\compile.prg
rem
rem		Delete the old object file, code.bin and the dump file from the emulator
rem
del /q CODE.BIN dump*.bin
rem
rem		Now run that script, it will compile it and output the result, exiting
rem		via the $FFFF vector and dumping the RAM (useful for debugging)
rem
x16emu.exe -dump R -scale 2 -rtc -debug  -prg temp\compile.prg,801 -run 
rem
rem		Move it to the temp directory
rem
move	 CODE.BIN temp\pcode.bin

