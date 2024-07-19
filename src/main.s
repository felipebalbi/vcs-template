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

	;; 80 scanlines of wall
	lda #$10
	sta PF0

	lda #0
	sta PF1
	sta PF2

middletoplines:
	sta WSYNC
	inx			; 2 2
	cpx #88			; 2 4
	bne middletoplines	; 2 6

	;; 16 scanlines for fun with asymetric playfield
middlelines:
	lda #$45		; 2 8
	sta COLUPF		; 3 11

	lda #$10		; 2 13
	sta PF0			; 3 16

	lda #$00		; 2 18
	sta PF1			; 3 21

	lda #$00		; 2 23
	sta PF2			; 3 26

	nop			; 2 28
	nop			; 2 30

	;; Now I can modify PF0
	lda #$50		; 2 32
	sta PF0			; 3 35

	nop			; 2 37
	nop			; 2 39
	nop			; 2 41

	;; Now I can modify PF1
	lda #$aa		; 2 43
	sta PF1			; 3 36

	nop			; 2 49

	;; Now I can modify PF2
	lda #$55		; 2 51
	sta PF2			; 3 54

	sta WSYNC
	inx
	cpx #104
	bne middlelines

	;; 80 more scanlines of full playfield
	lda #$10
	sta PF0

	lda #0
	sta PF1
	sta PF2

middlebottomlines:
	sta WSYNC
	inx
	cpx #184
	bne middlebottomlines

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
