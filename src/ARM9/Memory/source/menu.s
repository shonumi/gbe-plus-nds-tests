@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : menu.s
@ Date : September 9th, 2018
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

ldr	r0, =main_item_3_str
mov	r1, #0x02
mov	r2, #0x04
bl	PRINT_STRING

ldr	r0, =main_item_4_str
mov	r1, #0x02
mov	r2, #0x05
bl	PRINT_STRING

ldr	r0, =main_item_5_str
mov	r1, #0x02
mov	r2, #0x06
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

ldr	r0, =main_item_4_str
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

@ Set default global state in R10
mov	r10, #0x01

@ Set global cursor position in R11
mov	r11, #0x00

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@
@ DRAW_MENU_2 @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
DRAW_MENU_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

bl	CLEAR_MAP

ldr	r0, =main_item_4_str
mov	r1, #0x00
mov	r2, #0x00
bl	PRINT_STRING

ldr	r0, =test_2_1_str
mov	r1, #0x02
mov	r2, #0x02
bl	PRINT_STRING

ldr	r0, =test_2_2_str
mov	r1, #0x02
mov	r2, #0x03
bl	PRINT_STRING

@ Set default global state in R10
mov	r10, #0x01

@ Set global cursor position in R11
mov	r11, #0x00

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@
@ DRAW_MENU_4 @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
DRAW_MENU_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

bl	CLEAR_MAP

ldr	r0, =main_item_4_str
mov	r1, #0x00
mov	r2, #0x00
bl	PRINT_STRING

ldr	r0, =test_4_1_str
mov	r1, #0x02
mov	r2, #0x02
bl	PRINT_STRING

ldr	r0, =test_4_2_str
mov	r1, #0x02
mov	r2, #0x03
bl	PRINT_STRING

ldr	r0, =test_4_3_str
mov	r1, #0x02
mov	r2, #0x04
bl	PRINT_STRING

ldr	r0, =test_4_4_str
mov	r1, #0x02
mov	r2, #0x05
bl	PRINT_STRING

ldr	r0, =test_4_5_str
mov	r1, #0x02
mov	r2, #0x06
bl	PRINT_STRING

@ Set default global state in R10
mov	r10, #0x01

@ Set global cursor position in R11
mov	r11, #0x00

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@
@ DRAW_MENU_5 @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
DRAW_MENU_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

bl	CLEAR_MAP

ldr	r0, =main_item_5_str
mov	r1, #0x00
mov	r2, #0x00
bl	PRINT_STRING

ldr	r0, =test_5_1_str
mov	r1, #0x02
mov	r2, #0x02
bl	PRINT_STRING

ldr	r0, =test_5_2_str
mov	r1, #0x02
mov	r2, #0x03
bl	PRINT_STRING

ldr	r0, =test_5_3_str
mov	r1, #0x02
mov	r2, #0x04
bl	PRINT_STRING

ldr	r0, =test_5_4_str
mov	r1, #0x02
mov	r2, #0x05
bl	PRINT_STRING

ldr	r0, =test_5_5_str
mov	r1, #0x02
mov	r2, #0x06
bl	PRINT_STRING

ldr	r0, =test_5_6_str
mov	r1, #0x02
mov	r2, #0x07
bl	PRINT_STRING

ldr	r0, =test_5_7_str
mov	r1, #0x02
mov	r2, #0x08
bl	PRINT_STRING

ldr	r0, =test_5_8_str
mov	r1, #0x02
mov	r2, #0x09
bl	PRINT_STRING

ldr	r0, =test_5_9_str
mov	r1, #0x02
mov	r2, #0x0A
bl	PRINT_STRING

ldr	r0, =test_5_10_str
mov	r1, #0x02
mov	r2, #0x0B
bl	PRINT_STRING

ldr	r0, =test_5_11_str
mov	r1, #0x02
mov	r2, #0x0C
bl	PRINT_STRING

ldr	r0, =test_5_12_str
mov	r1, #0x02
mov	r2, #0x0D
bl	PRINT_STRING

ldr	r0, =test_5_13_str
mov	r1, #0x02
mov	r2, #0x0E
bl	PRINT_STRING

@ Set default global state in R10
mov	r10, #0x01

@ Set global cursor position in R11
mov	r11, #0x00

@ Return
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
