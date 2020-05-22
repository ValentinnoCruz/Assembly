;CIS11
;Valentinno Cruz
;Lab #3
;Hello World Program (program title)
;Description: LC-3 Program the displays
; "Hello World ! This is my first LC3 program!" to the console
; Inputs: None
; Outputs: Hello World This is my first LC3 Program!
; Side Effects: None
; Run:  Assemble the program
;	Open the Simulate Software 
;	Load the Assembled program (.obj file)
;	Run the code and see the output on the console

.ORIG x3000
LEA R0 , HW ;load address of string
PUTS ;output string to console
HALT ;end program
HW .STRINGZ "Hello WOrld ! This is my first LC# program !"
.END