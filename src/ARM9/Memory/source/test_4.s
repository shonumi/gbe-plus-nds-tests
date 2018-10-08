@ GBE+ NDS Hardware Suite Copyright Daniel Baxter 2018
@ Licensed under the GPLv2 or newer
@
@ File : test_4.s
@ Date : September 9th, 2018
@ Description : Memory Test 4
@
@ Tests memory mirroring for various addresses

@@@@@@@@@@@@@@@@
@ MEM_TEST_4_1 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_4_1:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ WRAM Mirror check. Should be broken into 4MB sections on real retail hardware
@ Reading from 0x23FFC80, 27FFC80, 2BFFC80, and 2FFFC80 should all read 0x5
@ This value is part of firmware settings and should read 0x5

ldr	r0, =0x23FFC80
ldrb	r1, [r0]
cmp	r1, #0x5
bne	MEM_TEST_4_1_FAIL

ldr	r0, =0x27FFC80
ldrb	r1, [r0]
cmp	r1, #0x5
bne	MEM_TEST_4_1_FAIL

ldr	r0, =0x2BFFC80
ldrb	r1, [r0]
cmp	r1, #0x5
bne	MEM_TEST_4_1_FAIL

ldr	r0, =0x2FFFC80
ldrb	r1, [r0]
cmp	r1, #0x5
bne	MEM_TEST_4_1_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING
b	MEM_TEST_4_1_RET

@ Draw FAIL
MEM_TEST_4_1_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x02
bl	PRINT_STRING

MEM_TEST_4_1_RET:
ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14

@@@@@@@@@@@@@@@@
@ MEM_TEST_4_2 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_4_2:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ First portion tests shared WRAM when the ARM9 has all 32KB of WRAM. The 32KB should be mirrored across the entire 16MB section (0x3000000 - 0x3FFFFFF).
@ Tested here are 0x3000000, 0x3008000, 0x3FF0000, and 0x3FF8000
@ Will test for abritrary value written and read back: 0xC5

@ Setup Shared WRAM - ARM = 32K, save byte at 0x3000000
mov	r0, #0x00
ldr 	r1, =0x4000247
strb	r0, [r1]

ldr	r1, =0x3000000
mov	r2, #0xC5
ldrb	r3, [r1]
strb	r2, [r1]

ldr	r0, =0x3000000
ldrb	r1, [r0]
cmp	r1, #0xC5
mov	r0, #0x00
bne	MEM_TEST_4_2_FAIL

ldr	r0, =0x3008000
ldrb	r1, [r0]
cmp	r1, #0xC5
mov	r0, #0x01
bne	MEM_TEST_4_2_FAIL

ldr	r0, =0x3FF0000
ldrb	r1, [r0]
cmp	r1, #0xC5
mov	r0, #0x02
bne	MEM_TEST_4_2_FAIL

ldr	r0, =0x3FF8000
ldrb	r1, [r0]
cmp	r1, #0xC5
mov	r0, #0x03
bne	MEM_TEST_4_2_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x03
bl	PRINT_STRING
b	MEM_TEST_4_2_RET

@ Draw FAIL
MEM_TEST_4_2_FAIL:
stmfd	r13!, {r0}
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1A
mov	r2, #0x03
bl	PRINT_STRING

ldmfd	r13!, {r0}
cmp	r0, #0x00
ldreq	r0, =fail_code_1_str
cmp	r0, #0x01
ldreq	r0, =fail_code_2_str
cmp	r0, #0x02
ldreq	r0, =fail_code_3_str
cmp	r0, #0x03
ldreq	r0, =fail_code_4_str

mov	r1, #0x1F
mov	r2, #0x03
bl	PRINT_STRING

MEM_TEST_4_2_RET:
ldr	r1, =0x3000000
strb	r3, [r1]

ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MEM_TEST_4_3 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_4_3:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests Palette RAM mirroring. Palette RAM is supposed to be mirrored every 32KB. Values tested here are 0x5000008, 0x50008008, 0x5FF0008, and 0x5FF8008
@ Will test for abritrary value written and read back: 0xC0DE

ldr	r1, =0x5000008
ldr	r2, =0xC0DE
ldrh	r3, [r1]
strh	r2, [r1]

ldr	r0, =0x5000008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_3_FAIL

ldr	r0, =0x5008008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_3_FAIL

ldr	r0, =0x5FF0008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_3_FAIL

ldr	r0, =0x5FF8008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_3_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING
b	MEM_TEST_4_3_RET

@ Draw FAIL
MEM_TEST_4_3_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x04
bl	PRINT_STRING

MEM_TEST_4_3_RET:
ldr	r1, =0x5000008
strh	r3, [r1]

ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MEM_TEST_4_4 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_4_4:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests OAM mirroring. OAM is supposed to be mirrored every 32KB. Values tested here are 0x7000008, 0x70008008, 0x7FF0008, and 0x7FF8008
@ Will test for abritrary value written and read back: 0xC0DE

ldr	r1, =0x7000008
ldr	r2, =0xC0DE
ldrh	r3, [r1]
strh	r2, [r1]

ldr	r0, =0x7000008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_4_FAIL

ldr	r0, =0x7008008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_4_FAIL

ldr	r0, =0x7FF0008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_4_FAIL

ldr	r0, =0x7FF8008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_4_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING
b	MEM_TEST_4_4_RET

@ Draw FAIL
MEM_TEST_4_4_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x05
bl	PRINT_STRING

MEM_TEST_4_4_RET:
ldr	r1, =0x7000008
strh	r3, [r1]

ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14


@@@@@@@@@@@@@@@@
@ MEM_TEST_4_5 @
@@@@@@@@@@@@@@@@
@ No parameters
@@@@@@@@@@@@@@@@
MEM_TEST_4_5:

stmfd	r13!, {r0, r1, r2, r3, r14}

@ Tests ITCM mirroring. ITCM is supposed to be mirrored every 32KB. Values tested here are 0x0000008, 0x00008008, 0x0FF0008, and 0x0FF8008
@ Will test for abritrary value written and read back: 0xC0DE

ldr	r1, =0x0000008
ldr	r2, =0xC0DE
ldrh	r3, [r1]
strh	r2, [r1]

ldr	r0, =0x0000008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_5_FAIL

ldr	r0, =0x0008008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_5_FAIL

ldr	r0, =0x0FF0008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_5_FAIL

ldr	r0, =0x0FF8008
ldrh	r1, [r0]
cmp	r1, r2
bne	MEM_TEST_4_5_FAIL

@ Draw PASS
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =pass_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING
b	MEM_TEST_4_5_RET

@ Draw FAIL
MEM_TEST_4_5_FAIL:
ldr	r0, =0x1
bl	WAIT_FRAMES

ldr	r0, =fail_str
mov	r1, #0x1C
mov	r2, #0x06
bl	PRINT_STRING

MEM_TEST_4_5_RET:
ldr	r1, =0x0000008
strh	r3, [r1]

ldmfd	r13!, {r0, r1, r2, r3, r14}
mov	r15, r14
