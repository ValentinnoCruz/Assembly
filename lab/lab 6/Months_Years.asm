; Valentinno Cruz
; Lab #6 Days
; Description:
; 	This program displays the days of the week to the console.
;	A day of the week is displayed to the console corresponding
; 	to whatever the user inputs.
;
;	Input is read from the user as a number from 0-6. A 0 
;	corresponds to sunday, a one corresponds to 1, a 2 
;	corresponds to a 3, and so on. The output will be a
;	day of the week reprented as a string. So 0 would
;	display "Sunday" to the console, 1 would dispaly 
; 	"Monday" to the console, 2 would display "Tuesday"
; 	to the console, and so on. 


.ORIG x3000
RESTART	LEA R0, PROMPT		; Prompt user for input
	PUTS			; SHOW ON CONSOLE
	GETC			; READ CHARACTER INPUT
	ADD R3, R0 x0		; COPY R0 TO R3, R3 = R0
	ADD R3, R3, #-16	; R3 = OFFSET AT 16
	ADD R3, R3, #-16	; R3 = OFFSET AT 32
	ADD R3, R3, #-16	; R3 = OFFSET AT 48
	ADD R4, R3, #-6		; R4 = OFFSET 6 FROM R3, THIS IS DONE FOR INPUT VALID. 0-6
	BRp ERROR		; GO TO ZERO IF INPUT LARGER THAN 6
	LEA R0, DAYS		; LOAD DAYS TO R0
	ADD R3, R3, x0		; R3 = 0, SET UP ZERO BRANCHING INT. LOOP BEGIN @ 0

LOOP	BRz DISPLAY		; LOOP LBL, IF = 0, GO TO DISPLAY
	ADD R0, R0, #10		; R0 = #10, 10 CHAR FOR DAYS INCLUDING NULL TERMINATED
	ADD R3, R3, #-1		; R3 = OFFSET 1, UPDATE VALUE FOR INCREMENT IN LOOP
	BR LOOP			; GO TO LOOP

DISPLAY PUTS			; SHOW ON SCREEN

	LEA R0, LF		; LOAD LF TO R0, LF HOLD DAYS AS STRINGS
	PUTS			; SHOW ON SCREEN
	BR RESTART		; RELOOP BACK TO PROMPT

ERROR HALT			; IF INPUT IS WRONG STOP PROGRAM

PROMPT .STRINGZ "ENTER A NUMBER 0-12: "

DAYS 	.STRINGZ "January   "
 	.STRINGZ "February  "
 	.STRINGZ "March     "
 	.STRINGZ "April     "
	.STRINGZ "May       "
	.STRINGZ "June      "
 	.STRINGZ "July      " 
 	.STRINGZ "August    " 
 	.STRINGZ "September " 
 	.STRINGZ "October   " 
 	.STRINGZ "November  " 
 	.STRINGZ "December  " 
 	.STRINGZ "INVALID INPUT"

LF	.FILL x000A


.END