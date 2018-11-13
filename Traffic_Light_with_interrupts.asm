;
; MP Project.asm
;
; Created: 24/11/2017 22:18:10
;
.INCLUDE "M32DEF.INC"
.ORG 0
	JMP MAIN
.ORG 0x02
	JMP EX0_ISR
.ORG 0x04
	JMP EX1_ISR
MAIN: 
	  LDI R24, 0b11000000; enable external interrupts INT0 and INT1
	  OUT GICR, R20; set global interrupt control register to the value in R24
	  SEI; enable interrupts
	 
	  LDI R21, 0x44; both lights are red
	  LDI R22, 0x11; both lights are green
	  LDI R23, 0x41; the light to the left is off, the one on the right is ON
	  ; PORTA outputs to the traffic light controlling the cars coming from the LEFT junction
	  ; PORTB outputs to the traffic light controlling the cars coming from the BOTTOM junction
	  ; PORTC outputs to the traffic light controlling the cars coming from the RIGHT junction
	  OUT PORTA, R21;
	  OUT PORTB, R22; 
	  OUT PORTC, R23;
	  CALL RED; call subroutine RED to create a 15s delay
	  LDI R21, 0x44; both lights are red
	  LDI R22, 0x22; both lights are yellow
	  LDI R23, 0x42; the light on the left is red, the one on the right is yellow
	  OUT PORTA,R21
	  OUT PORTB,R22;
	  OUT PORTC,R23; 
	  CALL YELLOW;
	  LDI R21, 0x11; both lights are green
	  LDI R22, 0x41; the light on the left is red, the one on the right is green
	  LDI R23, 0x44; both lights are red
	  OUT PORTA,R21
	  OUT PORTB,R22;
	  OUT PORTC,R23; 
	  CALL GREEN; call GREEN subroutine that creates a 15s delay
	  LDI R21, 0x22; both lights are yellow
	  LDI R22, 0x42; the light on the left is red, the one on the right is yellow
	  LDI R23, 0x44; both lights are red
	  OUT PORTA,R21
	  OUT PORTB,R22;
	  OUT PORTC,R23; 
	  CALL YELLOW; calls the YELLOW subroutine that creates a 2s delay
	  JMP MAIN; go back to top
RED:
	LDI R19, 15
	L5:
		CALL ONE_SECOND; Call the subroutine ONE_SECOND 15 times to create a 15 sec delay
		DEC R19;
		BRNE L5; return to L5 if Z flag is 1 (R19 reaches zero)
	RET
GREEN:
	LDI R19, 15
	L6:
		CALL ONE_SECOND; Call the subroutine ONE_SECOND 15 times to create a 15 sec delay
		DEC R19;
		BRNE L6;
	RET

YELLOW: 
	LDI R19, 2
	L4:
		CALL ONE_SECOND; call the subroutine ONE_SECOND 2 times to create a 2 sec delay
		DEC R19
		BRNE L4
	RET

ONE_SECOND:	;need to create 16000000 cycles for a 1sec delay
	; we can see that 128*125*250*4= 16,000,000 cycles
	LDI R16, 128
	L1: ;1+1+2=4 cycles per loop
		LDI R17, 125;1 cycle
	L2: ;1+1+2=4 cycles per loop
		LDI R18, 250; 1 cycle
	L3: ;1+1+2=4 cycles per loop
		DEC R18 ;1 cycle
		NOP; 1 cycle
		BRNE L3; 2 cycles
	
		DEC R17 ; 1 cycle
		BRNE L2; 2 cycles

		DEC R16; 1 cycle
		BRNE L1; 2 cycles
	RET

EX0_ISR: ; if the zebra crossing on the bottom junction is used
	  LDI R21, 0x14; only the forward signal is green, others have to wait for pedestrians
	  LDI R22, 0x44; cars must stop and wait for pedestrians to cross
	  LDI R23, 0x41; only the forward signal is green, others have to wait for pedestrians
	  OUT PORTA,R21
	  OUT PORTB,R22;
	  OUT PORTC,R23; 
	  CALL RED; call subroutine RED for a 15s delay
	  RETI

EX1_ISR: ; if the zebra crossing on the right junction is used
	  LDI R21, 0x41; only the turn right signal is green, others have to wait for pedestrians
	  LDI R22, 0x44; only the turn left signal is green, others have to wait for pedestrians
	  LDI R23, 0x41; cars must stop and wait for pedestrians to cross
	  OUT PORTA,R21
	  OUT PORTB,R22;
	  OUT PORTC,R23; 
	  CALL RED; call subroutine RED for a 15s delay
	  RETI
	
	

		 