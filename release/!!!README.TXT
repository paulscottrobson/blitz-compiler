
											Welcome to Blitz X16 early Alpha release
											========================================

Introduction
------------
This is very similar to Blitz on the C64 ; it converts tokenised BASIC to a pseudo code which 
is subsequently interpreted. Hopefully it will eventually compile almost all BASIC programs.

Scripts are provided to compile and run BASIC programs. The interface is currently primitive, 
source is appended to the compiler (blitz.prg), and run to compile it (compile.sh/bat) ; this output 
(pcode.bin) is then appended to the runtime (runtime.prg) and run (run.sh/bat).  Both of these 
leverage the emulator to do this. 

Python3 is a prerequisite. I think everything else is in the release directory.

This is not the final interface, which will hopefully be reasonably closely integrated in the machine.

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

It doesn't support most X16 commands (at the time of writing VPOKE HEX$ SCREEN BIN$ work) and these will
be progressively added. 

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
