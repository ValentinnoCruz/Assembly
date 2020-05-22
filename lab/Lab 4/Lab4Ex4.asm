;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC P = Q = S = Z + hexadecimal 4D
;This program performs basic arithmetic calculations. 


.ORIG x3000
LD R0, P		; Load Label P to R0
LD R1, Q		; load label Q to R1
ADD R1, R0, #0		; R1 = P+ Q
LD R2, S		; load label S to R2
ADD R2, R1, #0		; R2 = P=Q=S
LD R3, Z		; load lbl z to r3
ADD R3, R2, #0		; r3=p=q=s=z
LD R4 HEX4D		; load lbl HEX4D to R4
ADD R4, R4, R3		; R4= = X+HEX4D

OUT

HALT			; End program


P	.Fill x3002
Q	.FILL x3003
S	.FILL x3004
Z	.FILL x3005
HEX4D	.FILL x4D


.END