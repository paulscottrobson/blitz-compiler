; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_i2c.asm
;		Purpose:	I2C Peek/Poke
;		Created:	9th May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;								I2CPOKE device,register,value
;
; ************************************************************************************************

X16I2CPoke: ;; [!I2CPOKE]
		.entercmd
		phy
		jsr 	GetInteger8Bit 				; value
		pha
		dex
		jsr 	GetInteger8Bit 				; register
		pha
		dex
		jsr 	GetInteger8Bit 				; device
		tax 			
		ply
		pla
		jsr 	X16_i2c_write_byte 			; write the byte out.
		bcs 	X16I2CError
		ply
		ldx 	#$FF
		.exitcmd

X16I2CError:
		.error_channel 

; ************************************************************************************************
;
;									I2CPEEK(device,register)
;
; ************************************************************************************************

X16I2CPeek: ;; [!I2CPEEK]		
		.entercmd
		phx
		phy
		jsr 	GetInteger8Bit 				; register
		pha
		dex
		jsr 	GetInteger8Bit 				; device
		tax 								; X device
		ply 								; Y register
		jsr 	X16_i2c_read_byte 			; read I2C
		bcs 	X16I2CError
		ply 								; restore Y/X
		plx
		dex 								; drop TOS (register)
		jsr 	FloatSetByte 				; write read value to TOS.
		.exitcmd

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
