;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC T = (A + B) + (C - 9)
;This program performs basic arithmetic calculations. 


.ORIG x3000
LDI R0, A		; Loading A to R0
LDI R1, B		; Loading B to R1
ADD R1, R1, R0		; R1 = A+B
LDI R3, C		; Loading C to R3
ADD R2, R2 #9		; R2 = #9
NOT R2, R2		; First compliment of R2 or #9
ADD R2, R2 #1		; Second Compliment of #9
ADD R5, R3, R2		; R5 = C-9
ADD R5, R5, R1		; R5 = (A+B) + (C-9)
STI R5, T		; Store R5 to T which contains result

LDI R4, T		




HALT			; End program

A	.Fill x3102
B	.FILL x3103
C	.FILL X3104
T	.FILL X3105
.END