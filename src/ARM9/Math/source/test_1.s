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
@ Setup DIVCNT
mov	r0, #0x00
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0xDEADC0DE = Numerator
ldr	r0, =0xDEADC0DE
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xFACE = Denominator
ldr	r0, =0xFACE
ldr	r1, =0x4000298
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT should be 0xFFFFDDFE
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0xFFFFDDFE
cmp	r0, r2
bne	MATH_TEST_1_1_FAIL

@ DIV_REMAINDER should be 0xFFFF127A
ldr	r1, =0x40002A8
ldr	r0, [r1]

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

@ Tests 64-bit/32-bit division
@ Setup DIVCNT
mov	r0, #0x01
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x0 = Numerator Part 1
ldr	r0, =0x0
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xFEEDBEEF = Numerator Part 2
ldr	r0, =0xFEEDBEEF
ldr	r1, =0x4000294
str	r0, [r1]

@ 0x1337 = Denominator
ldr	r0, =0x1337
ldr	r1, =0x4000298
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1  should be 0x1A4821BA
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0x1A4821BA
cmp	r0, r2
mov	r3, #0x1
bne	MATH_TEST_1_2_FAIL

@ DIV_RESULT Part 2  should be 0xFFFFF1BA
ldr	r1, =0x40002A4
ldr	r0, [r1]

ldr	r2, =0xFFFFF1BA
cmp	r0, r2
mov	r3, #0x2
bne	MATH_TEST_1_2_FAIL

@ DIV_REMAINDER should be 0xFFFFF30A
ldr	r1, =0x40002A8
ldr	r0, [r1]

ldr	r2, =0xFFFFF30A
cmp	r0, r2
mov	r3, #0x3
bne	MATH_TEST_1_2_FAIL

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

@ Tests 64-bit/32-bit division
@ Setup DIVCNT
mov	r0, #0x02
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x0 = Numerator Part 1
ldr	r0, =0x0
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xFEEDBEEF = Numerator Part 2
ldr	r0, =0xFEEDBEEF
ldr	r1, =0x4000294
str	r0, [r1]

@ 0x0 = Denominator Part 1
ldr	r0, =0x0
ldr	r1, =0x4000298
str	r0, [r1]

@ 0x1337 = Denominator Part 2
ldr	r0, =0x1337
ldr	r1, =0x400029C
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1 - Should be 0xFFFFF1BB
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0xFFFFF1BB
cmp	r0, r2
mov	r3, #0x1
bne	MATH_TEST_1_3_FAIL

@ DIV_RESULT Part 2 - Should be 0xFFFFFFFF
ldr	r1, =0x40002A4
ldr	r0, [r1]

ldr	r2, =0xFFFFFFFF
cmp	r0, r2
mov	r3, #0x2
bne	MATH_TEST_1_3_FAIL

@ DIV_REMAINDER Part 1 should be 0x00000000
ldr	r1, =0x40002A8
ldr	r0, [r1]

ldr	r2, =0x00000000
cmp	r0, r2
mov	r3, #0x3
bne	MATH_TEST_1_3_FAIL

@ DIV_REMAINDER Part 2 should be 0xFFFFEEC2
ldr	r1, =0x40002AC
ldr	r0, [r1]

ldr	r2, =0xFFFFEEC2
cmp	r0, r2
mov	r3, #0x3
bne	MATH_TEST_1_3_FAIL

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
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

MATH_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MATH_TEST_1_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 32-bit/32-bit division
@ Setup DIVCNT
mov	r0, #0x00
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x12345678 = Numerator Part 1
ldr	r0, =0x12345678
ldr	r1, =0x4000290
str	r0, [r1]

@ 0x00000000 = Denominator Part 1
ldr	r0, =0x00000000
ldr	r1, =0x4000298
str	r0, [r1]

@ 0x00000000 = Denominator Part 2
ldr	r0, =0x00000000
ldr	r1, =0x400029C
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1 - should be 0xFFFFFFFF
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0xFFFFFFFF
cmp	r0, r2
mov	r3, #0x0
bne	MATH_TEST_1_4_FAIL

@ DIV_RESULT Part 2 - should be 0x00000000
ldr	r1, =0x40002A4
ldr	r0, [r1]

ldr	r2, =0x00000000
cmp	r0, r2
mov	r3, #0x1
bne	MATH_TEST_1_4_FAIL

@ DIV_REMAINDER should be the numerator
ldr	r1, =0x40002A8
ldr	r0, [r1]

ldr	r2, =0x12345678
cmp	r0, r2
mov	r3, #0x2
bne	MATH_TEST_1_4_FAIL

@ Check DIVCNT for zero division flag - Byte 14
ldr	r1, =#0x4000280
ldr	r0, [r1]

ands	r0, #0x4000
mov	r3, #0x3
beq	MATH_TEST_1_4_FAIL	

@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING
b	MATH_TEST_1_4_RET

@ Draw FAIL
MATH_TEST_1_4_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1A
mov	r2, #0x05
bl	PRINT_STRING

ldr	r0, =fail_code_1_str
add	r0, r3, lsl #0x01
mov	r1, #0x1F
mov	r2, #0x05
bl	PRINT_STRING

MATH_TEST_1_4_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MATH_TEST_1_5 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 64-bit/64-bit division
@ Setup DIVCNT
mov	r0, #0x02
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x12345678 = Numerator Part 1
ldr	r0, =0x12345678
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xAABBCCDD = Numerator Part 2
ldr	r0, =0xAABBCCDD
ldr	r1, =0x4000294
str	r0, [r1]

@ 0x00000000 = Denominator Part 1
ldr	r0, =0x00000000
ldr	r1, =0x4000298
str	r0, [r1]

@ 0x00000000 = Denominator Part 2
ldr	r0, =0x00000000
ldr	r1, =0x400029C
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1 - should be 0x00000001
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0x00000001
cmp	r0, r2
mov	r3, #0x0
bne	MATH_TEST_1_5_FAIL

@ DIV_RESULT Part 2 - should be 0x00000000
ldr	r1, =0x40002A4
ldr	r0, [r1]

ldr	r2, =0x00000000
cmp	r0, r2
mov	r3, #0x1
bne	MATH_TEST_1_5_FAIL

@ DIV_REMAINDER should be the numerator
ldr	r1, =0x40002A8
ldr	r0, [r1]

ldr	r2, =0x12345678
cmp	r0, r2
mov	r3, #0x2
bne	MATH_TEST_1_5_FAIL

ldr	r1, =0x40002AC
ldr	r0, [r1]

ldr	r2, =0xAABBCCDD
cmp	r0, r2
mov	r3, #0x3
bne	MATH_TEST_1_5_FAIL

@ Check DIVCNT for zero division flag - Byte 14
ldr	r1, =#0x4000280
ldr	r0, [r1]

ands	r0, #0x4000
mov	r3, #0x4
beq	MATH_TEST_1_5_FAIL	

@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING
b	MATH_TEST_1_5_RET

@ Draw FAIL
MATH_TEST_1_5_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1A
mov	r2, #0x06
bl	PRINT_STRING

ldr	r0, =fail_code_1_str
add	r0, r3, lsl #0x01
mov	r1, #0x1F
mov	r2, #0x06
bl	PRINT_STRING

MATH_TEST_1_5_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MATH_TEST_1_6 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_6:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 32-bit/32-bit division
@ Setup DIVCNT
mov	r0, #0x00
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x80000000 = Numerator Part 1
ldr	r0, =0x80000000
ldr	r1, =0x4000290
str	r0, [r1]

@ 0xFFFFFFFF = Denominator Part 1
ldr	r0, =0xFFFFFFFF
ldr	r1, =0x4000298
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1 - should be 0x80000000
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0x80000000
cmp	r0, r2
bne	MATH_TEST_1_6_FAIL
	
@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING
b	MATH_TEST_1_6_RET

@ Draw FAIL
MATH_TEST_1_6_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING

MATH_TEST_1_6_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MATH_TEST_1_7 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MATH_TEST_1_7:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests 64-bit/64-bit division
@ Setup DIVCNT
mov	r0, #0x02
ldr	r1, =#0x4000280
str	r0, [r1]

@ 0x00000000 = Numerator Part 1
ldr	r0, =0x00000000
ldr	r1, =0x4000290
str	r0, [r1]

@ 0x80000000 = Numerator Part 2
ldr	r0, =0x80000000
ldr	r1, =0x4000294
str	r0, [r1]

@ 0xFFFFFFFF = Denominator Part 1
ldr	r0, =0xFFFFFFFF
ldr	r1, =0x4000298
str	r0, [r1]

@ 0xFFFFFFFF = Denominator Part 2
ldr	r0, =0xFFFFFFFF
ldr	r1, =0x400029C
str	r0, [r1]

@ Wait 1 frame, then grab result
ldr	r0, =0x1
bl	WAIT_FRAMES

@ DIV_RESULT Part 1 - should be 0x00000000
ldr	r1, =0x40002A0
ldr	r0, [r1]

ldr	r2, =0x00000000
cmp	r0, r2
mov	r3, #0x00
bne	MATH_TEST_1_7_FAIL

@ DIV_RESULT Part 2 - should be 0x80000000
ldr	r1, =0x40002A4
ldr	r0, [r1]

ldr	r2, =0x80000000
cmp	r0, r2
mov	r3, #0x01
bne	MATH_TEST_1_7_FAIL
	
@ Draw PASS
str	r3, [r1]
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x08
bl	PRINT_STRING
b	MATH_TEST_1_7_RET

@ Draw FAIL
MATH_TEST_1_7_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1A
mov	r2, #0x08
bl	PRINT_STRING

ldr	r0, =fail_code_1_str
add	r0, r3, lsl #0x01
mov	r1, #0x1F
mov	r2, #0x08
bl	PRINT_STRING

MATH_TEST_1_7_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
