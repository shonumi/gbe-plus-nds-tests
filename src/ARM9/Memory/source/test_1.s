@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : test_1.s
@ Date : Octover 9th, 2018
@ Description : Memory Test 1
@
@ Tests reading various memory locations under different conditions 

@@@@@@@@@@@@@@@@
@ MEM_TEST_1_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_1_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests unaligned 16-bit reads to WRAM
@ Saves the value 0xC0DE to 0x2000008, then reads 0x2000009
ldr	r1, =0x2000008
ldrh	r3, [r1]
ldr	r2, =0xC0DE
mov	r0, r2
strh	r2, [r1]

ldr	r1, =0x2000009
ldrh	r2, [r1]
strh	r3, [r1]

cmp	r0, r2
bne	MEM_TEST_1_1_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	MEM_TEST_1_1_RET

@ Draw FAIL
MEM_TEST_1_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

MEM_TEST_1_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MEM_TEST_1_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_1_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests unaligned 32-bit reads to WRAM
@ Saves the value 0xDEADC0DE to 0x2000008, then reads 0x2000009, 0x200000A, and 0x200000B
@ Values should be the 32-bit value of the address AND 0x3 (to align by 4 bytes), then ROR by (address AND 0x3) * 8
@ Eg. 0x2000009 AND 0x3 = 0x1. Read 0x2000008, then ROR 8.
ldr	r1, =0x2000008
ldr	r3, [r1]
ldr	r2, =0xDEADC0DE
str	r2, [r1]

add	r1, #0x1
ldr	r2, [r1]

ldr	r0, =0xDEDEADC0
cmp	r0, r2
bne	MEM_TEST_1_2_FAIL

add	r1, #0x1
ldr	r2, [r1]

ldr	r0, =0xC0DEDEAD
cmp	r0, r2
bne	MEM_TEST_1_2_FAIL

add	r1, #0x1
ldr	r2, [r1]

ldr	r0, =0xADC0DEDE
cmp	r0, r2
bne	MEM_TEST_1_2_FAIL

@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	MEM_TEST_1_2_RET

@ Draw FAIL
MEM_TEST_1_2_FAIL:
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

MEM_TEST_1_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MEM_TEST_1_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_1_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Reads a few bytes from the NDS9 BIOS. Unlike the GBA, NDS9 BIOS have no read protections. Basically just check for non-zero values

ldr	r1, =0xFFFF0000
ldr	r3, [r1]

cmp	r3, #0x00
beq	MEM_TEST_1_3_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	MEM_TEST_1_3_RET

@ Draw FAIL
MEM_TEST_1_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

MEM_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
