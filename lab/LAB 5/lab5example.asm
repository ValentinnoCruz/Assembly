

.ORIG x3000

LDI R1, X		
LDI R2, Y		
NOT R4, R2		
ADD R4, R4, #1		
ADD R3, R1, R4		
STI R3, XMY		
ADD R4, R1, #0		
BRzp ZPX		
NOT R4, R4		
ADD R4, R4, #1		

ZPX			
STI R4, ABSX		
ADD R5, R2, #0		
BRzp ZPY		
NOT R5, R5		
ADD R5, R5, #1		

ZPY			
STI R5, ABSY		
NOT R7, R5		
ADD R7, R7, #1		
ADD R6, R4, R7		
BRp POS			
BRz ZERO		
BRn NEG			

POS			
AND R6, R6, x0		
ADD R6, R6, #1		
STI R6, Z		
HALT			

ZERO			
AND R6, R6, x0		
STI R6, Z		
HALT			

NEG			
AND R6, R6, x0		
ADD R6, R6, #2		
STI R6, Z		
HALT			

X .FILL x3120		
Y .FILL x3121		
XMY .FILL x3122		
ABSX .FILL x3123	
ABSY .FILL x3124	
Z .FILL X3125		
.END			 