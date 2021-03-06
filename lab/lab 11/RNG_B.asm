; valentinno Cruz
; CIS 11
; lab 11


.ORIG X3000

	LD R2, A		; LOAD A INTO R2
	LD R3, M			; LOAD M INTO R3
	JSR DIV			; DIVISION SUBROUTINE 
	ST R4, Q		; STORE VALUE OF R4 INTO Q
	ST R5, R		; STORE VALUE OF R5 INTO R

LOOP	LD R3, X		; LOAD X INTO R3
	LD R2, Q		; LOAD Q INTO R2
	JSR DIV			; (X/Q), DIV SUBROUTINE
	ST R4, XDIVQ		; STORE VALUE IN R4 TO XDIVQ
	ST R5, XMODQ		; STORE VALUE IN R5 TO XMODQ
	LD R1, A		; LOAD A INTO R1
	LD R2, XMODQ		; LOAD XMODQ INTO R2
	JSR MULT		; MULTO. SUBROUTINE
	ADD R4, R3 x0		; R4 = A*(X%Q)
	LD R1, R		; LOAD R INTO R1
	LD R2, XDIVQ		; LOAD XDIVQ INTO R2
	JSR MULT		; R3 = R*(X/Q)
	NOT R3, R3
	ADD R3, R3, #1		; 2'S COMPLIMENT O R3
	ADD R2, R4, R3		; R2 = A*(X%Q)-R(X/Q)
	BRzp SKIP		; IF X >=0 THEN SKIP
	LD R1, M		; LOAD M INTO R1
	ADD R2, R2, R1		; R2 = R2 + R1

;---------------------------------------------------------------

SKIP	ST R2, X		; STORE VALIE IN R2 TO X
				; LOCATION OF START OF EMPTY STACK
	LD R6, BASE		; LOAD BASE INTO R6
	LD R3, X		; LOAD X INTO R3

STACK	AND R2, R2, #0		; CLEAR R2
	ADD R2, R2, #10		; ADD 10 R0 R2
	JSR DIV			; DIVISION SUBROUTINE
	ADD R0, R5, #0		; PUT R5 IN R0
	JSR PUSH		; PUSH SUBROUTINE
	ADD R3, R4, #0		; PUT R4 IN R3
	BRp STACK		; IF POS GO TO STACK, ELSE CONTINUE

UNSTACK	JSR ISEMPTY		; ISEMPTY SUBROUTINE
	BRp CONT		; IF POS GO TO CONT, ELSE KEEP GOING
	JSR POP			; POP SUBROUTINE
	JSR DECODE		; DECODE SUBROUTINE
	OUT
	BR UNSTACK		; UNCONDITIONAL BRANCH

CONT
	LD R0, SPACE		; LOAD SPACE INTO R0
	OUT
	LD R6, LC		; LOAD LC INTO R6
	ADD R6, R6, #-1
	ST R6, LC
	BRzp LOOP		; LOOP UNTIL NEG
	HALT


SPACE	.FILL #10
X	.FILL #100
A	.FILL #7
M	.FILL #32767
Q	.FILL #0
R	.FILL #0
XDIVQ	.FILL #0
XMODQ	.FILL #0
BASE	.FILL x4000
LC	.FILL #20		; LOOP COUNTER (GENERATE 20 #'S)



MULT 	AND R3, R3, #0		; CLEAR R3


MLOOP	ADD R3, R3, R1
	ADD R2, R2, #-1
	BRp MLOOP		; REPEAST UNTIL NEG OR ZERO
	RET


DIV	ST R2, SAVE1		; SAVE REGISTER
	ST R3, SAVE2		; SAVE REGISTERS
	AND R4, R4, x0		; CLEAR R4
	NOT R2, R2		; 2'S COMPLIMENT OF R6
	ADD R2, R2, #1


DLOOP	AND R5, R5, x0		; CLEAR R5
	ADD R4, R4, #1		; ADD 1 TO R4
	ADD R5, R3, x0		; COPY R3 INTO R5
	ADD R3, R3, R2		; ADD R2 AND R3
	BRzp DLOOP		; CHECK FOR ZERO OR POS
	ADD R4, R4, #-1		; INCRIMENT DOWN FOR LOOP
	RET



SAVE1	.FILL x0
SAVE2	.FILL x0



PUSH	ADD R6, R6, #-1
	STR R0, R6, #0
	RET

POP	LDR R0, R6, #0		; LOAD R6 TO ZERO
	ADD R6, R6, #1		; LOAD 1 TO R6
	RET


ISEMPTY	LD R0, EMPTY
	ADD R0, R6, R0
	BRz IS
	ADD R0, R0, #0
	RET

IS	AND R0, R0, #0
	ADD R6, R6, #1
	RET


EMPTY	.FILL xC000


DECODE	ADD R0, R0, #15		; ASCII CONVERSION
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3
	RET

.END


