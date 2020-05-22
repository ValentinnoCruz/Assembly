;CIS 11
;LAB 4
;VALENTINNO CRUZ
;ARITHMETIC OF P AND Q
;This program performs basic arithmetic calculations. the input will be
; two values P and Q. THey are stored at locations x3120 and x3121
; P-Q


.ORIG x3000
LDI R3, P		; Load P (x3120) into R3 ASCII code for P is 120 + 3000=x3120
LDI R4, Q		; Load Q (x3121) into R3 ASCII code for Q is 121 + 3000=x3121 
NOT R2, R4		; Do Twos complement of Q, 
ADD R2, R2 #1		; Add to complete twos complement Q.this gives us the negative value of Q or (-Q)
ADD R1, R2, R3		; R1 = P - Q (we are now adding p with the 2's complement of Q or (-Q)
STI R1, minus		; Store the result of R1 in Label "minus_"

HALT			; END PROGRAM

P		.FILL x3120
Q		.FILL x3121
minus		.FILL x3122

.END