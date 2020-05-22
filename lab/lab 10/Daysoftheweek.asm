; Valentinno Cruz
; Lab #10
; input-	
;	x31F0 The usual number of the month
;	x31F1 The day of the month
;	x31F2 The year



.ORIG x3000
JSR MONTH		; SUBROUTINE TO GET M
STI R4, M		; STORES VALUE R4 TO M
JSR MULT		; MULTIPL. SUBROUTINE
STI R3, NEWM		; STORE VALUE IN R3 TO "NEWM"
JSR DIV1		; DIVISION SUBROUTINE
STI R5, QUOTOFM		; QUOTIENT IF "NEWM"
STI R3, R		; REMAINDER
JSR DIV2		; DIVISION SUBROUTINE
STI R5, QUOTOFD		; QUOTIENT OF D, FIRST 2 #S OF YEARS
STI R3, R		; REMAINDER
JSR DIV3		; DIVISION SUBROUTINE
STI R5, QUOTOFC		; QUORIENT OF C, CENTURT, LAST 2 #S OF THE YEAR
STI R3, R		; REMAINDER
JSR ZELLERS		; SUBROUTINE OF getf
STI R6, F		; stores value in R6 to F

JSR MODULEF		; SUBROUTINE TO GET THE MODULE F%7
STI R5, MODF		; STORES VALUE IN R5 TO MODF
STI R3, R		; STORES VALUE IN R4 TO R
LDI R0, R		; LOADS VALUE OF R INTO R0
AND R3, R3, #0		; CLEAR R3
ADD R3, R0, x0		; COPY R0 INTO R3
AND R4, R4, #0		; CLEAR R4
ADD R4, R3, #-6		; SUBTRACT 6 TO GET NUMBER OF DAY OF THE WEEK

BRp INVALID		; IF POSITIVE GO TO LAVEL INVALID
LEA R0, DAYS		; LOADS DAYS INTO R0
ADD R3, R3, x0		; CHECK CONDITION

DLOOP			; DLOOP
BRz DISPLAY		; OF ZERO , GO TO DISPLAY
ADD R0, R0, #10		;
ADD R3, R3, #-1		;
BR DLOOP		; LOOP UNTIL #INPUT IS NOT IN RANGE

DISPLAY
PUTS
LEA R0, LF		; NEW LINE
INVALID HALT

DAYS	.STRINGZ		"Sunday   "
	.STRINGZ		"Monday   "
	.STRINGZ		"Tuesday  "
	.STRINGZ		"Wednesday"
	.STRINGZ		"Thursday "
	.STRINGZ		"Friday   "
	.STRINGZ		"Saturday "

LF	.FILL x000A
X	.FILL x31F0
K	.FILL x31F1
C	.FILL x31F2
D	.FILL x31F3

M	.FILL x31F5
NEWM	.FILL x31F6
QUOTOFM .FILL x3103
QUOTOFD .FILL x3104
QUOTOFC .FILL x3105
F	.FILL x3106
MODF	.FILL x3107
R	.FILL x31F4


MONTH
LDI R1, X		; PUT OG MONTH "X" INTO R1
ADD R4, R1, #0		; PUT "MONTH" INTO R4
ADD R4, R4, #-2		; GET NEW MONTH, M
BRnz GETM		; IF x>2 SUBTRACT 2
RET			; BACK TO CALLING PROGRAM

GETM
ADD R4, R4, #12		; ELSE, ADD 10 TO X
RET

MULT
ST R5, SaveReg5		; SAVE R5
ST R6, SaveReg6		; SAVE R6
LDI R4, M		; GET VALUE THAT IS IN M
NOT R4, R4		; INVERTED IT
ADD R4, R4, #1		; TWO COMP

LOOP
ADD R6, R5, R4		; IF ABOVE ^ IS TRUE, QUIT 
BRzp QUIT1		; ELSE KEEP GOING
ADD R5, R5, #1		; COUNTER
ADD R3, R3, #13		; MULT 13 TIL COUNTER MAKES R6 HIT 0
BR LOOP			; BACK TO THE LOOP

QUIT1
ADD R3, R3, #-1		; (13M-1) ZELLERS FORM
RET
LD R5, SaveReg5	
LD R6, SaveReg6
RET

SaveReg5 .FILL x0
SaveReg6 .FILL x0

DIV1
LDI R0, NEWM		; LOAD VALUE NEWM IN R0
AND R1, R1, #0		; CLEAR R1
ADD R1, R1, #5		; PUTS 5 INTO R1
ADD R0, R0, #0		; CHECKS IF NEWM = 0
BRz QUIT2		; IF YES QUIT, IF NOT KEEP GOING
ADD R3, R0, #0		; NEWM INTO R3
ADD R4, R1, #0		; 5 INTO R4
NOT R4, R4		; INVERT
ADD R4, R4, #1		; 2S COMPLIMENT
AND R5, R5, #0		; CLEAR R5

LOOP2
ADD R5, R5, #1		; COUNTER
ADD R3, R3, R4		; SUBTRACT NEWM BY -5
BRp LOOP2		; IF POS GO TO LOOP2
BRz QUIT2		; IF 0 GO TO QUIT2
ADD R3, R3, R1		; IF NEG ADD RESULT +5
ADD R5, R5, #-1		; IF NEG ADD TO THE COUNTER -1
QUIT2 RET		; BACK TO CALLING PROGRAM

DIV2
LDI R0, D		; LOAD VALUE OF D, LAST TWO DIGITS YEAR IN R0
AND R1, R1, #0		; CLEAR R1
ADD R1, R1, #4		; PUTS 4 IN R1
ADD R0, R0, #0		; CHECK IF D IS 0
BRz QUIT3		; IF ZERO QUIT, ELSE CONTINUE

ADD R3, R0, #0		; D INTO R3
ADD R4, R1, #0		; 4 INTO R4
NOT R4, R4		; INVERT
ADD R4, R4, #1		; 2S COMPLIMENT
AND R5, R5, #0		; CLEAR R5

LOOP3
ADD R5, R5, #1		; COUNTER
ADD R3, R3, R4		; SUBTRACT D BY -4
BRp LOOP3		; IF POS GO TO LOOP3
BRz QUIT3		; IF 0 QUIT 3
ADD R3, R3, R1		; IF NEG ADD THE RESULT +4
ADD R5, R5 #-1		; IF NEG ADD TO THE COUNTER
QUIT3
RET			; BACK TO CALLING PROGRAM

DIV3
LDI R0, C		; LOAD C, CENTUER OF YEAR INTO R0
AND R1, R1, #0		; CLEAR R1
ADD R1, R1, #4		; PUTS 4 INTO R1
ADD R0, R0, #0		; CHECKS IF C IS 0
BRz QUIT4		; IF ZERO QUIT ELSE CONTINUE
ADD R3, R0, #0		; C INTO R3
ADD R4, R1, #0		; 4 INTO R4
NOT R4, R4		; INVERT
ADD R4, R4, #1		; 2S COMPLIMENT
AND R5, R5, #0		; CLEAR R5

LOOP4
ADD R5, R5, #1		; COUNTER
ADD R3, R3, R4		; SUBTRACT C BY -4
BRp LOOP4		; IF POS GO BACK TO LOOP4
BRz QUIT4		; IF 0 GO TO QUIT4
ADD R3, R3, R1		; IF NEG ADD THE RESULT +4
ADD R5, R5, #-1		; IF NEG ADD THE COUNTER -1
QUIT4			; BACK TO CALLING PROGRAM
RET

ZELLERS
LDI R0, K		; LOAD  VALUE OF K (THE DAY) INTO R0
LDI R1, QUOTOFM		; LOAD VALUE OF (13M-1)/5, INTO R1
LDI R2, D		; LOAD VALUE OF D, LAST 2 #'S OF YEAR, INTO R2
LDI R3, QUOTOFD		; LOAD VALUE OF D/4, IN R4
LDI R4, QUOTOFC		; LOAD VALUE C/4 INTO R4
LDI R5, C		; LOAD VALUE OF C INTO R5
ADD R5, R5, R5		;2(C)
NOT R5, R5		; IN ZELLERS
ADD R5, R5, #1		; R5 = -2C
ADD R6, R0, R1		; PART DOES EVERYTHING!!!
ADD R6, R6, R2		; AFTER DOING MULT.
ADD R6, R6, R3		; DIVISION PARTS
ADD R6, R6, R4		; 
ADD R6, R6, R5		; WILL GIVE YOU "f"
RET

MODULEF
LDI R0, F		; LOAD F INTO R0
AND R1, R1, #0		; CLEARS IN R1
ADD R1, R1, #7		; PUTS 7 IN R1
ADD R0, R0, #0		; CHECKS IF F IS 0
BRz QUIT5		; IF ZERO GO TO QUIT5
BRn NEGF		; IF NEG GO TO NEGF, ELSE CONTINUE
ADD R3, R0, #0		; F INTO R3
ADD R4, R1, #0		; 7 INTO R4
NOT R4, R4		; INVERT
ADD R4, R4, #1		; 2'S COMPLIMENT
AND R5, R5, #0		; CLEAR R5

LOOP5
ADD R5, R5, #1		; COUNTER
ADD R3, R3, R4		; SUBTRACT F BY 7
BRp LOOP5		; IF POS GO TO LOOP 5
BRz QUIT5		; IF ZERO GO TO QUIT5
ADD R3, R3, R1		; IF NEGATIVE ADD THE RESULT +7
ADD R5, R5, #-1		; IF NEG ADD THE COUNTER +1
QUIT5			; BACK TO CALLING PROGRAM
RET			

NEGF
ADD R3, R0, #0		; F INTO R3
NOT R3, R3		; INVERT
ADD R3, R3, #1		; 2'S COMPLIMENT
ADD R4, R1, #0		; 7 INTO R4
NOT R4, R4		; INVERT
ADD R4, R4, #1		; 2'S COMPLIMENT
AND R5, R5, #0		; CLEAR R5

LOOP6
ADD R5, R5, #1		; COUNTER
ADD R3, R3, R4		; SUBTRACT F BY 7
BRp LOOP6		; IF POS GO TO LOOP6 
BRz QUIT6		; IF ZERO GO TO QUIT6
NOT R3, R3		; IF NEGATIVE MAKE F POS
ADD R3, R3, #1		; USING 2'S COMPLIMENT
ADD R5, R5, #-1		; IF IT WAS NEGATIVE, ADD TO THE COUNTER +1
QUIT6			; BACK TO CALLING PROGRAM
RET



.END