@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : common.s
@ Date : September 8th, 2018
@ Description : Common ARM function and routines
@
@ Various useful, common functions


@@@@@@@@@@@@@@@
@ WAIT_VBLANK @
@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@
WAIT_VBLANK:

stmfd	r13!, {r0, r1, r2, r3}

mov	r0, #0xC0
ldr	r1, =0x4000006
ldr	r2, =0x1FF

VBLANK_LOOP:
	ldrh 	r3, [r1]
	and	r3, r2
	cmp	r3, r0
	bne VBLANK_LOOP

ldmfd	r13!, {r0, r1, r2, r3}

@ Return
mov	r15, r14


@@@@@@@@@@@@@@@@
@ PRINT_STRING @
@@@@@@@@@@@@@@@@
@ R0 -> Address of string
@ R1 -> X offset
@ R2 -> Y offset
@@@@@@@@@@@@@@@@
PRINT_STRING:

stmfd	r13!, {r0, r1, r2, r3}

@ Print 32 characters max, use R2 as counter, R3 as base addr for VRAM
ldr	r3, =0x6001000
lsl	r1, r1, #0x1
add	r3, r1, r3
lsl	r2, r2, #0x6
add	r3, r2, r3
mov	r2, #0x20

@ Grab ASCII byte, then convert ASCII text to font offsets
GRAB_STRING_DATA:
ldrb	r1, [r0]

@Terminate printing early if null character detected
cmp	r1, #0x00
beq	PRINT_STRING_RET

@ Check if equal to space
cmp	r1, #0x20
bne	NOT_20
mov	r1, #0x00
b	PROCESS_TEXT

@ Check if equal to asterisk (translates to block)
NOT_20:
cmp	r1, #0x2A
bne	NOT_2A
mov	r1, #0x25
b	PROCESS_TEXT

@ Check if >= to 0x30 and <= to 0x39
NOT_2A:
cmp	r1, #0x30
blt	NOT_APPLICABLE
cmp	r1, #0x39
bgt	GT_39
sub	r1, r1, #0x2F
b	PROCESS_TEXT

@ Check if >= to 0x41 and <= 0x5A
GT_39:
cmp	r1, #0x41
blt	NOT_APPLICABLE
cmp	r1, #0x5A
bgt	GT_5A
sub	r1, r1, #0x36
b	PROCESS_TEXT

@ Check if >= to 0x61 and <= 0x7A
GT_5A:
cmp	r1, #0x61
blt	NOT_APPLICABLE
cmp	r1, #0x7A
bgt	NOT_APPLICABLE
sub	r1, r1, #0x56
b	PROCESS_TEXT

@ If no matching character, use 0
NOT_APPLICABLE:
mov	r1, #0x00
b	PROCESS_TEXT

@ Draw text to tile map
PROCESS_TEXT:
strh	r1, [r3]
add	r3, #0x02
add	r0, #0x01
sub	r2, #0x01
cmp	r2, #0x00
bne	GRAB_STRING_DATA

@ Return
PRINT_STRING_RET:
ldmfd	r13!, {r0, r1, r2, r3}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ PRINT_VALUE  @
@@@@@@@@@@@@@@@@
@ R0 -> 32-bit value
@ R1 -> X offset
@ R2 -> Y offset
@@@@@@@@@@@@@@@@
PRINT_VALUE:

stmfd	r13!, {r0, r1, r2, r3, r4, r5, r6}

@ Print 8 characters max.
@ R3 = address to VRAM map, R4 = loop counter, R5 = mask, R6 = scratch
ldr	r3, =0x6001000
lsl	r1, r1, #0x1
add	r3, r1, r3
lsl	r2, r2, #0x6
add	r3, r2, r3
mov	r2, #0x20

mov	r4, #0x08
mov	r5, #0xF0000000

@@@ Draw result by shifting R0 and converting the result to map entries
PARSE_VALUE:

@Convert to map entry format
and	r6, r0, r5
mov	r6, r6, LSR #0x1C
add	r6, #0x01
mov	r0, r0, LSL #0x04

@ Store map entry, update address and loop counter
strh	r6, [r3]
add	r3, #0x02
subs	r4, #0x01
bne	PARSE_VALUE

@ Return
PRINT_VALUE_RET:
ldmfd	r13!, {r0, r1, r2, r3, r4, r5, r6}
mov	r15, r14

@@@@@@@@@@@@@@@
@ WAIT_FRAMES @
@@@@@@@@@@@@@@@
@ R0 - Number of frames to wait
@@@@@@@@@@@@@@@
WAIT_FRAMES:

stmfd	r13!, {r0, r1, r2, r3, r4}
mov	r4, r0

WAIT_FRAMES_START:
mov	r0, #0x00
ldr	r1, =0x4000006
ldr	r2, =0x1FF

WAIT_LOOP_1:
	ldrh 	r3, [r1]
	and	r3, r2
	cmp	r3, r0
	bne WAIT_LOOP_1

mov	r0, #0xC0

WAIT_LOOP_2:
	ldrh 	r3, [r1]
	and	r3, r2
	cmp	r3, r0
	bne WAIT_LOOP_2

sub	r4, #0x01
cmp	r4, #0x00
bne	WAIT_FRAMES_START

ldmfd	r13!, {r0, r1, r2, r3, r4}

@ Return
mov	r15, r14


@@@@@@@@@@@@@
@ CLEAR_MAP @
@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@
CLEAR_MAP:

stmfd	r13!, {r0, r1, r2, r3, r4}

ldr	r0, =0x6001000
mov	r2, #0x400
mov	r1, #0x00

CLEAR_MAP_LOOP:
	strh	r1, [r0]
	add	r0, #0x02
	sub	r2, #0x01
	cmp	r2, #0x00
	bne	CLEAR_MAP_LOOP

ldmfd	r13!, {r0, r1, r2, r3, r4}

@ Return
mov	r15, r14

