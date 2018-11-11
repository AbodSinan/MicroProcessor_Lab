/* this program involves the usage of a BCD to 7-segment encoder*/
start:
    LDI r16, 0xff //set all pins to OUTPUT
	OUT DDRB, r16
	LDI r16, 0b00000100 //output number 4 to port b (duh)
	OUT PORTB, r16
    rjmp start
