@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : arm9_memory_test-ds.s
@ Date : September 7th, 2018
@ Description : Low-level NDS9 memory test
@
@ Tests various aspects of the NDS' ARM9 and memory access
@ Focuses on I/O access, memory mirrors, and edge cases

@ 1BPP Font
.global font
font:			.incbin "../data/allfont.bin"

.global main
main:

@Disable IRQs
mov	r0, #0x00
ldr 	r1, =0x4000208
str	r0, [r1]

add	r1, #0x08
str	r0, [r1]

add	r1, #0x04
str	r0, [r1]

@ Map vram bank A
mov 	r0, #0x81
ldr 	r1, =0x4000240
strb 	r0, [r1]

bl	WAIT_VBLANK

@ Copy font to VRAM
ldr	r1, =font
mov	r2, #0x6000000
mov	r3, #0x980

font_copy:
	ldr r0, [r1]
	str r0, [r2]
	add r1, #0x04
	add r2, #0x04
	subs r3, #0x04
	bne font_copy

@ Setup 1BPP palette
ldr	r0, =0x7FFF
ldr	r1, =0x5000000
strh	r0, [r1]

mov	r0, #0x00
add	r1, #0x02
strh	r0, [r1]

@ Setup inverse 1BPP palette (for highlighting)
mov	r0, #0x00
ldr	r1, =0x5000020
strh	r0, [r1]

ldr	r0, =0x7FFF
add	r1, #0x02
strh	r0, [r1]

@ Setup DISPCNT
ldr 	r0, =0x10100
mov 	r1, #0x4000000
str 	r0, [r1]

@ Setup BG0CNT
mov	r0, #0x280
ldr	r1, =0x4000008
str 	r0, [r1]

@ Setup Shared WRAM
mov	r0, #0x00
ldr 	r1, =0x4000247
str	r0, [r1]

bl	WAIT_VBLANK
bl	DRAW_MENU_0

loopy_loop:
	bl	WAIT_VBLANK
	bl	CHECK_INPUT_CURSOR
	bl	CHECK_INPUT_AB
	b	loopy_loop

@@@@@@@@@@@@@@@@@@@@@@
@ CHECK_INPUT_CURSOR @
@@@@@@@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@@@@@@@
CHECK_INPUT_CURSOR:

stmfd	r13!, {r0, r1, r2, r3, r14}

ldr	r0, =0x4000130
ldrh	r1, [r0]

@ Check global state to see if cursor movement is applicable
and	r2, r10, #0xFF
cmp	r2, #0x02
bgt	CHECK_INPUT_CURSOR_RET

@ Check keypad for up input
and	r2, r1, #0x40
cmp	r2, #0x0
bne	CHECK_INPUT_CURSOR_DOWN

mov	r3, r11
sub	r3, r3, #0x01
cmp	r3, #0x02
blt	CHECK_INPUT_CURSOR_RET
b	MOVE_CURSOR

@ Check keypad for down input
CHECK_INPUT_CURSOR_DOWN:
and	r2, r1, #0x80
cmp	r2, #0x00
bne	CHECK_INPUT_CURSOR_RET

mov	r3, r11
add	r3, r3, #0x01
cmp	r3, #0x10
bgt	CHECK_INPUT_CURSOR_RET
b	MOVE_CURSOR

MOVE_CURSOR:
ldr	r0, =0x8
bl	WAIT_FRAMES
ldr	r0, =blank_str
mov	r1, #0x00
mov	r2, r11
bl	PRINT_STRING

ldr	r0, =asterisk_str
mov	r1, #0x00
mov	r2, r3
bl	PRINT_STRING
mov	r11, r3

@ Return
CHECK_INPUT_CURSOR_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@@@
@ CHECK_INPUT_AB @
@@@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@@@
CHECK_INPUT_AB:

stmfd	r13!, {r0, r1, r2, r3, r14}

ldr	r0, =0x4000130
ldrh	r1, [r0]

@ Check keypad for A input
and	r2, r1, #0x1
cmp	r2, #0x0
bne	CHECK_INPUT_B

@ Check A input - Menu 1
@ Check TEST 1
cmp	r11, #0x2
bne	CHECK_TEST_2
ldr	r0, =0x1
bl	WAIT_FRAMES
bl	DRAW_MENU_1
bl	MEM_TEST_1_1
bl	MEM_TEST_1_2
bl	MEM_TEST_1_3
b	CHECK_INPUT_AB_RET

@ Check TEST 2
CHECK_TEST_2:
cmp	r11, #0x03
bne	CHECK_TEST_3
ldr	r0, =0x1
bl	WAIT_FRAMES
bl	DRAW_MENU_2
bl	MEM_TEST_2_1
bl	MEM_TEST_2_2
b	CHECK_INPUT_AB_RET

@ Check TEST 3
CHECK_TEST_3:

@ Check TEST 4
CHECK_TEST_4:
cmp	r11, #0x5
bne	CHECK_TEST_5
ldr	r0, =0x1
bl	WAIT_FRAMES
bl	DRAW_MENU_4
bl	MEM_TEST_4_1
bl	MEM_TEST_4_2
bl	MEM_TEST_4_3
bl	MEM_TEST_4_4
bl	MEM_TEST_4_5
b	CHECK_INPUT_AB_RET

@ Check TEST 5
CHECK_TEST_5:
cmp	r11, #0x6
bne	CHECK_INPUT_AB_RET
ldr	r0, =0x1
bl	WAIT_FRAMES
bl	DRAW_MENU_5
bl	MEM_TEST_5_1
b	CHECK_INPUT_AB_RET

@ Check B input - Restart entire program to get back to Main Menu
CHECK_INPUT_B:
and	r2, r1, #0x2
cmp	r2, #0x0
bne	CHECK_INPUT_AB_RET

ldmfd	r13!, {r0, r1, r2, r3, r14}
b	main

CHECK_INPUT_AB_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@ Function imports
.include	"../source/common.s"
.include	"../source/menu.s"
.include	"../source/test_1.s"
.include	"../source/test_2.s"
.include	"../source/test_4.s"
.include	"../source/test_5.s"

@@@@@@@@@@@
@ Strings @
@@@@@@@@@@@

.align 2
test_title_str:		.asciz "NDS MEMORY TEST"
main_item_1_str:	.asciz "READING"
main_item_2_str:	.asciz "WRITING"
main_item_3_str:	.asciz "SHARED WRAM CHECK"
main_item_4_str:	.asciz "MIRROR CHECK"
main_item_5_str:	.asciz "BIOS RAM USAGE"
asterisk_str:		.asciz "*"
blank_str:		.asciz " "

test_1_1_str:		.asciz "16BIT ALIGN READ"
test_1_2_str:		.asciz "32BIT ALIGN READ"
test_1_3_str:		.asciz "ARM9 BIOS READ"

test_2_1_str:		.asciz "16BIT ALIGN WRITE"
test_2_2_str:		.asciz "32BIT ALIGN WRITE"

test_4_1_str:		.asciz "ARM9 MAIN WRAM"
test_4_2_str:		.asciz "ARM9 SHARED WRAM"
test_4_3_str:		.asciz "ARM9 PALETTES"
test_4_4_str:		.asciz "ARM9 OAM"
test_4_5_str:		.asciz "ARM9 ITCM BASE"

test_5_1_str:		.asciz "CHIP ID 1"
test_5_2_str:		.asciz "CHIP ID 2"
test_5_3_str:		.asciz "FRAME COUNTER"
test_5_4_str:		.asciz "BOOT STATUS"
test_5_5_str:		.asciz "NICKNAME"
test_5_6_str:		.asciz "ADC X1"
test_5_7_str:		.asciz "ADC Y1"
test_5_8_str:		.asciz "SCR X1"
test_5_9_str:		.asciz "SCR Y1"
test_5_10_str:		.asciz "ADC X2"
test_5_11_str:		.asciz "ADC Y2"
test_5_12_str:		.asciz "SCR X2"
test_5_13_str:		.asciz "SCR Y2"
test_5_name:		.asciz "            "


fail_str:		.asciz "FAIL"
fail_code_1_str:	.asciz "1"
fail_code_2_str:	.asciz "2"
fail_code_3_str:	.asciz "3"
fail_code_4_str:	.asciz "4"
pass_str:		.asciz "PASS"

.end
