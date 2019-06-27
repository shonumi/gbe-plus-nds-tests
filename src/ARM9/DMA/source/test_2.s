@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2019
@ Licensed under the GPLv2 or newer
@
@ File : test_2.s
@ Date : June 25th, 2019
@ Description : Low-level NDS9 DMA test
@
@ Tests various aspects of the NDS' ARM9 DMA channels

@@@@@@@@@@@@@@@@
@ DMA_TEST_2_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
DMA_TEST_2_1:

@ Test DMA Type 0 - Immediate Fill

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup DMA filldata
ldr	r1, =#0x40000E0
ldr	r0, =#0xFEEDFACE
str	r0, [r1]

@ Clear data at destination address
ldr 	r1, =#0x2200000
mov	r0, #0x00
str	r0, [r1]
str	r0, [r1, #0x04]
str	r0, [r1, #0x08]
str	r0, [r1, #0x0C]

@ Setup DMA0 for immediate fill transfer
ldr	r1, =#0x40000B0
ldr	r0, =#0x40000E0
str	r0, [r1]

ldr 	r0, =#0x2200000
str	r0, [r1, #0x04]

mov	r0, #0x04
strh	r0, [r1, #0x08]

ldr	r0, =#0x8500
strh	r0, [r1, #0x0A]

@ Wait until Bit 15 of DMA_CNT is clear
DMA_2_1_CNT_LOOP:
ldrh	r0, [r1, #0x0A]
and	r0, #0x8000
cmp	r0, #0x00
bne	DMA_2_1_CNT_LOOP

@ Verify data at destination address
ldr 	r1, =#0x2200000
ldr	r0, [r1]
ldr	r2, =#0xFEEDFACE
cmp	r0, r2
bne	DMA_TEST_2_1_FAIL

ldr	r0, [r1, #0x04]
cmp	r0, r2
bne	DMA_TEST_2_1_FAIL

ldr	r0, [r1, #0x08]
cmp	r0, r2
bne	DMA_TEST_2_1_FAIL

ldr	r0, [r1, #0x0C]
cmp	r0, r2
beq	DMA_TEST_2_1_PASS

@ Draw FAIL
DMA_TEST_2_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	DMA_TEST_2_1_RET

@ Draw PASS
DMA_TEST_2_1_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

DMA_TEST_2_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14 


@@@@@@@@@@@@@@@@
@ DMA_TEST_2_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
DMA_TEST_2_2:

@ Test DMA 1 Immediate Fill

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup DMA filldata
ldr	r1, =#0x40000E4
ldr	r0, =#0xBEEF1234
str	r0, [r1]

@ Clear data at destination address
ldr 	r1, =#0x2200000
mov	r0, #0x00
str	r0, [r1]
str	r0, [r1, #0x04]
str	r0, [r1, #0x08]
str	r0, [r1, #0x0C]

@ Setup DMA0 for immediate fill transfer
ldr	r1, =#0x40000BC
ldr	r0, =#0x40000E4
str	r0, [r1]

ldr 	r0, =#0x2200000
str	r0, [r1, #0x04]

mov	r0, #0x04
strh	r0, [r1, #0x08]

ldr	r0, =#0x8500
strh	r0, [r1, #0x0A]

@ Wait until Bit 15 of DMA_CNT is clear
DMA_2_2_CNT_LOOP:
ldrh	r0, [r1, #0x0A]
and	r0, #0x8000
cmp	r0, #0x00
bne	DMA_2_2_CNT_LOOP

@ Verify data at destination address
ldr 	r1, =#0x2200000
ldr	r0, [r1]
ldr	r2, =#0xBEEF1234
cmp	r0, r2
bne	DMA_TEST_2_2_FAIL

ldr	r0, [r1, #0x04]
cmp	r0, r2
bne	DMA_TEST_2_2_FAIL

ldr	r0, [r1, #0x08]
cmp	r0, r2
bne	DMA_TEST_2_2_FAIL

ldr	r0, [r1, #0x0C]
cmp	r0, r2
beq	DMA_TEST_2_2_PASS

@ Draw FAIL
DMA_TEST_2_2_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	DMA_TEST_2_2_RET

@ Draw PASS
DMA_TEST_2_2_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING

DMA_TEST_2_2_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14 

@@@@@@@@@@@@@@@@
@ DMA_TEST_2_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
DMA_TEST_2_3:

@ Test DMA 1 Immediate Fill

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup DMA filldata
ldr	r1, =#0x40000E8
ldr	r0, =#0x1234FFFF
str	r0, [r1]

@ Clear data at destination address
ldr 	r1, =#0x2200000
mov	r0, #0x00
str	r0, [r1]
str	r0, [r1, #0x04]
str	r0, [r1, #0x08]
str	r0, [r1, #0x0C]

@ Setup DMA0 for immediate fill transfer
ldr	r1, =#0x40000C8
ldr	r0, =#0x40000E8
str	r0, [r1]

ldr 	r0, =#0x2200000
str	r0, [r1, #0x04]

mov	r0, #0x04
strh	r0, [r1, #0x08]

ldr	r0, =#0x8500
strh	r0, [r1, #0x0A]

@ Wait until Bit 15 of DMA_CNT is clear
DMA_2_3_CNT_LOOP:
ldrh	r0, [r1, #0x0A]
and	r0, #0x8000
cmp	r0, #0x00
bne	DMA_2_3_CNT_LOOP

@ Verify data at destination address
ldr 	r1, =#0x2200000
ldr	r0, [r1]
ldr	r2, =#0x1234FFFF
cmp	r0, r2
bne	DMA_TEST_2_3_FAIL

ldr	r0, [r1, #0x04]
cmp	r0, r2
bne	DMA_TEST_2_3_FAIL

ldr	r0, [r1, #0x08]
cmp	r0, r2
bne	DMA_TEST_2_3_FAIL

ldr	r0, [r1, #0x0C]
cmp	r0, r2
beq	DMA_TEST_2_3_PASS

@ Draw FAIL
DMA_TEST_2_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	DMA_TEST_2_3_RET

@ Draw PASS
DMA_TEST_2_3_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

DMA_TEST_2_3_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14 


@@@@@@@@@@@@@@@@
@ DMA_TEST_2_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
DMA_TEST_2_4:

@ Test DMA 3 Immediate Fill

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Setup DMA filldata
ldr	r1, =#0x40000EC
ldr	r0, =#0x27272727
str	r0, [r1]

@ Clear data at destination address
ldr 	r1, =#0x2200000
mov	r0, #0x00
str	r0, [r1]
str	r0, [r1, #0x04]
str	r0, [r1, #0x08]
str	r0, [r1, #0x0C]

@ Setup DMA0 for immediate fill transfer
ldr	r1, =#0x40000D4
ldr	r0, =#0x40000EC
str	r0, [r1]

ldr 	r0, =#0x2200000
str	r0, [r1, #0x04]

mov	r0, #0x04
strh	r0, [r1, #0x08]

ldr	r0, =#0x8500
strh	r0, [r1, #0x0A]

@ Wait until Bit 15 of DMA_CNT is clear
DMA_2_4_CNT_LOOP:
ldrh	r0, [r1, #0x0A]
and	r0, #0x8000
cmp	r0, #0x00
bne	DMA_2_4_CNT_LOOP

@ Verify data at destination address
ldr 	r1, =#0x2200000
ldr	r0, [r1]
ldr	r2, =#0x27272727
cmp	r0, r2
bne	DMA_TEST_2_4_FAIL

ldr	r0, [r1, #0x04]
cmp	r0, r2
bne	DMA_TEST_2_4_FAIL

ldr	r0, [r1, #0x08]
cmp	r0, r2
bne	DMA_TEST_2_4_FAIL

ldr	r0, [r1, #0x0C]
cmp	r0, r2
beq	DMA_TEST_2_4_PASS

@ Draw FAIL
DMA_TEST_2_4_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING
b	DMA_TEST_2_4_RET

@ Draw PASS
DMA_TEST_2_4_PASS:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING

DMA_TEST_2_4_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14 
