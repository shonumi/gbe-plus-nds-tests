@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2019
@ Licensed under the GPLv2 or newer
@
@ File : test_5.s
@ Date : December 8th, 2019
@ Description : Memory Test 5
@
@ Tests reading various memory locations under different conditions 

@@@@@@@@@@@@@@@@
@ MEM_TEST_5_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_5_1:

stmfd	r13!, {r0, r1, r2, r3, r4, r5, r14}

@ Tests various reads for NDS BIOS RAM usage
@ Reads a few commonly used values left by firmware

@ Read NDS Gamecart Chip ID 1
ldr	r1, =0x27FF800
ldr	r3, [r1]

@Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x02
bl	PRINT_VALUE

@ Read NDS Gamecart Chip ID 2
ldr	r1, =0x27FF804
ldr	r3, [r1]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x03
bl	PRINT_VALUE

@ Read Frame Counter
ldr	r1, =0x27FFC3C
ldr	r3, [r1]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x04
bl	PRINT_VALUE

@ Boot Status
ldr	r1, =0x27FFC40
ldrh	r3, [r1]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x05
bl	PRINT_VALUE

@ Read user nickname
ldr	r1, =0x27FFC86
ldr	r4, =test_5_name
mov	r2, #0x00

NAME_READ_LOOP:
ldrh	r3, [r1, r2]
and	r3, #0xFF
strb	r3, [r4, r2, lsr#0x01]

add	r2, #0x02
cmp	r2, #0x14
bne	NAME_READ_LOOP

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r4
mov	r1, #0x14
mov	r2, #0x06
bl	PRINT_STRING

@ Read ADC X1, Y1
ldr	r1, =0x27FFCD8
ldrh	r3, [r1]
ldrh	r4, [r1, #0x02]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x07
bl	PRINT_VALUE

mov	r0, r4
mov	r1, #0x18
mov	r2, #0x08
bl	PRINT_VALUE

@ Read SCR X1, Y1
ldr	r1, =0x27FFCDC
ldrb	r3, [r1]
ldrb	r4, [r1, #0x01]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x09
bl	PRINT_VALUE

mov	r0, r4
mov	r1, #0x18
mov	r2, #0x0A
bl	PRINT_VALUE

@ Read ADC X2, Y2
ldr	r1, =0x27FFCDE
ldrh	r3, [r1]
ldrh	r4, [r1, #0x02]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x0B
bl	PRINT_VALUE

mov	r0, r4
mov	r1, #0x18
mov	r2, #0x0C
bl	PRINT_VALUE

@ Read SCR X2, Y2
ldr	r1, =0x27FFCE2
ldrb	r3, [r1]
ldrb	r4, [r1, #0x01]

@ Print result
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x18
mov	r2, #0x0D
bl	PRINT_VALUE

mov	r0, r4
mov	r1, #0x18
mov	r2, #0x0E
bl	PRINT_VALUE

MEM_TEST_5_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r4, r5, r14}
mov	r15, r14
