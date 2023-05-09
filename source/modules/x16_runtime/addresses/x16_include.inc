; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		x16_include.inc
;		Purpose:	Addresses X16 Kernal
;		Created:	2nd May 2023
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

X16_r0 = 2
X16_r1 = 4
X16_r2 = 6
X16_r3 = 8
X16_r4 = 10

X16_ACPTR=$FFA5
X16_BASIN=$FFCF
X16_BSAVE=$FEBA
X16_BSOUT=$FFD2
X16_CIOUT=$FFA8
X16_CLALL=$FFE7
X16_CLOSE=$FFC3
X16_CHKIN=$FFC6
X16_CHKOUT=$FFC9
X16_clock_get_date_time=$FF50
X16_clock_set_date_time=$FF4D
X16_CHRIN=$FFCF
X16_CHROUT=$FFD2
X16_CLOSE_ALL=$FF4A
X16_CLRCHN=$FFCC
X16_console_init=$FEDB
X16_console_get_char=$FEE1
X16_console_put_char=$FEDE
X16_console_put_image=$FED8
X16_console_set_paging_message=$FED5
X16_enter_basic=$FF47
X16_entropy_get=$FECF
X16_fetch=$FF74
X16_FB_cursor_next_line=$FF02
X16_FB_cursor_position=$FEFF
X16_FB_fill_pixels=$FF17
X16_FB_filter_pixels=$FF1A
X16_FB_get_info=$FEF9
X16_FB_get_pixel=$FF05
X16_FB_get_pixels=$FF08
X16_FB_init=$FEF6
X16_FB_move_pixels=$FF1D
X16_FB_set_8_pixels=$FF11
X16_FB_set_8_pixels_opaque=$FF14
X16_FB_set_palette=$FEFC
X16_FB_set_pixel=$FF0B
X16_FB_set_pixels=$FF0E
X16_GETIN=$FFE4
X16_GRAPH_clear=$FF23
X16_GRAPH_draw_image=$FF38
X16_GRAPH_draw_line=$FF2C
X16_GRAPH_draw_oval=$FF35
X16_GRAPH_draw_rect=$FF2F
X16_GRAPH_get_char_size=$FF3E
X16_GRAPH_init=$FF20
X16_GRAPH_move_rect=$FF32
X16_GRAPH_put_char=$FF41
X16_GRAPH_set_colors=$FF29
X16_GRAPH_set_font=$FF3B
X16_GRAPH_set_window=$FF26
X16_i2c_read_byte=$FEC6
X16_i2c_write_byte=$FEC9
X16_IOBASE=$FFF3
X16_JSRFAR=$FF6E
X16_joystick_get=$FF56
X16_joystick_scan=$FF53
X16_kbdbuf_get_modifiers=$FEC0
X16_kbdbuf_peek=$FEBD
X16_kbdbuf_put=$FEC3
X16_keymap=$FED2
X16_LISTEN=$FFB1
X16_LKUPLA=$FF59
X16_LKUPSA=$FF5C
X16_LOAD=$FFD5
X16_MACPTR=$FF44
X16_MEMBOT=$FF9C
X16_memory_copy=$FEE7
X16_memory_crc=$FEEA
X16_memory_decompress=$FEED
X16_memory_fill=$FEE4
X16_MEMTOP=$FF99
X16_monitor=$FECC
X16_mouse_config=$FF68
X16_mouse_get=$FF6B
X16_mouse_scan=$FF71
X16_OPEN=$FFC0
X16_PFKEY=$FF65
X16_PLOT=$FFF0
X16_PRIMM=$FF7D
X16_RDTIM=$FFDE
X16_READST=$FFB7
X16_SAVE=$FFD8
X16_SCREEN=$FFED
X16_screen_mode=$FF5F
X16_screen_set_charset=$FF62
X16_SECOND=$FF93
X16_SETLFS=$FFBA
X16_SETMSG=$FF90
X16_SETNAM=$FFBD
X16_SETTIM=$FFDB
X16_SETTMO=$FFA2
X16_sprite_set_image=$FEF0
X16_sprite_set_position=$FEF3
X16_stash=$FF77
X16_STOP=$FFE1
X16_TALK=$FFB4
X16_TKSA=$FF96
X16_UDTIM=$FFEA
X16_UNLSN=$FFAE
X16_UNTLK=$FFAB

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
