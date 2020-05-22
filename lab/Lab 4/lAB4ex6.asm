;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC P = Q = S = Z + hexadecimal 4D
;This program performs basic arithmetic calculations. 


.ORIG x3000
AND R1, R1, x0		; clear R1
AND R2, R2, x0		; clear R2
LD R6, RESET		; load RESET to r6
LEA R0, LINE1		 
PUTS			
GETC			; get chracter
OUT			; output
ADD R1, R6, R0		; R1 = RESET + R0
LEA R0, LINE2		; 
PUTS			
GETC			; get chracters
OUT			; output
ADD R2, R6, R0		; R2 = RESET + R0
JSR COMPARE		; 

HALT

;////////COMPARE FUNCTION BEGINS////////
COMPARE
	AND R3, R3, x0		; Clear R3
	NOT R2, R2		; first compliment of R2
	ADD R2, R2, x1		; R2 = R2 + x1
	ADD R3, R1, R2		; R3 = R1 + R2
       BRn NEG			
	ADD R3, R3, x0		; R3 = R 
       BRp POS			
	ADD R3, R3, x0		; Clear R3
       BRz EQ			
	AND R5, R5, x0		; Clear R5
	ADD R5, R5, R1		;  R5 = R5 + R1
       RET
    NEG LEA R0, N	;triggers whEN R3 is NEGATIVE
	PUTS
	RET
    POS LEA R0,	P 	;triggers who R3 is POSITIVE
	PUTS
	RET
    EQ LEA R0,	E 	;triggers who R3 is ZERO
	PUTS
	RET


N .STRINGZ "\nX IS LESS THAN Y"
P .STRINGZ "\nX IS GREATER THAN Y"
E .STRINGZ "\nX IS EQUAL TO Y"
RESET .FILL xFFD0 ; RESET = -48 AS THIS IS ASCII RESETER FOR OUR PROGRAM
LINE1 .STRINGZ "ENTER X : "
LINE2 .STRINGZ "\nENTER Y : "

.END


