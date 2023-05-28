
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

The compiler is written in 6502 assembler. To make it easy to use, as it is not integrated into the X16
a program "blitz" now exists, which is a 6502 emulator wrapper for the code.

There are two script files runme.bat and runme.sh for Windows and Linux. 

Each of these does the same three steps.

1) 	Convert the text files balls.bas to source.prg (tokenised from) using a Python script.
2) 	Compile the source.prg to target.prg using the blitz program
3)  Run the target.prg using the emulator

I'd suggest starting with running this script to check everything is working, then changing the ball
count in balls.bas to check it is actually compiling the program.

I do not have a Mac so cannot  test it though it should build and work. I don't use Windows, so it is 
built and tested on Windows 8.1 running on Virtual Box, but it seems to work fine. Any problems with 
this one get in touch. The Linux binary was built on Arch (the source is in the crossdev directory 
in the github and should compile easily enough, only dependency is SDL2 and that might go sooner rather
than later).

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

Email 					: paul@robsons.org.uk
Source code 			: https://github.com/paulscottrobson/blitz-compiler
Discord and most forums : PaulScottRobson
