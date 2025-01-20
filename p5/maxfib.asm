; NAME : Louisa Houser
; Assignment : Program 5 - Max Fibonacci Sequence
; Description: Create a fibonacci sequence by entering the first two elements and then loop to create the rest and find out what the max fibonnaci number is, and how many sequences it took.
;Date : October 16, 2023
; Etc...

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

SECTION .bss
; define uninitialized data here

Fibs:     RESD 16
MaxFib:   RESD 1
FibCount: RESW 1

SECTION .text
global _main
_main:

; put your code here.
mov DWORD[Fibs], 0      ; assign 0 to location of index 0
mov DWORD[Fibs + 4], 1  ; assign 1 to location of index 1

mov eax, 4		; set eax to 4 
mov WORD[FibCount], 2 	; move two into the FibCount to account for the two numbers we manually added

fibonacciLoop:
	mov ebx, [Fibs + eax]		 ; move last value of array into ebx
	mov edx, ebx         		 ; move ebx value into edx to save for later
	sub eax, 4	     		 ; subtract 4 from eax to later get value stored in the previous element
	add ebx, [Fibs + eax]		 ; add second to last value of array into ebx
	jc foundMax			 ; jump to stop if carry is set by add operation
	add eax, 8           		 ; move eax back to next element slot in the array
	mov [Fibs + eax], ebx		 ; move ebx value into the next element slot in the array
	inc WORD[FibCount]		 ; increase FibCount
    	jmp fibonacciLoop		 ; jump to the beginning of the loop
	

foundMax:
	; we do not need to increase FibCount because we just found the max
	mov [MaxFib], edx		; move last value into MaxFib

lastBreak:

; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

