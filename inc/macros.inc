.ifndef __MACROS_INC__
__MACROS_INC__ = 1

.macro wsync amt
.local loop
	ldx amt
loop:
	sta WSYNC
	dex
	bne loop
	.endmacro

.endif				; __MACROS_INC__
