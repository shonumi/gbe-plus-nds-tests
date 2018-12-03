@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : test_1.s
@ Date : December 2nd, 2018
@ Description : Math Test 1
@
@ Tests NDS9 hardware division 

@@@@@@@@@@@@@@@@
@ MATH_TEST_1_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 32-bit division
@ 0xDEADC0DE = Numerator
ldr	r0, =0xDEADC0DE
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xFACE = Denominator
ldr	r0, =0xFACE
ldr	r1, =0x4000298
str	r0, [r1]

@ Setup DIVCNT
mov	r0, #0x00
ldr	r1, =#0x4000280
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT should be 0xFFFFDDFE
ldr	r1, =0x40002A0
ldr	r0, [r1]

mov	r1, #0x00
mov	r2, #0x06
bl	PRINT_VALUE

ldr	r2, =0xFFFFDDFE
cmp	r0, r2
bne	MATH_TEST_1_1_FAIL

@ DIV_REMAINDER should be 0xFFFF127A
ldr	r1, =0x40002A8
ldr	r0, [r1]

mov	r1, #0x00
mov	r2, #0x07
bl	PRINT_VALUE

ldr	r2, =0xFFFF127A
cmp	r0, r2
bne	MATH_TEST_1_1_FAIL

ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	MATH_TEST_1_1_RET

@ Draw FAIL
MATH_TEST_1_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

MATH_TEST_1_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MATH_TEST_1_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	MATH_TEST_1_2_RET

@ Draw FAIL
MATH_TEST_1_2_FAIL:
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

MATH_TEST_1_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MATH_TEST_1_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	MATH_TEST_1_3_RET

@ Draw FAIL
MATH_TEST_1_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

MATH_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
