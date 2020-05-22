; Lab #5 Excersize 1: Arithmetic functions

.ORIG x3000
LD R0, P		; LOAD P INTO R0
LD R1, Q		; LOAD Q INTO R1
ADD R1, R0, #0		; R0 + 0 = R1			---- THEREFORE R0=R1
LD R2, S		; LOAD S INTO R2
ADD R2, R1, #0		; R1 + 0 = R2			---- THEREFORE R2=R1=R0
LD R3, Z		; LOAD Z INTO R3
ADD R3, R2, #0		; R2 + 0 = R3			---- THEREFORE R3=R2=R1=R0
LD R4, HEX4D		; LOAD R4 W/ HEX4D		---- LOAD LABEL "HEX4D"
ADD R4, R4, R3		; ADD R4 + R3			----R3 CAN BE P,Q,R,S,Z

OUT

HALT

P	.FILL x3002
Q	.FILL x3003
S	.FILL x3004
Z	.FILL x3005
HEX4D	.FILL x4D

.END
