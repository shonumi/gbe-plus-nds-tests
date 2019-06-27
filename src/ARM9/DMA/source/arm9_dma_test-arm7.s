@ ARM7 is inactive during this test

.text
.global arm7_main

arm7_main:
@Disable IRQs
ldr	r7, =0xDEADC0DE
mov	r0, #0x00
ldr 	r1, =0x4000208
str	r0, [r1]

add	r1, #0x08
str	r0, [r1]

add	r1, #0x04
str	r0, [r1]

loopy_loop:
b 	loopy_loop


.end
