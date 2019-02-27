@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2019
@ Licensed under the GPLv2 or newer
@
@ File : test_2.s
@ Date : February 26th, 2019
@ Description : Math Test 2
@
@ Tests NDS9 hardware square_root 

@@@@@@@@@@@@@@@@
@ MATH_TEST_2_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_2_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 32-bit sqrt
@ Setup SQRTCNT
mov	r0, #0x00
ldr	r1, =#0x40002B0
str	r0, [r1]

@ Setup 32-bit parameter - 0x11223344
ldr	r0, =0x11223344
ldr	r1, =0x40002B8
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ SQRT_RESULT should be
ldr	r1, =0x40002B4
ldr	r0, [r1]

ldr	r2, =0x423A
cmp	r0, r2
bne	MATH_TEST_2_1_FAIL

ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	MATH_TEST_2_1_RET

@ Draw FAIL
MATH_TEST_2_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

MATH_TEST_2_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MATH_TEST_2_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_2_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 64-bit sqrt
@ Setup SQRTCNT
mov	r0, #0x01
ldr	r1, =#0x40002B0
str	r0, [r1]

@ Setup 64-bit Parameter 1 - 0x11223344
ldr	r0, =0x11223344
ldr	r1, =0x40002B8
str	r0, [r1]

@ Setup 64-bit Parameter 2 - 0x87654321
ldr	r0, =0x87654321
ldr	r1, =0x40002BC
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ SQRT_RESULT should be 0xBA2CE3F6
ldr	r1, =0x40002B4
ldr	r0, [r1]

ldr	r2, =0xBA2CE3F6
cmp	r0, r2
bne	MATH_TEST_2_2_FAIL

ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	MATH_TEST_2_2_RET

@ Draw FAIL
MATH_TEST_2_2_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

MATH_TEST_2_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
