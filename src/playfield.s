	.include "atari2600.inc"
	.export playfield_init

	.segment "CODE"
	.proc playfield_init
	lda #$45
	sta COLUPF		; set the playfield color

	lda #1
	sta CTRLPF		; enable playfield reflection

	rts
	.endproc
