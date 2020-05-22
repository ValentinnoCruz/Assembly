; Valentinno Cruz
; Lab #3
; Hello World


.ORIG x3000

LEA R0, HW 	; HW loads address of string with label HW to register 0 (R0).
PUTS		; instruction outputs the string to console.
HW	.STRINGZ "Hello world this is my first LC-3 program \n"

LEA R0, HW2 	; HW loads address of string with label HW to register 0 (R0).
PUTS		; instruction outputs the string to console.
HW2	.STRINGZ "I am learning assembly programming"

HALT		; TERMINATES PROGRAM

.END