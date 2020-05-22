;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC OF P AND Q
;This program performs basic arithmetic calculations. the input will be
; two values P and Q. THey are stored at locations x3120 and x3121
; P-Q


.ORIG x3000
LDI R3, P		; Load th values of P and Q
LDI R4, Q		; Stored in x3120 and x3121
NOT R2, R4		; Do Twos complement of Q
ADD R2, R2 #1		; Add to complete twos complement Q
ADD R1, R2, R3		; R1 = P - Q
STI R1, minus		; Store the result of R1 in Label P_minus_Q

HALT			; END PROGRAM

P		.FILL x3120
Q		.FILL x3121
minus		.FILL x3122

.END