
start:
/*simple program that consists of simply outputting the number 4 into a 7-seg display*/
    LDI r16, 0xFF
	OUT DDRB, r16
	// The connections are as follows: a>PB0, b>PB1, c>PB2, d>PB3, f>PB4, g>PB5 
	LDI r16, 0b0101110 //b,c,g, and f are ON to get the number 4
	OUT PORTB, r16
    rjmp start
