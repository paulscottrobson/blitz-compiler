; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		testend.asm
;		Purpose:	Code End Marker. Can put the code at the end of the runtime
;					(neat but not strictly required any more	)
;		Created:	11th April 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

		nextPage = (* + $FF) & $FF00 		; so I can include with that f*****g header.
		* = nextPage - 2		 			; I hate that bloody thing.
											; Either have a proper format or dump it and have a file just be the file.

ObjectCodePreHeader: 						; so we load in at XXFE
		.binary "code/code.bin"
ObjectCode = ObjectCodePreHeader+2 			; so the code is at XX00

		.send code

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
