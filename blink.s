start:
.global main

main: 
    ; initialization
    ldi r20, 0          ; Initial port state
    ldi r21, 0b10000000 ; Set PB7 as output
    out 0x04, r21       ; set DDRB7
    ldi r22, 0b10000000 ; used for inversion via eor

    ; 0x1E8480 = 2.000.000
	ldi r16, 0x80
    ldi r17, 0x84
    ldi r18, 0x1e

    main_loop:
        ; if (r24 == r16) && (r25 == r17) && (r26 == r18)
        cpse r24, r16
        rjmp endif
        cpse r25, r17
        rjmp endif
        cpse r26, r18
        rjmp endif
        rjmp endloop

        endif:

        ; r26:r25:r24++
		adiw r24, 1
		cpse r24, r16
		rjmp main_loop
		cpse r25, r16
		rjmp main_loop
        inc r26
        cpse r26, r16
        rjmp main_loop
		
        endloop:
        eor r20, r22 ; invert port state
        out 0x05, r20
	
	; reset
	ldi r24, 0
	ldi r25, 0
    ldi r26, 0
    rjmp main_loop
