.ORIG x3000 ; begin at x3000

;  input two numbers
IN ;input an integer character (ascii) {TRAP 23}

LD R3, HEXN30 ;subtract x30 to get integer

ADD R0, R0, R3

ADD R1, R0, x0 ;move the first integer to register 1

IN ;input another integer {TRAP 23}

ADD R0, R0, R3 ;convert it to an integer

; add the numbers

ADD R2, R0, R1 ;add the two integers

; print the results

LEA R0, MESG ;load the address of the message string

PUTS ;"PUTS" outputs a string {TRAP 22}

ADD R0, R2, x0 ;move the sum to R0, to be output


LD R2, NEG_TEN  ; load -10 into R2
ADD R2, R2, R0  ; minus ten from our sum
BRn JUMP    ; skip this code if our value is less than 10
AND R4, R4, #0  ; clear R4
ADD R4, R4, R2  ; store R2 into R4
LD R0, ASCII_1  ; load the ascii char '1'
OUT     ; print '1' to the console
AND R0, R0, #0  ; clear R0
ADD R0, R0, R4  ; store R4 back into R1


JUMP

LD R3, HEX30 ;add 30 to integer to get integer character
ADD R0, R0, R3
OUT ;display the sum {TRAP 21}

; stop

HALT ;{TRAP 25}

; data

MESG .STRINGZ "The sum of those two numbers is: "

HEXN30 .FILL xFFD0 ; -30 HEX

HEX30 .FILL x0030 ; 30 HEX

NEG_TEN .FILL #-10

ASCII_1 .FILL x0031 ; ASCII char '1'

.END