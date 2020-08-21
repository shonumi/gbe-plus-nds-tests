@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2020
@ Licensed under the GPLv2 or newer
@
@ File : test_2.s
@ Date : August 8th, 2020
@ Description : Memory Test 2
@
@ Tests reading various memory locations under different conditions 

@@@@@@@@@@@@@@@@
@ MEM_TEST_2_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_2_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests unaligned 16-bit writes to WRAM
@ Saves the value 0xC0DE to 0x2000007, then reads 0x2000006 and 0x2000008
@ 0x2000006 should be 0xC0DE. 0x2000008 should be 0x0000
ldr	r0, =0xC0DE
ldr	r1, =0x2000007
ldr	r2, =0x2000006
mov	r3, #0x00

@ Clear memory, then write to 0x2000007
strh	r3, [r2]
strh	r3, [r2, #0x02]
strh	r0, [r1]

ldrh	r3, [r2]
cmp	r3, r0
bne	MEM_TEST_2_1_FAIL

ldrh	r3, [r2, #0x02]
cmp	r3, #0x00
bne	MEM_TEST_2_1_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	MEM_TEST_2_1_RET

@ Draw FAIL
MEM_TEST_2_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

MEM_TEST_2_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MEM_TEST_2_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_2_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests unaligned 32-bit writes to WRAM
@ Saves the value 0xDEADC0DE to 0x2000006, then reads 0x2000004 and 0x2000008
@ 0x2000004 should be 0xDEADC0DE. 0x2000008 should be 0x0000
ldr	r0, =0xDEADC0DE
ldr	r1, =0x2000006
ldr	r2, =0x2000004
mov	r3, #0x00

@ Clear memory, then write to 0x2000007
str	r3, [r2]
str	r3, [r2, #0x04]
str	r0, [r1]

ldr	r3, [r2]
cmp	r3, r0
bne	MEM_TEST_2_2_FAIL

ldr	r3, [r2, #0x04]
cmp	r3, #0x00
bne	MEM_TEST_2_2_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	MEM_TEST_2_2_RET

@ Draw FAIL
MEM_TEST_2_2_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

MEM_TEST_2_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
