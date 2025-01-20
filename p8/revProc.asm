; NAME : Louisa Houser
; Assignment : P8 - Reverse Array
; Purpose: To be given three arrays and reverse each one using methods and practice pushing arrays
; Date : 11/08/23


SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

array1: dd      1,2,3,4,5
len1:   EQU     ($-array1)


array2: dd      -10, -9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9
len2:   EQU     ($-array2)


array3: dd  0,10,20,30,40,50,60,70,80,90
  dd  100,110,120,130,140,150,160,170,180,190
  dd  200,210,220,230,240,250,260,270,280,290
  dd  300,310,320,330,340,350,360,370,380,390
  dd  400,410,420,430,440,450,460,470,480,490,500
len3:   EQU     ($-array3)

storeOne: dd 0

SECTION .bss
; define uninitialized data here

SECTION .text
global _main
_main:

	;---- CALL FIRST ARRAY ----
        mov eax, array1
        mov ecx, len1
	mov esi, eax		; store eax to later use when popping stack
	mov edi, ecx		; store ecx to later use when popping stack
	call reverse		; call reverse function below

	;---- CALL SECOND ARRAY ----
	mov eax, array2
	mov ecx, len2
        mov esi, eax		; store eax to later use when popping stack
        mov edi, ecx		; store ecx to later use when popping stack
	call reverse		; call reverse function below

	;---- CALL THIRD ARRAY ----
	mov eax, array3
	mov ecx, len3
        mov esi, eax		; store eax to later use when popping stack
        mov edi, ecx		; store ecx to later use when popping stack
	call reverse		; call reverse function below

	jmp lastBreak		; jump to lastBreak so it does not run through functions again

;------------------------------
;	REVERSE FUNCTION
;------------------------------
reverse:

	pushTop:
	 	push DWORD [eax]	; push each value of array
        	add eax, 4		; increase index of array
		sub ecx, 3		; subtract ecx by 3 because len is bits, so rather than divide by 4, I can subtract by 3 and then let the loop method subtract the other 1
        	loop pushTop	

	mov ecx, edi			; get back to beginning of the array
	mov eax, esi			; get back to beginning of array

	popTop:
 		pop DWORD [eax]		; pop each value that was pushed
 	      	add eax, 4		; increase index of array
		sub ecx, 3		; same thing as above
       		loop popTop	
	
	xor eax, eax			; precautionary measures for next loop through reverse
	xor ecx, ecx		

	ret				; return to where reverse method was called

lastBreak:


; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

