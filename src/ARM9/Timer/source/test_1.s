@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2019
@ Licensed under the GPLv2 or newer
@
@ File : test_1.s
@ Date : February 26th, 2019
@ Description : Timer test
@
@ Tests NDS9 hardware timers 

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame, then grab result
mov	r0, #0x1
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 1Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x80
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, then grab result
ldr	r0, =0x5
bl	WAIT_FRAMES

@ Stop timer
mov	r0, #0x00
strh	r0, [r1]

ldr	r1, =#0x4000100
ldrh	r0, [r1]	

@ Print results to screen
mov	r1, #0x17
mov	r2, #0x02
bl 	PRINT_VALUE

TIMER_TEST_1_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame, then grab result
mov	r0, #0x1
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 64Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x81
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, then grab result
mov	r0, #0x5
bl	WAIT_FRAMES

@ Stop timer
mov	r0, #0x00
strh	r0, [r1]

ldr	r1, =#0x4000100
ldrh	r0, [r1]	

@ Print results to screen
mov	r1, #0x17
mov	r2, #0x03
bl 	PRINT_VALUE

TIMER_TEST_1_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame, then grab result
mov	r0, #0x1
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 256Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x82
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, then grab result
mov	r0, #0x5
bl	WAIT_FRAMES

@ Stop timer
mov	r0, #0x00
strh	r0, [r1]

ldr	r1, =#0x4000100
ldrh	r0, [r1]	

@ Print results to screen
mov	r1, #0x17
mov	r2, #0x04
bl 	PRINT_VALUE

TIMER_TEST_1_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame, then grab result
mov	r0, #0x1
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 1024Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x83
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, then grab result
mov	r0, #0x5
bl	WAIT_FRAMES

@ Stop timer
mov	r0, #0x00
strh	r0, [r1]

ldr	r1, =#0x4000100
ldrh	r0, [r1]	

@ Print results to screen
mov	r1, #0x17
mov	r2, #0x05
bl 	PRINT_VALUE

TIMER_TEST_1_4_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_5 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame, then grab result
mov	r0, #0x1
bl	WAIT_FRAMES

@ Stop timers 1 and 2 if either are already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]
strh	r0, [r1, #0x4]

@ Set all timer reload values to 0x0
ldr	r1, =#0x4000100
mov	r0, #0x00
strh	r0, [r1]
strh	r0, [r1, #0x4]

@ Set up timers 1 for count-up mode
mov	r0, #0x84
ldr	r1, =#0x4000106
strh	r0, [r1]

@ Setup r3 as address of timer 1 counter
ldr	r3, =#0x4000104

@ Setup timer 0 - Prescalar 0
mov	r0, #0x80
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Use R1 as a counter.
mov	r1, #0x00

@ Wait until Timer 1 counter equals 2 OR counter exceeds 0x20000
TIMER_LOOP:
add	r1, #0x1
cmp	r1, #0x20000
beq	TIMER_TEST_1_5_FAIL

ldrh	r0, [r3]
cmp	r0, #0x02
bne	TIMER_LOOP
beq	TIMER_TEST_1_5_PASS

@ Draw FAIL
TIMER_TEST_1_5_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING
b	TIMER_TEST_1_5_RET

@ Draw PASS
TIMER_TEST_1_5_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING

TIMER_TEST_1_5_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_6 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_6:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame
mov	r0, #0x01
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 1Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x80
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, stop timer, then grab result
ldr	r0, =0x5
bl	WAIT_FRAMES

mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

ldr	r1, =#0x4000100
ldr	r3, [r1]
mov	r0, #0x100

DELAY_LOOP:
sub	r0, #0x01
cmp	r0, #0x00
bne	DELAY_LOOP

@ Compare result from before. They should be the same if the timer is stopped.
ldr	r0, [r1]
cmp	r0, r3
beq	TIMER_TEST_1_6_PASS

@ Draw FAIL
TIMER_TEST_1_6_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING
b	TIMER_TEST_1_6_RET

@ Draw PASS
TIMER_TEST_1_6_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x07
bl	PRINT_STRING

TIMER_TEST_1_6_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ TIMER_TEST_1_7 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
TIMER_TEST_1_7:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Wait 1 frame
mov	r0, #0x01
bl	WAIT_FRAMES

@ Stop timer if already started
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Tests Timer 0 - Prescalar 1 : 1Hz
@ Setup TM0CNT_LO
mov	r0, #0x00
ldr	r1, =#0x4000100
strh	r0, [r1]

@ Setup TMOCNT_HI - Start timer
mov	r0, #0x80
ldr	r1, =#0x4000102
strh	r0, [r1]

@ Wait 5 frames, stop timer, then grab result
ldr	r0, =0x5
bl	WAIT_FRAMES

mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

ldr	r1, =#0x4000100
ldr	r3, [r1]

@ Write to recount value. Read it immediately. The timer's count value should not have changed until the timer starts again.
mov	r0, #0x00
ldr	r1, =#0x4000102
strh	r0, [r1]

ldr	r1, =#0x4000100
strh	r0, [r1]
ldrh	r0, [r1]
cmp	r0, #0x00
bne	TIMER_TEST_1_7_PASS

@ Draw FAIL
TIMER_TEST_1_7_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x08
bl	PRINT_STRING
b	TIMER_TEST_1_7_RET

@ Draw PASS
TIMER_TEST_1_7_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x08
bl	PRINT_STRING

TIMER_TEST_1_7_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14