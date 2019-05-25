@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2019
@ Licensed under the GPLv2 or newer
@
@ File : test_1.s
@ Date : May 15th, 2019
@ Description : IRQ test
@
@ Tests NDS9 interrupts 

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DISPSTAT
ldr	r1, =#0x4000004
mov	r0, #0x08
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for VBlank IRQ flag in IF
VBLANK_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x01
cmp	r0, #0x01
beq	IRQ_TEST_1_1_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_1_FAIL

b	VBLANK_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	IRQ_TEST_1_1_RET

@ Draw PASS
IRQ_TEST_1_1_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

IRQ_TEST_1_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DISPSTAT
ldr	r1, =#0x4000004
mov	r0, #0x10
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for HBlank IRQ flag in IF
HBLANK_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x02
cmp	r0, #0x02
beq	IRQ_TEST_1_2_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_2_FAIL

b	HBLANK_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_2_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	IRQ_TEST_1_2_RET

@ Draw PASS
IRQ_TEST_1_2_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

IRQ_TEST_1_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DISPSTAT
ldr	r1, =#0x4000004
ldr	r0, =#0x2020
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for LYC IRQ flag in IF
LYC_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x04
cmp	r0, #0x04
beq	IRQ_TEST_1_3_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_3_FAIL

b	LYC_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	IRQ_TEST_1_3_RET

@ Draw PASS
IRQ_TEST_1_3_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

IRQ_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Stop Timer 0 in case it is already running
ldr	r1, =#0x4000102
mov	r0, #0x00
strh	r0, [r1]

@ Setup Reload Value for Timer 0
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Start Timer 0
ldr	r1, =#0x4000102
mov	r0, #0xC0
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for Timer 0 IF flag
TIMER0_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x08
cmp	r0, #0x08
beq	IRQ_TEST_1_4_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_4_FAIL

b	TIMER0_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_4_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING
b	IRQ_TEST_1_4_RET

@ Draw PASS
IRQ_TEST_1_4_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING

IRQ_TEST_1_4_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_5 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Stop Timer 1 in case it is already running
ldr	r1, =#0x4000106
mov	r0, #0x00
strh	r0, [r1]

@ Setup Reload Value for Timer 1
ldr	r1, =#0x4000104
strh	r0, [r1]

@ Start Timer 0
ldr	r1, =#0x4000106
mov	r0, #0xC0
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for Timer 1 IF flag
TIMER1_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x10
cmp	r0, #0x10
beq	IRQ_TEST_1_5_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_5_FAIL

b	TIMER1_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_5_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING
b	IRQ_TEST_1_5_RET

@ Draw PASS
IRQ_TEST_1_5_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING

IRQ_TEST_1_5_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_6 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_6:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Stop Timer 2 in case it is already running
ldr	r1, =#0x400010A
mov	r0, #0x00
strh	r0, [r1]

@ Setup Reload Value for Timer 2
ldr	r1, =#0x4000108
strh	r0, [r1]

@ Start Timer 2
ldr	r1, =#0x400010A
mov	r0, #0xC0
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for Timer 2 IF flag
TIMER2_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x20
cmp	r0, #0x20
beq	IRQ_TEST_1_6_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_6_FAIL

b	TIMER2_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_6_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING
b	IRQ_TEST_1_6_RET

@ Draw PASS
IRQ_TEST_1_6_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING

IRQ_TEST_1_6_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_7 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_7:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Stop Timer 3 in case it is already running
ldr	r1, =#0x400010E
mov	r0, #0x00
strh	r0, [r1]

@ Setup Reload Value for Timer 3
ldr	r1, =#0x400010C
strh	r0, [r1]

@ Start Timer 3
ldr	r1, =#0x400010E
mov	r0, #0xC0
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Begin checking for Timer 3 IF flag
TIMER3_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x40
cmp	r0, #0x40
beq	IRQ_TEST_1_7_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_7_FAIL

b	TIMER3_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_7_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x08
bl	PRINT_STRING
b	IRQ_TEST_1_7_RET

@ Draw PASS
IRQ_TEST_1_7_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x08
bl	PRINT_STRING

IRQ_TEST_1_7_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_8 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_8:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DMA0 source
ldr	r1, =#0x40000B0
ldr	r0, =dma_data
str	r0, [r1]

@ Setup DMA0 destination
ldr	r1, =#0x40000B4
ldr	r0, =#0x5000100
str	r0, [r1]

@ Setup DMA0 word count
ldr	r1, =#0x40000B8
mov	r0, #0x02
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Setup DMA0 control
ldr	r1, =#0x40000BA
mov	r0, #0xC400
strh	r0, [r1]

ldr	r1, =#0x4000214

@ Begin checking for DMA0 IF flag
DMA0_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x100
cmp	r0, #0x100
beq	IRQ_TEST_1_8_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_8_FAIL

b	DMA0_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_8_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x09
bl	PRINT_STRING
b	IRQ_TEST_1_8_RET

@ Draw PASS
IRQ_TEST_1_8_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x09
bl	PRINT_STRING

IRQ_TEST_1_8_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_9 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_9:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DMA1 source
ldr	r1, =#0x40000BC
ldr	r0, =dma_data
str	r0, [r1]

@ Setup DMA1 destination
ldr	r1, =#0x40000C0
ldr	r0, =#0x5000100
str	r0, [r1]

@ Setup DMA1 word count
ldr	r1, =#0x40000C4
mov	r0, #0x02
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Setup DMA1 control
ldr	r1, =#0x40000C6
mov	r0, #0xC400
strh	r0, [r1]

ldr	r1, =#0x4000214

@ Begin checking for DMA1 IF flag
DMA1_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x200
cmp	r0, #0x200
beq	IRQ_TEST_1_9_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_9_FAIL

b	DMA1_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_9_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x0A
bl	PRINT_STRING
b	IRQ_TEST_1_9_RET

@ Draw PASS
IRQ_TEST_1_9_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x0A
bl	PRINT_STRING

IRQ_TEST_1_9_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_10 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_10:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DMA2 source
ldr	r1, =#0x40000C8
ldr	r0, =dma_data
str	r0, [r1]

@ Setup DMA2 destination
ldr	r1, =#0x40000CC
ldr	r0, =#0x5000100
str	r0, [r1]

@ Setup DMA2 word count
ldr	r1, =#0x40000D0
mov	r0, #0x02
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Setup DMA2 control
ldr	r1, =#0x40000D2
mov	r0, #0xC400
strh	r0, [r1]

ldr	r1, =#0x4000214

@ Begin checking for DMA2 IF flag
DMA2_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x400
cmp	r0, #0x400
beq	IRQ_TEST_1_10_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_10_FAIL

b	DMA2_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_10_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x0B
bl	PRINT_STRING
b	IRQ_TEST_1_10_RET

@ Draw PASS
IRQ_TEST_1_10_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x0B
bl	PRINT_STRING

IRQ_TEST_1_10_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ IRQ_TEST_1_11 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
IRQ_TEST_1_11:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup R2 as timeout counter
mov	r2, #0x100000

@ Setup DMA3 source
ldr	r1, =#0x40000D4
ldr	r0, =dma_data
str	r0, [r1]

@ Setup DMA3 destination
ldr	r1, =#0x40000D8
ldr	r0, =#0x5000100
str	r0, [r1]

@ Setup DMA3 word count
ldr	r1, =#0x40000DC
mov	r0, #0x02
strh	r0, [r1]

@ Clear IF
ldr	r0, =#0xFFFFFFFF
ldr	r1, =#0x4000214
str	r0, [r1]

@ Setup DMA3 control
ldr	r1, =#0x40000DE
mov	r0, #0xC400
strh	r0, [r1]

ldr	r1, =#0x4000214

@ Begin checking for DMA3 IF flag
DMA3_CHECK_LOOP:
ldr	r0, [r1]
and	r0, #0x800
cmp	r0, #0x800
beq	IRQ_TEST_1_11_PASS

sub	r2, #0x01
cmp	r2, #0x00
beq	IRQ_TEST_1_11_FAIL

b	DMA3_CHECK_LOOP

@ Draw FAIL
IRQ_TEST_1_11_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x0C
bl	PRINT_STRING
b	IRQ_TEST_1_11_RET

@ Draw PASS
IRQ_TEST_1_11_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x0C
bl	PRINT_STRING

IRQ_TEST_1_11_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14