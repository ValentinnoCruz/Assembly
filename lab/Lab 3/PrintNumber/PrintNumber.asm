;CIS11
;Valentinno Cruz
;Lab #3
;Second Program
;Description: LC-3 Program that
; Inputs: None
; Outputs: Hex Number
; Side Effects: 
; Run:  Assemble the program
;	Open the Simulate Software 
;	Load the Assembled program (.obj file)
;	Run the code and see the output on the console

.ORIG x3000
  AND R0, R0, #0	; Clear R0 (initializing register 1)
  LD R0, NUM		; Load our number into R (load register)
  LD R2, ASCII		; load the ascii offset into R2
  ADD R0, R0, R2	; adding and storing in register 0
  OUT
HALT			; TRap x25

NUM	.fill x02	; Our number to print (hex number 2)
ASCII	.fill x30	; our ASCII offset (ascii 30 number)
.END
OUT		    ;DISPLAY THE SUM <TRAP21>
; STOP
HALT		    ;<TRAP25>
; data