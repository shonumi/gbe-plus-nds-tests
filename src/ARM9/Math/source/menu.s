@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : menu.s
@ Date : December 2nd, 2018
@ Description : Displays menus
@
@ Draw menus on screen

@@@@@@@@@@@@@@@
@ DRAW_MENU_0 @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
DRAW_MENU_0:

stmfd	r13!, {r0, r1, r2, r3, r14}

bl	CLEAR_MAP

ldr	r0, =test_title_str
mov	r1, #0x00
mov	r2, #0x00
bl	PRINT_STRING

ldr	r0, =main_item_1_str
mov	r1, #0x02
mov	r2, #0x02
bl	PRINT_STRING

ldr	r0, =main_item_2_str
mov	r1, #0x02
mov	r2, #0x03
bl	PRINT_STRING

ldr	r0, =asterisk_str
mov	r1, #0x00
mov	r2, #0x02
bl	PRINT_STRING

@ Set default global state in R10
mov	r10, #0x00

@ Set global cursor position in R11
mov	r11, #0x02

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@
@ DRAW_MENU_1 @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
DRAW_MENU_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

bl	CLEAR_MAP

ldr	r0, =main_item_1_str
mov	r1, #0x00
mov	r2, #0x00
bl	PRINT_STRING

ldr	r0, =test_1_1_str
mov	r1, #0x02
mov	r2, #0x02
bl	PRINT_STRING

ldr	r0, =test_1_2_str
mov	r1, #0x02
mov	r2, #0x03
bl	PRINT_STRING

ldr	r0, =test_1_3_str
mov	r1, #0x02
mov	r2, #0x04
bl	PRINT_STRING

ldr	r0, =test_1_4_str
mov	r1, #0x02
mov	r2, #0x05
bl	PRINT_STRING

ldr	r0, =test_1_5_str
mov	r1, #0x02
mov	r2, #0x06
bl	PRINT_STRING

ldr	r0, =test_1_6_str
mov	r1, #0x02
mov	r2, #0x07
bl	PRINT_STRING

ldr	r0, =test_1_7_str
mov	r1, #0x02
mov	r2, #0x08
bl	PRINT_STRING

@ Set default global state in R10
mov	r10, #0x01

@ Set global cursor position in R11
mov	r11, #0x00

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
