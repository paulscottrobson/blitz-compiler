Also see TODO.txt as still very Alpha.

BLITZ.PRG is the compiler
SOURCE.PRG is the source code

If you prefer text files:
	test.bas is the same source code in text form
	tokenise.zip is a Python script that converts text to tokenised format.
	(python tokenise.zip test.bas SOURCE.PRG does the conversion)

Compiling
=========
(see demo.gif)
From the BASIC CLI in the emulator ; should work in the real thing too (not tried)

LOAD "BLITZ.PRG"
RUN
There will be a short delay. There will be a result program OBJECT.PRG which
can be run independently (e.g. it includes the Runtime)

This program is also present in memory space, so typing RUN again will run the
object file.

Paul Robson 
October 2023
