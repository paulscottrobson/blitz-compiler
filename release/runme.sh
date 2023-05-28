#
#			Convert the "balls.bas" text file into a tokenised format (standard X16 format) "source.prg"
#
python tokenise.zip balls.bas source.prg
#
#			Compile source.prg to target.prg
#
./blitz 
#
#			Run it with the emulator
#
./x16emu -scale 2 -prg target.prg,801 -run
