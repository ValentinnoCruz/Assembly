;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC X=(Y+1)- Z
;This program performs basic arithmetic calculations. 


.ORIG x3000
LDI R1, Y 		; Load to the label
ADD R1, R1, #1		; R1 = Y+1
LDI R2, Z		; Loading Z to R2
NOT R2, R2		; First complement
ADD R2, R2, #1		; Twos complement
ADD R2, R2, R1		; R2 = Y + 1 - Z ---(Y+1) =is in R1
STI R2, X		; Put result in X

HALT			; End program

X	.Fill x3100
Y	.FILL x3102
Z	.FILL X3104

.END