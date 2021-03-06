; Lab #5 Excersize 1: Arithmetic functions

.ORIG x3000

LDI R1, X		; load X into R1
LDI R2, Y		; load Y into R2
NOT R4, R2		; negate R2 put into R4
ADD R4, R4, #1		; add +1 into R4 (-R2)
ADD R3, R1, R4		; add R1 and R4 into R3
STI R3, XMY		; store R3 into XMY
ADD R4, R1, #0		; ADD 0 TO R1 INTO R4
BRzp ZPX		; IF ZERO OR POSITIVE GO TO ZPX (if only greater it would be P not zp)
NOT R4, R4		; NEGATE R4 PUT INTO R4
ADD R4, R4, #1		; ADD +1 INTO R4 (-R4)

ZPX			; LABEL ZPX (ZERO POSITIVE X)
STI R4, ABSX		; STORE R4 INTO R5
ADD R5, R2, #0		; ADD 0 TO R2 INTO R5
BRzp ZPY		; IF ZERO OR POSITIVE, GO TO ZPY
NOT R5, R5		; NEGATE R5 PUT INTO R5
ADD R5, R5, #1		; ADD +1 INTO R5 (-R5)

ZPY			; LABEL ZPY (ZERO POSITIVE Y)
STI R5, ABSY		; STORE R5
NOT R7, R5		; NEGATE R5 PUT INTO R7
ADD R7, R7, #1		; ADD +1 INTO R4
ADD R6, R4, R7		; ADD R4 AND R7 INTO R6
BRp POS			; CONDITION IF GREATER THAN ZERO
BRz ZERO		; CONDITION IF EQUALS TO ZERO
BRn NEG			; CONDITION IF LESS THAN ZERO

POS			; LABEL POS
AND R6, R6, x0		; CLEAR R6
ADD R6, R6, #1		; ADD 1 TO R6 (1 FULFILLS THE REQ OF IT BEING A POS NUMBER)
STI R6, Z		; STORE R5 TO Z
HALT			; HALT PROGRAM END OF BRANCH

ZERO			; ZERO LABEL
AND R6, R6, x0		; CLEAR R6, R6=0
STI R6, Z		; STORE R6 TO Z
HALT			; HALT PROGRAM END OF BRANCH

NEG			; NEG LABEL
AND R6, R6, x0		; CLEAR R6, R6=0
ADD R6, R6, #2		; ADD #2 TO R6, R6=2
STI R6, Z		; STORE R6 TO Z
HALT			; HALT PROGRAM END OF BRANCH

X .FILL x3120		; FILL X WITH x3120
Y .FILL x3121		; FILL Y WITH x3121
XMY .FILL x3122		; FILL XMY
ABSX .FILL x3123	; FILL ABSX
ABSY .FILL x3124	; FILL ABSY
Z .FILL X3125		; FILL Z
.END			 