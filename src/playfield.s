	.include "atari2600.inc"
	.export playfield_init
	.export playfield_update

	.segment "CODE"
	.proc playfield_init
	lda #0
	sta PATTERN		; the binary playfield pattern

	lda #$45
	sta COLUPF		; set the playfield color

	rts
	.endproc

	.segment "CODE"
	.proc playfield_update
	ldy CURRENT_TIME	; speed counter
	iny			; increment speed count by one
	cpy #TIME_TO_CHANGE	; has it reached our "change point"?
	bne notyet		; no, so branch past

	ldy #0			; reset speed count
	inc PATTERN		; switch to next pattern

notyet:
	lda PATTERN		; use our saved pattern
	sta PF1			; as the playfield shape
	sty CURRENT_TIME
	rts
	.endproc
