@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2020
@ Licensed under the GPLv2 or newer
@
@ File : test_1.s
@ Date : August 21st, 2020
@ Description : THUMB.1 test
@
@ THUMB.1 Move-Shifted Register 

@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@Tests LSL #0. Has special significance. No shift is performed. Carry Flag is UNAFFECTED

@Set carry flag
msr	cpsr_f, #0x20000000

ldr	r0, =THUMB_TEST_1_1_START
ldr	r3, =THUMB_TEST_1_1_END
add	r0, #0x01
bx	r0

.align 2
.thumb
THUMB_TEST_1_1_START:

mov	r0, #0x01
lsl	r0, r0, #0x00
bx	r3

.align 4
.arm
THUMB_TEST_1_1_END:

mrs	r1, cpsr
and	r1, #0x20000000
cmp	r1, #0x00
ldreq	r3, =fail_code_1_str
beq	THUMB_TEST_1_1_FAIL

cmp	r0, #0x01
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_1_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	THUMB_TEST_1_1_RET

@ Draw FAIL
THUMB_TEST_1_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x02
bl	PRINT_STRING

THUMB_TEST_1_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests LSL #10. Nothing special, but here we'll check to make sure flags get set properly according to the result
@ Z, N, C, and V flags are all set prior to the shift. 1 << 16 should unset all flags EXCEPT V

@Set all flags
msr	cpsr_f, #0xF0000000

ldr	r0, =THUMB_TEST_1_2_START
ldr	r3, =THUMB_TEST_1_2_END
add	r0, #0x01
bx	r0

.align 2
.thumb
THUMB_TEST_1_2_START:

mov	r0, #0x01
lsl	r0, r0, #0x10
bx	r3

.align 4
.arm
THUMB_TEST_1_2_END:

mrs	r1, cpsr
and	r1, #0xF0000000
cmp	r1, #0x10000000
ldrne	r3, =fail_code_1_str
bne	THUMB_TEST_1_2_FAIL

cmp	r0, #0x10000
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_2_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	THUMB_TEST_1_2_RET

@ Draw FAIL
THUMB_TEST_1_2_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x03
bl	PRINT_STRING

THUMB_TEST_1_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests LSL #1F.
@ Z, N, C, and V flags are all cleared prior to the shift. 1 << 31 should only set the N flag and C flag

@Clear all flags
msr	cpsr_f, #0x00

ldr	r0, =THUMB_TEST_1_3_START
ldr	r3, =THUMB_TEST_1_3_END
add	r0, #0x01
bx	r0

.align 2
.thumb
THUMB_TEST_1_3_START:

mov	r0, #0x03
lsl	r0, r0, #0x1F
bx	r3

.align 4
.arm
THUMB_TEST_1_3_END:

mrs	r1, cpsr
and	r1, #0xF0000000
cmp	r1, #0xA0000000
ldrne	r3, =fail_code_1_str
bne	THUMB_TEST_1_3_FAIL

cmp	r0, #0x80000000
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_3_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	THUMB_TEST_1_3_RET

@ Draw FAIL
THUMB_TEST_1_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x04
bl	PRINT_STRING

THUMB_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

@Tests LSL #0. Has special significance. Turns into LSR #20. 1 >> 0 should set zero flag.

@Clear flags
msr	cpsr_f, #0x00

ldr	r0, =THUMB_TEST_1_4_START
ldr	r3, =THUMB_TEST_1_4_END
add	r0, #0x01
bx	r0

.align 2
.thumb
THUMB_TEST_1_4_START:

mov	r0, #0x01
raw_lsr: .hword 0x0800
bx	r3

.align 4
.arm
THUMB_TEST_1_4_END:

mrs	r1, cpsr
and	r1, #0x40000000
cmp	r1, #0x00
ldreq	r3, =fail_code_1_str
beq	THUMB_TEST_1_4_FAIL

cmp	r0, #0x00
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_4_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING
b	THUMB_TEST_1_4_RET

@ Draw FAIL
THUMB_TEST_1_4_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x05
bl	PRINT_STRING

THUMB_TEST_1_4_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_5 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

@Tests LSL #10. 0x8000 >> 16 should set zero flag and carry flag

@Clear flags
msr	cpsr_f, #0x00

ldr	r0, =THUMB_TEST_1_5_START
ldr	r3, =THUMB_TEST_1_5_END
add	r0, #0x01
mov	r2, #0x8000
bx	r0

.align 2
.thumb
THUMB_TEST_1_5_START:

mov	r0, r2
lsr	r0, r0, #0x10
bx	r3

.align 4
.arm
THUMB_TEST_1_5_END:

mrs	r1, cpsr
and	r1, #0x60000000
cmp	r1, #0x00
ldreq	r3, =fail_code_1_str
beq	THUMB_TEST_1_5_FAIL

cmp	r0, #0x00
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_5_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING
b	THUMB_TEST_1_5_RET

@ Draw FAIL
THUMB_TEST_1_5_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x06
bl	PRINT_STRING

THUMB_TEST_1_5_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ THUMB_TEST_1_6 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
THUMB_TEST_1_6:

stmfd	r13!, {r0, r1, r2, r3, r14}

@Tests LSL #1F. 0x4000 >> 32 should set Z flag. N and C flag cleared. Leave V flag alone.

@Set all flags
msr	cpsr_f, #0xF0

ldr	r0, =THUMB_TEST_1_6_START
ldr	r3, =THUMB_TEST_1_6_END
add	r0, #0x01
mov	r2, #0x40000000
bx	r0

.align 2
.thumb
THUMB_TEST_1_6_START:

mov	r0, r2
lsr	r0, r0, #0x1F
bx	r3

.align 4
.arm
THUMB_TEST_1_6_END:

mrs	r1, cpsr
and	r1, #0xF0000000
cmp	r1, #0x50
ldreq	r3, =fail_code_1_str
beq	THUMB_TEST_1_6_FAIL

cmp	r0, #0x00
ldrne	r3, =fail_code_2_str
bne	THUMB_TEST_1_6_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING
b	THUMB_TEST_1_6_RET

@ Draw FAIL
THUMB_TEST_1_6_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

mov	r0, r3
mov	r1, #0x1A
mov	r2, #0x07
bl	PRINT_STRING

THUMB_TEST_1_6_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
