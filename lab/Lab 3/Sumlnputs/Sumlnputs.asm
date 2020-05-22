;CIS11
;Valentinno Cruz
;Lab #3
;Second Program
;Description: LC-3 Program that
; Inputs: ASCII inputs
; Outputs: sum of two inputs
; Side Effects: 
; Run:  Assemble the program
;	Open the Simulate Software 
;	Load the Assembled program (.obj file)
;	Run the code and see the output on the console

.ORIG x3000	; begin at x3000 ; input two numbers
IN	  	;input an interger character (ASCII) <TRAP 23>
LD R3, HEXN20	;SUBTRACT X30 TO GET INTEGER
ADD R0, R0, R3
ADD R1, R0, x0	;move the first integer to register 1
IN		;input another integer <trap23>
ADD R0, R0, R3	;convert it to an integer
; add the numbers
ADD R2, R0, R1	; add the two integers
; print the results
LEA R0, MESG	;load the addres of the message string
PUTS		; "PUTS" outputs a string <trap 22>
ADD R0, R2, x0 	;move the sume to R0, to be output
LD R3, HEX30	;add 30 to integer to get integer character
ADD R0, R0, R3
OUT		;display the sum <trap 21>
; stop
HALT		; <TRAP 25>
; data
MESG .STRINGZ "The sum of those two numbers is: "
HEXN20 .FILL xFFD0 ; -30 HEX
HEX30 .FILL x0030 ; 30 HEX
.END