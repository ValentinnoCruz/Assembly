.ORIG x3000 ; start at x3000 above system memory
LEA R0, CLASS   ; load address of string CLASS in R0
PUTS        ; use PUTS to output string to console
LEA R0, MYNAME  ; repeat steps for class template
PUTS
LEA R0, PRNUM
PUTS
LEA R0, NWLINE
PUTS

; now get a character from the user and echo it back
; using the prompts INPROM and OUTPROM
ASKINP  LEA R0, INPPROM
    PUTS
    GETC        ; get a character from the keyboard
    ADD R2,R0,#0    ; move the value in R0 to R2 for later comparisons

; PROCESS THE INPUT
; first figure out if they entered a non-printing character with ASCII code
; <32. If so, suppress the printing of the character and give the user the
; standard error that they have not entered a number. We do this by subtracting
; 33 from the input and if the CC is negative, it's a non-printing character. 
; For purposes of this program a space is considered a non-printing character.
    ADD R2, R2, #-15
    ADD R2, R2, #-15
    ADD R2, R2, #-3 ; subtracted 33, see if it's negative
    BRn XERR    ; if so branch to error message

; if we're still here, then it's a printable character and we continue here...
    OUT     ; echo the character back on the input line
    LEA R0, SPACE   ; need a space after the input
    PUTS
    AND R0, R0, #0  ; set the condition to zero again

; figure out what character the user entered, and we have already subtracted 33 from
; the entry. See if it's a ! and the user wants to end. If so, the CC
; will be Zero and we break to XDONE.
; if that's not it, subtract another 15 (for a total subtracted of 48) and 
; successively test to see if it's a number match. If there is no match, 
; then print out that the user has not made a correct entry

; now we subtracted 33 so if they entered ! we now have 0 in R2, subtract 0
; and test the CC to see if it's Zero.
    ADD R1, R2, #0
    BRz XDONE
; if we have not just branched, subtract another 15 and keep testing
    ADD R2, R2, #-15
    ADD R1, R2, #-9
    BRz XNINE
    ADD R1, R2, #-8
    BRz XEIGHT
    ADD R1, R2, #-7
    BRz XSEVEN
    ADD R1, R2, #-6
    BRz XSIX
    ADD R1, R2, #-5
    BRz XFIVE
    ADD R1, R2, #-4
    BRz XFOUR
    ADD R1, R2, #-3
    BRz XTHREE
    ADD R1, R2, #-2
    BRz XTWO
    ADD R1, R2, #-1
    BRz XONE
    ADD R1, R2, #0
    BRz XZERO

    BRnzp XERR		; if number not entered out put error msg

; here is the section that prints out the string related to the 
; number that was entered, by loading the string into R0 and
; using PUTS to print it out, then BReak back to the beginning
; of the input sequence and ask again. Pre-condition is that the
; user typed in a number for 0-9, if not they will get an error
; elsewhere in the program
XZERO   LEA R0, ZERO
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP  
XONE    LEA R0, ONE
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XTWO    LEA R0, TWO
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XTHREE  LEA R0, THREE
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XFOUR   LEA R0, FOUR
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XFIVE   LEA R0, FIVE
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XSIX    LEA R0, SIX
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XSEVEN  LEA R0, SEVEN
    PUTS
    LEA R0, NWLINE
    PUTS    
    BRnzp   ASKINP
XEIGHT  LEA R0, EIGHT
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XNINE   LEA R0, NINE
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XERR    LEA R0, INPERR
    PUTS
    LEA R0, NWLINE
    PUTS
    BRnzp   ASKINP
XDONE   LEA R0, DONE
    PUTS
    LEA R0, NWLINE
    PUTS
    HALT

; store the following strings with these labels
NWLINE  .STRINGZ    "\n"
SPACE   .STRINGZ    " "
CLASS   .STRINGZ    "CS2810\n"  
MYNAME  .STRINGZ    "James Lohse\n"
PRNUM   .STRINGZ    "Project 3\n"
BYEBYE  .STRINGZ    "Program execution terminated!\n"
INPPROM .STRINGZ    "Input a number 0-9: "
INPERR  .STRINGZ    "Error! You did not input a number."
DONE    .STRINGZ    "Done!"
ZERO    .STRINGZ    "January  "
ONE 	.STRINGZ    "February "
TWO 	.STRINGZ    "March    "
THREE   .STRINGZ    "April    "
FOUR    .STRINGZ    "May      "
FIVE    .STRINGZ    "June     "
SIX 	.STRINGZ    "July     "
SEVEN   .STRINGZ    "August   "
EIGHT   .STRINGZ    "September"
NINE    .STRINGZ    "October  "
    .END