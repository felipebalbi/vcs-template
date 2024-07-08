; Atari 2600 TIA & RIOT read / write registers
;
; Florent Flament (contact@florentflament.com), 2017

.ifndef __ATARI2600_INC__
__ATARI2600_INC__ = 1

; TIA & RIOT registers mapping
.include "atari2600_tia.inc"
.include "atari2600_riot.inc"
.include "macros.inc"
.include "variables.inc"

.endif				; __ATARI2600_INC__
