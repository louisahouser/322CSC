; NAME: Louisa Houser
; Assignment: P9 - Sort Array
; Procedure: Print out a sequence of N integers ( range of 0-65535), sort them in increasing order, and print them out again. Use a variable sized array of unsigned WORD integers. 
	; SHOULD INCLUDE:
		; - function that is passed an unsigned WORD integer that converts it into a string
		   ;of characters representing that integer. There should be a "print field" in data for
		   ;the function to place the created string. INCLUDE new line after integer
		; - procedure that is passed a pointer to an array of unsinged WORD integers, and the size of
		   ;the array, and then prints the array of unsigned WORD integers, one per line. 
		   ;NEEDS to call convert function once for each integer in the array
		; - procedure that is passed a pointer to an array of unsigned WORD integers, and the size of
		   ;the array, and then sorts the array
		; - MAIN:
			; - clear the screen
			; - print a title for the screen that includes your name
			; - print a header : "Original Array"
			; - call print array procedure
			; - call sort procedure
			; - print a header : "Sorted Array"
			; - call print array procedure 
; Purpose: To get practice sorting, printing, and clearing screens
; Date: 11/17/23

;; print function
%macro prt 2

	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
	popa

%endmacro
;------------------------------------------------------------
;; called on by main and calls convert function to change to string
%macro toString 2

	pusha
	mov ax, %1
	mov edi, %2
	xor dx, dx
	call convert
	popa

%endmacro
;-----------------------------------------------------------

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

cls     db      1bh, '[2J' ; 1bh is escape
clsLen  dd $-cls

; CURSOR FIRST POSITION CONTROL CHARACTER
pos1	db	1bh, '['
row	db	'05'
	db	';'
col	db	'05'
	db	'H'

; ARRAY THAT NEEDS SORTING AND PRINTING
nums:	dw	2000, 3000, 0, 65535, 0, 1, 2, 3, 100
numslen:	EQU	($-nums)

; VARIABLE THAT HOLDS CREATED STRING
printField: dw "     ", 10, 0
changeField: dw "     ", 10, 0
; LABELS THAT WILL BE PRINTED
msg1	db	"----------------", 10, 0
msg1Len	dd	$-msg1

msg2	db	" Original Array ", 10, 0
msg2Len	dd	$-msg2

msg3	db	"----------------", 10, 0
msg3Len	dd	$-msg3

msg4	db	"----------------", 10, 0
msg4Len	dd	$-msg4

msg5	db	"  Sorted Array  ", 10, 0
msg5Len	dd	$-msg5

msg6	db	"----------------", 10, 0
msg6Len	dd	$-msg6


cr:  db 0ah  ;;; carriage return character



;------------------------------------------------------------

SECTION .bss
; define uninitialized data here

nums2: RESD 9
; -----------------------------------------------------------

SECTION .text
global _main
_main:

	;---------------------------;
	;	OG ARRAY PRINT	    ;
	;---------------------------;
	prt cls, [clsLen]
	prt pos1, 0
	prt msg1, [msg1Len]
	prt msg2, [msg2Len]
	prt msg3, [msg3Len]

	mov ecx, numslen
	xor esi, esi
	printArray:
		; CONVERT NUM TO STRING
		toString WORD[nums + esi], printField		; call toString
		prt printField, 14 	
		add esi, 2
		sub ecx, 1
		call resetPrt
	;	push edx
	;	mov edx, [changeField]
	;	mov DWORD[printField], edx
	;	pop edx
		prt cr, 1
		loop printArray

	;---------------------------;
	;	SORTED PRINT	    ;
	;---------------------------;

	; PRINT "SORTED ARRAY", THEN SORT THE ARRAY AND CONVERT IT TO A STRING
	prt msg4, [msg4Len]
	prt msg5, [msg5Len]
	prt msg6, [msg6Len]

	call sort		;; CALL SORT
	mov ecx, numslen
	xor esi, esi
	printArray2:		;; ITERATE THROUGH ARRAY AND CONVERT SORTED TO STRING AND THEN PRINT
                ; CONVERT NUM TO STRING
		toString [nums2 + esi], printField
                prt printField, 14
                add esi, 2
                sub ecx, 1
		call resetPrt
		prt cr, 1
                loop printArray2




lastBreak:

; Normal termination code
mov eax, 1
mov ebx, 0
int 80h


;--------------------------------;
;          sort FUNCTION 	 ;
;--------------------------------;
	
;sort:
;	pusha
;	xor esi, esi
;	mov ecx, numslen
;	xor edi, edi
;	sorting:		;; first loop compares the first element in array to everything else, and then the second element, and then the third, etc
;		pusha
;		mov eax, [nums + esi]
;		mov edx, numslen
;		sub edx, esi
;		mov ecx, edx
;		xor edx, edx
;		secondSort:	;; second loop compares the element in the first loop to each other element in the array. 
				;; if it is smaller it assigns it to min by calling smallerThan
;			mov ebx, [nums + edi]
;			cmp eax, ebx
;			jnc greaterThan
;			mov DWORD[min],ebx
;			mov DWORD[minAdd], 1
;			greaterThan:
;			add edi, 2
;			sub ecx, 1
;			loop secondSort
;		cmp DWORD[minAdd], 1
;		jne noSwap
;		mov edx, [min]
;		mov [nums2 + esi], edx	;; assign min to the element that was looked at in first loop
;		noSwap:
;		popa
;		sub ecx, 1
;		add esi, 2
;		loop sorting		
;	popa
;	ret			;; return to the main


sort:
	pusha
	mov ecx, numslen
	xor esi, esi
	xor edi, edi
	sorting:		;; LOOK AT FIRST ELEMENT AND COMPARE, THEN SECOND, THEN THIRD, ETC
		pusha
		mov eax, [nums + esi]	; MOVE ELEMENT INTO EAX
		mov edx, numslen
		cmp ecx, 1		; IF ECX IS AT ONE IT SHOULD BE SORTED
		je finish		; SO JUMP TO FINISH AND RETURN
		sub edx, esi		; CHANGE ECX AS WE GO THROUGH LOOPS
		mov ecx, edx
		xor edx, edx
		secondSort:		; SECOND SORT COMPARES ELEMENT IN FIRST LOOP TO OTHER ELEMENTS
					; IN THE ARRAY AND SWAPS THEM IF SMALLER
			add edi, 2	;; ADD EDI 2 FROM BEGINNING SO IT WONT LOOK AT FIRST ELEMENT
			mov ebx, [nums + edi]
			cmp eax, ebx	; COMPARE OUTER LOOP ELEMENT TO INSIDE LOOP ELEMENT
			jnc greaterThan	; IF GREATER THAN OUTER LOOP ELEMENT, JUMP TO GREATERTHAN
			mov edx, ebx			;MOV EBX INTO EDX
			mov [nums + edi], eax		;MOV EAX (LARGER #) INTO INNER LOOP SLOT
			mov [nums + esi], edx		;MOV EDX (SMALLER #) INTO OUTER LOOP SLOT
			greaterThan:
			sub ecx, 1 
			loop secondSort
		popa
		sub ecx, 1
		add esi, 2
		loop sorting
		finish:
	popa
	ret





;-------------------------------;
;	toString FUNCTION	;
;-------------------------------;

convert:
	mov bx, 10
	add edi, 8
	top:		;loop through array and assign it its string value
		div bx
		add dx, '0'
		mov [edi], dx
		sub edi, 2
		xor dx, dx
		cmp ax, 0
		jne top
	ret

;------------------------

resetPrt:	;;; reset printfield so numbers don't overlap!!!!
	pusha
	mov ecx, 5
	mov edi, printField
	add edi, 8
resetAgain:
	mov WORD[edi], 0
	sub edi, 2
	loop resetAgain
	popa
	ret
