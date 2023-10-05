; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		gendata.asm
;		Purpose:	Generation data files
;		Created:	16th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

	
; ************************************************************************************************
;
;			Generator tables. Apologies for messy way of including those for alt systems
;
; ************************************************************************************************

CommandTables:
		.include 	"source/generation/commands.defc"
		;.include "../../x16_compiler/generation/x16_command.defc"
		;.include "../../x16_compiler/generated/x16_sound.defc"
		.byte 	0

UnaryTables:
		;.include 	"unary.defc"
		;	.include "../../x16_compiler/generation/x16_unary.defc"
		.byte 	0

		.send  code		

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
