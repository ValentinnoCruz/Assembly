; CIS 11 Assembly Programming
; Final Project: Grade Calculator
; Leonardo R. & Valentinno C.


.ORIG x3000

;--------------------------------MAIN----------------------------------

LD	R1, numScores		; Set first parameter i.e. number of test scores
LEA	R2, scoreArray		; Set second parameter i.e. the address of scoreArray, where to store the test scores		
LEA	R3, strArray		; Set third parameter i.e. the address of strArray, where to store a user provided input test score string
LEA	R4, inputMsg		; Set third parameter i.e. the address of input message string to display
JSR	GetTestScore		; GetTestScore(R1, scoreArray, strArray), Get 5 test scores	
LD	R1, numScores		; Set first parameter i.e. number of test scores
JSR	FindMax			; R1 = FindMax(R1, scoreArray), Find max score
LEA	R2, strArray		; Set second parameter i.e. the address of strArray
JSR	ITOA			; ITOA(R1, strArray), Convert it to string	
LEA	R0, maxMsg			
PUTS 				; Print the max score output message
LEA	R0, strArray		
PUTS 				; Print the max score
LD	R1, numScores		; Set first parameter i.e. number of test scores
LEA	R2, scoreArray		; Set second parameter i.e. the address of scoreArray
JSR	FindMin			; R1 = FindMin(R1, scoreArray), Find min score
LEA	R2, strArray		; Set second parameter i.e. the address of strArray
JSR	ITOA			; ITOA (R0, strArray), Covert it to string 
LEA	R0, minMsg		
PUTS 				; Print the min score output message
LEA	R0, strArray
PUTS				; Print the min score
LD	R1, numScores		; Set first parameter i.e. number of test scores
LEA	R2, scoreArray		; Set second parameter i.e. the address of scoreArray
JSR	FindAverage		; R1 = FindAverage(R1, scoreArray), Find average score
LEA	R2, strArray		; Set second parameter i.e. the address of strArray
JSR	ITOA			; ITOA(R1, strArray), Covert it to string 
LEA	R0, avgMsg		
PUTS 				; Print the average score output message
LEA	R0, strArray
PUTS				; Print the average score
JSR	FindGrade		; R0 = FindGrade(R0), Find grade letter
LEA	R0, gradeMsg		
PUTS 				; Print the grade output message
ADD	R0, R1, #0		; R0 = R1
PUTC				; Print the grade
LEA	R0, byeMsg
PUTS				; Print the bye message	
HALT				; End of program

;-----------------------------END OF MAIN-------------------------------


;---------------------------GLOBAL VARIABLES----------------------------

maxMsg		.STRINGZ	"\nThe Maximum score is "
minMsg		.STRINGZ	"\nThe Minimum score is "
avgMsg		.STRINGZ	"\nThe Average score is "
gradeMsg	.STRINGZ	"\nThe Grade obtained is "
byeMsg		.STRINGZ	"\nBye... "
inputMsg	.STRINGZ	"Enter a score value: "
tempRegister	.FILL	0x0
numScores	.FILL	0x5
scoreArray	.FILL	0x0
		.FILL	0x0
		.FILL	0x0
		.FILL	0x0
		.FILL	0x0
strArray	.FILL	0x0
		.FILL	0x0
		.FILL	0x0
		.FILL	0x0
		.FILL	0x0
stackPointer	.FILL	0x6000
asciiA		.FILL	0x41
ninety		.FILL	90
sixty		.FILL	60
negAscii0	.FILL	-48
ascii0		.FILL	48


;-----------------------END OF GLOBAL VARIABLES-------------------------


;------------------------STACK PUSH SUBROUTINE--------------------------
;Receives item, to be pushed in the stack, in R0

;Start of subroutine
Push
ST	R1, tempRegister		;Store R1 so that it does not get modified
LD	R1, stackPointer		;Get stack pointer's contents
ADD 	R1, R1, #-1			;Decrement it so as to make space for the item to save
STR	R0, R1, #0			;Save R0 in stack
ST	R1, stackPointer		;Save the stack pointer 
LD	R1, tempRegister		;Restore R1 value
RET

;---------------------------STACK PUSH END------------------------------


;------------------------STACK POP SUBROUTINE---------------------------
;Pop out an item from the stack into R0

;Start of subroutine
Pop
ST	R1, tempRegister		;Store R1 so that it does not get modified
LD	R1, stackPointer		;Get stack pointer's contents
LDR	R0, R1, #0			;Pop out an element into R0
ADD 	R1, R1, #1			;Increment stack pointer so as to clear the space occupied by the item being popped
ST	R1, stackPointer		;Save the stack pointer 
LD	R1, tempRegister		;Restore R1 value
RET

;--------------------------STACK POP END-------------------------------


;--------------------FIND GRADE SUBROUTINE-----------------------------
;Receives avererage score in R1
;Returns grade in R1
;Preserves all other registers R0, R1

;Start of subroutine
FindGrade
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
LD	R2, asciiA		;R2 will store the grade, Initially assume that the grade might be A	
LD	R3, ninety		;R3 = 90
LD	R4, sixty		;R4 = 60
GradeLoop
NOT	R5, R3
ADD	R5, R5, #1		;R5 = -R3
ADD	R5, R5, R1		;Add to set the flags
BRZP	EndGradeLoop		;Output the grade if average score is within the current scoring limit
ADD	R3, R3, #-10		;Move on to the previous limit	
ADD	R2, R2, #1		;Move on to the next grade
NOT	R5, R4
ADD	R5, R5, #1		;R5 = -R4
ADD	R5, R5, R3		;Add to set the flags
BRZP	GradeLoop		;Keep on doing that until we are in F grade limit
ADD	R2, R2, #1		;R2 = 'F'
EndGradeLoop			;R2 has the grade letter
ADD	R1, R2, #0		;Save grade in R1
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with grade in R1

;------------------------FIND GRADE END--------------------------------


;--------------------ALPHA TO INTEGER SUBROUTINE-----------------------
;Receives in R1 - Address of an array containing the ascii formatted number	
;Returns the converted number in R1
;Preserves all registers except R0, R1

;Start of subroutine
ATOI
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
AND	R2, R2, #0		;R2 = 0
ADD	R2, R2, #10		;R2 = 10, Multiplier
ADD	R3, R1, #0		;Save passed array address in R3
AND	R1, R1, #0		;R1 will store the corresponding number in decimal 
LD	R4, negAscii0		;R4=-48
ATOILoop
LDR	R5, R3, #0		;Get an ascii digit
ADD	R5, R5, #0		;Set flags
BRZ	EndATOILoop		;End of conversion, if null character is encountered
ADD	R5, R5, R4		;Convert the ascii digit to corresponding decimal digit
JSR	Multiply		;Multiply the already accumulated number with 10
ADD	R1, R1, R5		;And then add the current digit to it
ADD	R3, R3, #1		;Move on to the next character in Array	
BR	ATOILoop		;Repeat
EndATOILoop			;R1 has the converted number
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with converted number in R1

;----------------------ALPHA TO INTEGER END----------------------------


;--------------------INTEGER TO ALPHA SUBROUTINE-----------------------
;Receives two parameters:
	; R1 - Number to be converted to string
	; R2 - Address of an array where to save the converted number	
;Preserves all registers except R0

;Start of subroutine
ITOA
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R1, #0		;R0 = R1	
JSR 	Push			;Save R1
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
ADD	R3, R1, #0		;Save R1
ADD	R4, R2, #0		;Save R2
AND	R5, R5, #0		;Digits counter
DigitCountLoop
ADD	R5, R5, #1		;Increment digit counter
AND	R2, R2, #0		;R2 = 0
ADD	R2, R2, #10		;R2 = 10, Set divisor
JSR	Divide			;Keep on dividing the passed Value by 10
ADD	R1, R2, #0		;Place quotient back in R1
BRNP 	DigitCountLoop		;Keep on dividing until the quotient becomes zero 
ADD	R5, R5, R4		;Address of the end of array
AND	R0, R0, #0		;R0=0
STR	R0, R5, #0		;NULL terminate the Array
ADD	R1, R3, #0		;R1 = passed Value
LD	R3, ascii0		;R3 = 48
ConversionLoop
AND	R2, R2, #0		;R2 = 0
ADD	R2, R2, #10		;R2 = 10, Set divisor
JSR	Divide			;Keep on dividing the passed Value by 10
ADD	R1, R1, R3		;Convert the remainder to its ascii representation
ADD	R5, R5, #-1		;Move on to the previous location in the Array 
STR	R1, R5, #0		;Save the ascii formated remainer in the Array
ADD	R1, R2, #0		;Place quotient back in R1
BRNP 	ConversionLoop		;Keep on dividing until the quotient becomes zero 
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R1, R0, #0		;Restore R1
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET

;----------------------INTEGER TO ALPHA END----------------------------


;--------------------GET TEST SCORE SUBROUTINE-------------------------
;Receives three parameters:
	; R1 - Number of test scores
	; R2 - Address of an array where to store the test scores (scoreArray)
	; R3 - Address of an array where to store a user provided input test score string (strArray)	
;Preserves all registers except R0

;Start of subroutine
GetTestScore
ADD	R0, R7, #0		;R0 = R7
JSR 	Push			;Save R7, return address
ADD	R0, R1, #0		;R0 = R1
JSR 	Push			;Save R1
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
ADD	R0, R6, #0		;R0 = R6
JSR 	Push			;Save R6
ADD	R6, R4, #0		;Save input message address
ADD	R4, R1, #0		;Loop counter
GetScore
ADD	R0, R6, #0		;Place input message address in R0
PUTS				;Display it
ADD	R5, R3, #0		;strArray address
TakeInput
GETC				;Get a character i.e. an ascii digit
OUT				;Echo it
ADD	R1, R0, #-10		;Subtract 10 in order to set the flags
BRZ	EndOfInput		;End getting ascii digits if ENTER encountered	
STR	R0, R5, #0		;Save the ascii digit
ADD	R5, R5, #1		;Move on to the next location in strArray
BR	TakeInput		;Keep on taking the the digits as input
EndOfInput
AND	R0, R0, #0		;R0 = 0 
STR	R0, R5, #0		;NULL terminate it
ADD	R1, R3, #0		;Set the parameter i.e. the address of strArray containing the input number in ascii formated string
JSR	ATOI			;Convert the ascii formatted number to decimal	
STR	R1, R2, #0		;Save the decimal test score in ScoreArray
ADD	R2, R2, #1		;Move on to the next location in ScoreArray
ADD	R4, R4, #-1		;Decrement loop counter
BRP	GetScore		;Keep on getting the test score until all have been provided
JSR	Pop			
ADD	R6, R0, #0		;Restore R6
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R1, R0, #0		;Restore R1
JSR	Pop			
ADD	R7, R0, #0		;Restore R7, return address
RET

;----------------------GET TEST SCORE END------------------------------


;--------------------FIND MAX SCORE SUBROUTINE-------------------------
;Receives two parameters:
	; R1 - Number of test scores
	; R2 - Address of an array containing the test scores	
;Returns max value in R1
;;Preserves all registers except R0, R1

;Start of subroutine
FindMax
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
LDR	R3, R2, #0		;R3 has the first test score
MaxLoop	
ADD	R1, R1, #-1		;Decrement loop counter
BRZ	EndMaxLoop		;End loop if all the test scores have been compared
ADD	R2, R2, #1		;Move on to the next test score 
LDR	R4, R2, #0		;R4 contain the next test score
NOT	R5, R3			;Take two's complement of R3 by first inverting the bits
ADD	R5, R5, #1		;And then adding 1 to it. Now R5 = -R3
ADD	R5, R5, R4		;ADD R4 and -R3 to set the flags to check if need to update our current max, R3
BRNZ	DontUpdateMax		;If R4<=R3, we do not need to update max
ADD	R3, R4, #0		;Else update Max
DontUpdateMax			
BR	MaxLoop			;Repeat the loop
EndMaxLoop			;R3 has the max test score
ADD 	R1, R3, #0		;Place max value in R1
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with Max value in R1

;----------------------FIND MAX SCORE END------------------------------


;--------------------FIND MIN SCORE SUBROUTINE-------------------------
;Receives two parameters:
	; R1 - Number of test scores
	; R2 - Address of an array containing the test scores	
;Returns min value in R1
;Preserves all registers except R0, R1

;Start of subroutine
FindMin
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
LDR	R3, R2, #0		;R3 has the first test score
MinLoop	
ADD	R1, R1, #-1		;Decrement loop counter
BRZ	EndMinLoop		;End loop if all the test scores have been compared
ADD	R2, R2, #1		;Move on to the next test score 
LDR	R4, R2, #0		;R4 contain the next test score
NOT	R5, R3			;Take two's complement of R3 by first inverting the bits
ADD	R5, R5, #1		;And then adding 1 to it. Now R5 = -R3
ADD	R5, R5, R4		;ADD R4 and -R3 to set the flags to check if need to update our current min, R3
BRZP	DontUpdateMin		;If R4>=R3, we do not need to update min
ADD	R3, R4, #0		;Else update Min
DontUpdateMin			;Repeat the loop
BR	MinLoop		
EndMinLoop			;R3 has the min test score
ADD 	R1, R3, #0		;Place min value in R1
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with Min value in R1

;----------------------FIND MIN SCORE END------------------------------


;--------------------FIND AVG SCORE SUBROUTINE-------------------------
;Receives two parameters:
	; R1 - Number of test scores
	; R2 - Address of an array containing the test scores	
;Returns avg value in R1
;Preserves all registers except R0, R1

;Start of subroutine
FindAverage
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
ADD	R5, R1, #0		;Save arraysize
AND 	R3, R3, #0		;R2 will store the sum of all the test scores		
AvgLoop
LDR	R4, R2, #0		;Get the test score
ADD	R3, R3, R4		;Accumulate it
ADD	R2, R2, #1		;Move on to the next test score
ADD	R1, R1, #-1		;Decrement loop counter
BRNP	AvgLoop			;Keep on accumulating until all have been processed
ADD	R1, R3, #0		;Set first parameter i.e. the dividend which is the sum
ADD	R2, R5, #0		;Set second parameter i.e. the divisor which is the arraysize 
JSR	Divide			;Divide sum by total test scores to get the average
ADD	R1, R2, #0		;R2 has the average test score. Save it in R1
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with average in R1

;----------------------FIND AVG SCORE END------------------------------


;--------------------MULTIPLICATION SUBROUTINE-------------------------
;Receives two parameters:
	; R1 - Multiplicand
	; R2 - Muliplier
;Returns their product in R1
;;Preserves all registers except R0, R1

;Start of subroutine
Multiply
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R2, #0		;R0 = R2	
JSR 	Push			;Save R2
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
AND	R3, R3, #0		;R3 will contain the product	
MulLoop
ADD	R1, R1, #0		;Add to set the flags
BRZ	EndMulLoop		;End loop if R1 is zero
ADD	R3, R3, R2		;Keep on adding R2, R1 number of times
ADD	R1, R1, #-1		;Decrement loop counter
BR	MulLoop
EndMulLoop			;R3 has the product
ADD	R1, R3, #0		;Place product in R1
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R2, R0, #0		;Restore R2
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with product in R1 

;-----------------------MULTPLICATION END------------------------------


;----------------------DIVISION SUBROUTINE-----------------------------
;Receives two parameters:
	; R1 - Dividend
	; R2 - Divisor
;Returns quotient in R2, and remainder in R1
;Preserves all registers except R0, R1, R2

;Start of subroutine
Divide
ADD	R0, R7, #0		;R0 = R7	
JSR 	Push			;Save Return address
ADD	R0, R3, #0		;R0 = R3
JSR 	Push			;Save R3
ADD	R0, R4, #0		;R0 = R4
JSR 	Push			;Save R4
ADD	R0, R5, #0		;R0 = R5
JSR 	Push			;Save R5
AND	R3, R3, #0		;R3 will contain the quotient
NOT	R4, R2			;Invert all the bits of R2
ADD	R4, R4, #1		;Add 1 to it. By doing this we have R4 = -R2
DivLoop
ADD	R5, R4, R1		;Set flags
BRN	EndDivLoop		;End subtracting denominator from numerator if num<den
ADD	R1, R1, R4		;Else, keep on subtracting den from num
ADD	R3, R3, #1		;Increment quotient
BR	DivLoop
EndDivLoop			;R3 has the quotient, R1 has the remainder
ADD	R2, R3, #0		;Place quotient in R2
JSR	Pop			
ADD	R5, R0, #0		;Restore R5
JSR	Pop			
ADD	R4, R0, #0		;Restore R4
JSR	Pop			
ADD	R3, R0, #0		;Restore R3
JSR	Pop			
ADD	R7, R0, #0		;Restore Return address
RET				;Return with quotient in R2, and remainder in R1 


;-------------------------DIVISION END---------------------------------


.END
