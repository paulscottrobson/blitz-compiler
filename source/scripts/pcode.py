# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		pcode.py
#		Purpose :	Runtime P-Code definition
#		Date :		11th April 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************


# ***********************************************************************************************************************************************
#
#		0-63 			0-64	Constants 0-63, pushed on stack
# 		64-71 ll  		nn%@	Loads the 12 bit value (lower 3 bits of opcode, 11 bits of second byte, shifted left once) as a 16 bit integer
# 		72-79 ll  		nn%!	Saves the 12 bit value (lower 3 bits of opcode, 11 bits of second byte, shifted left once) as a 16 bit integer
#		80-87 ll 		nn@		As above but for a 32 bit ifloat
# 		88-95 ll 		nn! 	As above but for a 32 bit ifloat
# 		96-103 ll 		nn$@	As above but for a 16 bit string address
# 		104-111 ll 		nn$!	As above but for a 16 bit string address
# 		112-127 		(not used)
#		128+ 			Binary operators in the same order as in the C64, ending with the aditional >= <> <= tokens
#		+ 				Unary operators
#		+ 				Command words
#		+				Data words ; these have associated data, the size of which is in a table
#							[SHIFT] nn   		1		Shifted action word
#							[FLOAT] ll ss 		$FF		Float as string ($FF => length in first byte)
#							[STRING] ll ss 		$FF		ASCIIZ string
#							[DATA] ll ss 		$FF		Packed data statements
#							[GOTO] pp ll hh		3 		Go to page / offset from the pp
#							[GOSUB] pp ll hh 	3 		Same but GOSUB
#
# ***********************************************************************************************************************************************

