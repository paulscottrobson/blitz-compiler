
											Welcome to Blitz X16 early Alpha release
											========================================

------------
Introduction
------------

This is very similar to Blitz on the C64 ; it converts tokenised BASIC to a pseudo code which 
is subsequently interpreted. Hopefully it will eventually compile almost all BASIC programs.

Python3 is a prerequisite. I think everything else is in the release directory.

---------------------------------------------------------------------------------------------------------

--------------
Making it work
--------------

The compilation process is currently very "old school". It is not integrated into the system at all. 

It is run either from a Windows command prompt, or from a Linux Shell.

The source file is "test.bas". This is a (slightly) modified version of David Murray's "Balls" demo.

I would check it is working by varying the first line which sets the number of displayed balls. This 
demo definitely works on Windows/Linux.

-----------
First Check
-----------
Check the include x16 emulator works (either ./x16emu or x16emu.exe) ; it should start as normal.

-------
Compiling
-------
To compile it, run either compile.sh (Linux) or compile.bat (Windows). I do not own a Mac so cannot 
test it but it probably will work (!)

The X16 emulator should appear and quickly disappear.

This creates an program file temp/pcode.bin which is the pseudo-code for the program.

-------
Running
-------
To run it, run either run.sh (Linux) or run.bat (Windows). This creates the final executable and runs
it.

---------------------------------------------------------------------------------------------------------

Notes
-----
It won't compile very large programs, yet (about 8k). This is not a limitation of the compiler, 
merely this version. It's easier to debug code if it's not stored in banked RAM.

It is probably quite buggy. Included is a copy of David "8 bit Guy" Murray's balls demo, which gives an 
idea of the speed increase. To give an idea, when I first ran this it yielded two issues ; IF had
got broken at some point, and I'd forgotten you could do NEXT Y,X.  But it's probably not a great
idea to throw a hundred lines at it yet :)

Having said that it passed the tests in tests/build/*.bas in the github.

Some things obviously won't work, programs that manipulate the source code itself for example, or have
embedded machine code. 

The speed increase varies but probably will be of the range 4-8 times. Things like floating point aren't
any quicker because you are still using a 6502. Something like 'balls' which uses integers works better.

I have included TODO so you can see what does and doesn't work. Some things aren't worth doing or have
no real point ; things like GEOS, OLD, LIST, MON don't make a lot of sense in a compiled context.

There are two ways of updating, one is to clone the github and update it, the other to download the
latest release.

Reporting can be done via email, placing issues on the github, or over discord. A description of the 
problem and a BASIC source will be all I need.

(Note the error addresses on the runtime are machine code addresses not line numbers)

Paul Robson
paul@robsons.org.uk
https://github.com/paulscottrobson/blitz-compiler
