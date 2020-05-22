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
HW .STRINGZ "Hello World ! this is my first program! \n"
LEA R0, HW2 ;load address of string
PUTS ;
HW2 .STRINGZ "I am learning assembly programming \n"
HALT ;end program
.END