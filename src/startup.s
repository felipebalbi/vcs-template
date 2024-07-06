	.include "atari2600.inc"
	.import main

	;; During STARTUP, we want to clear all the ram to 0 to make sure we're
	;; starting from a known state.
	;;
	;; Technically, we're clearing memory that doesn't exist (locations $00
	;; through $7f are mapped to the TIA, so we're zeroing all its
	;; registers), but that makes the code slightly more compact. We can
	;; save a couple bytes by relying on "illegal" opcodes. For example `lax
	;; #0' would initialize both A and X registers to 0, thus removing the
	;; need for txa instruction.
	.segment "STARTUP"
	.proc reset
        ldx #0			; clear X to 0
        txa			; clear A to 0
clear_stack:
	dex			; X = $ff
        txs			; SP = $ff
        pha			; Push 0 to the stack
        bne clear_stack		; repeat until X is back to 0
	jmp main		; jump to the main routine
	.endproc

	.segment "VECTORS"
	.word reset		; NMI vector
	.word reset		; Reset vector
	.word reset		; Interrupt vector
