@echo off
rem 	*********************************************************
rem
rem 						Run temp\pcode.bin
rem
rem 	*********************************************************
rem
rem		Concatenate the p-code to the runtime
rem
python cat.py runtime.prg temp\pcode.bin temp\runnable.prg
rem
rem		Delete the dump file from the emulator
rem
del /q dump*.bin
rem
rem		Now run the runtime. If you don't put STOP in END will exit
rem		immediately via $FFFF
rem
x16emu.exe -dump R -scale 2 -rtc -debug  -prg temp\runnable.prg,801 -run 

