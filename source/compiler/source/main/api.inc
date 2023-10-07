; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		api.inc
;		Purpose:	API Constants for compiler
;		Created:	7th October 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;									Mandatory Zero page code
;
; ************************************************************************************************
;
;		Open the input file or from memory.
;
BLC_OPENIN = 0
;
;		Close the input file. Cannot be reopened.
;
BLC_CLOSEIN = 1
;
;		Read the next line from the source file. This should be returned into YX and should
; 		point to the line number data ; e.g. the offset to next, line number etc.
;		Returns CS if line available, CC finished.
;
BLC_READ = 2
;
;		Reset the code writing pointer. Code has to be stored in memory as it is passed over
; 		at the end to fix up all the line number references. It can be stored on BLC_CLOSEOUT
;
BLC_RESETOUT = 3
;
;		Close the output - at this point you can write the generated code if you want.
;
BLC_CLOSEOUT = 4
;
;		Write a byte A at the obj code point YX (+0..+2 = address.low, address.high, page)
;		and increment that YX address appropriately. If code is paged it is advised to 
;		switch page when there are less than 1/4k bytes available, some code will not
;	 	split across pages.
;
BLC_WRITEOUT = 5
;
; 		Given a obj code point at YX, add the value at +3 to it.
;
BLC_ADJUSTOBJECT = 6
;
;		Print character A to display / stream for errors & information
;
BLC_PRINTCHAR = 7

; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;
; ************************************************************************************************

