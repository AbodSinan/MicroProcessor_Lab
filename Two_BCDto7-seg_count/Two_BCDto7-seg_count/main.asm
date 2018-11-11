
/*in this portion two ports will be used for simplicity, PORTB is for the LSD (first display) and PORTD is for the 2nd display*/ 
start:
    LDI r16, 0xFF
	//set the pins of both ports to OUTPUT
	OUT DDRB, r16
	OUT DDRD, r16
	LDI r17, 0
	loop2:// this loop will be incremented by one every 10 cycles till it reaches 9
	LDI r16,0
	loop1://this loop will make the first display go from 1-9

	INC r16
	OUT PORTB, r16 //output the value to PORTB
	JMP DELAY_ONE_SEC // a one second delay after outputting the value
	CPI r16, 9
	BRNE loop1

	INC r17
	OUT PORTD, r17 //output the value to PORTD
	CPI r17,9
	BRNE loop2

    rjmp start

	DELAY_ONE_SEC: //a standard one second delay (64*200*250*5*250ns = 1ms)			

	push r18
	push r19
	push r20

	ldi r16,64

	L0:	ldi r17,200	
	L1: ldi r18,250	
	L2:	nop
		nop
		dec r18
		brne L2

		dec r17
		brne L1

		dec r16
		brne L0

	pop r18
	pop r19
	pop r20
	
	ret