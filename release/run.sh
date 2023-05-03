#!/bin/bash
# 	*********************************************************
#
# 						Run temp/pcode.bin
#
# 	*********************************************************
#
#		Concatenate the p-code to the runtime
#
python3 cat.py runtime.prg temp/pcode.bin temp/runnable.prg
#
#		Delete the dump file from the emulator
#
rm dump*.bin
#
#		Now run the runtime. If you don't put STOP in END will exit
#		immediately via $FFFF
#
./x16emu -dump R -scale 2 -rtc -debug  -prg temp/runnable.prg,801 -run 

