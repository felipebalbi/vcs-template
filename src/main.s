	.include "atari2600.inc"
	.export main
	.import playfield_init

	;; The actual game code starts here. This is where we would setup an
	;; intro screen, play sound and check for user input.
	;;
	;; A full screen is composed of 262 scanlines, subdivided into 3
	;; vertical syncs, 37 vertical blanks, 192 visible scanlines, and 30
	;; overscan lines.
	.segment "CODE"
	.proc main

	;; Initialize playfield
	jsr playfield_init

	;; Start a new frame by turning on vblank and vsync
next_frame:
	lda #$00
	sta VBLANK		; disable Vertical Blank

	lda #$02
	sta VSYNC		; enable Vertical Sync

	wsync #3		; 3 scanlines of VSYNC signal

	lda #$00
	sta VSYNC		; disable Vertical Sync

	wsync #37		; 37 scanlines of Vertical Blank

	;; Draw 192 visible scanlines
	ldx #0

	;; 8 scanlines of full playfield
	lda #$ff
	sta PF0
	sta PF1
	sta PF2

top8lines:
	sta WSYNC
	inx
	cpx #8
	bne top8lines

	;; 176 scanlines of wall
	lda #$10
	sta PF0

	lda #0
	sta PF1
	sta PF2

middlelines:
	sta WSYNC
	inx
	cpx #184
	bne middlelines

	;; 8 more scanlines of full playfield
	lda #$ff
	sta PF0
	sta PF1
	sta PF2

bottom8lines:
	sta WSYNC
	inx
	cpx #192
	bne bottom8lines

	lda #$42		; Enable I4/I5 latches; Enter Vertical Blank
	sta VBLANK

	wsync #30

	jmp next_frame
	.endproc
