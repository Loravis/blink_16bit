start:
.global main

main: 
    ; initialization
    ldi r20, 0          ; Initial port state
    ldi r21, 0b10000000 ; Set PB7 as output
    out 0x04, r21       ; set DDRB7
    ldi r22, 0b10000000 ; used for inversion via eor
	ldi r16, 0xFF 		; for comparisons

    main_loop:
		adiw r24, 1
		cpse r24, r16
		rjmp main_loop
		cpse r25, r16
		rjmp main_loop
		
        eor r20, r22 ; invert port state
        out 0x05, r20
	
	; reset
	ldi r24, 0
	ldi r25, 0
    rjmp main_loop
