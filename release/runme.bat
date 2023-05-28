rem
rem			Convert the "balls.bas" text file into a tokenised format (standard X16 format) "source.prg"
rem
python tokenise.zip balls.bas source.prg
rem
rem			Compile source.prg to target.prg
rem
blitz
rem
rem			Run it with the emulator
rem
x16emu -scale 2 -prg target.prg,801 -run
