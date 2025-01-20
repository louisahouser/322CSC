; NAME: 	Louisa Houser
; Assignment:	Program 6 - Matrix Management
; Purpose: 	Given a matrix, go through the rows and columns and add each value and then take the RowSums and ColSums, and add the value to a grand sum.
; Date:		10/27/23

;ROWS: EQU 3
;COLS: EQU 2

ROWS: EQU 5
COLS: EQU 7

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

;MyMatrix: 	dd	1,   2
;	    	dd	4,   -2
;		dd     -10,  8

MyMatrix: 	dd	 1,  2,  3,  4,  5,  6,  7
	    	dd	 8,  9, 10, 11, 12, 13, 14
		dd	15, 16, 17, 18, 19, 20, 21
		dd	22, 23, 24, 25, 26, 27, 28
		dd	29, 30, 31, 32, 33, 34, 35

SECTION .bss
; define uninitialized data here

RowSums: RESD ROWS
ColSums: RESD COLS
Sum: 	 RESD 1

SECTION .text
global _main
_main:

;--------------------------------------------------------------
; ADD UP ROWS AND COLUMNS
;--------------------------------------------------------------

mov ecx, ROWS ; ecx holds rows size

xor eax, eax  ; set eax register to 0
xor edx, edx  ; set edx register to 0
xor esi, esi  ; set esi register to 0
xor edi, edi  ; set edi register to 0

rowLoop:
	mov eax, ecx				; save ecx value in eax
	mov ecx, COLS			 	; move rows size into ecx for colLoop	
	xor ebx, ebx				; empty ebx before entering rowLoop
	colLoop:
		mov edi, [MyMatrix + esi]	; move mm value into edi 
		add [RowSums + edx], edi   	; edx holds place of row sum
		add [ColSums + ebx], edi   	; ebx holds place of col sum
		add [Sum], edi			; increase total of whole matrix
		add ebx, 4			; increase ColSum value
                add esi, 4                      ; increase placement in entire array by 4 because 
		loop colLoop 			; decrement ecx, if != 0, go to colLoop
	add edx, 4				; go to next value in RowSums array
	mov ecx, eax				; move the old ecx value back into ecx
	loop rowLoop				; decrement ecx, if != 0, go to rowLoop


lastBreak:


;-----------------------------------




; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

