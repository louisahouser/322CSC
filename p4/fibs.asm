; NAME : Louisa Houser
; Assignment : Program 4 - Fibonacci Sequence
; Description: Create a fibonaccie sequence by entering the first two elements and then loop to create the rest.
; Date : October 11, 2023
; Etc...

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

SECTION .bss
; define uninitialized data here

Fibs:   RESD 16    ; unitialized array of size double words



SECTION .text
global _main
_main:

; put your code here.
mov eax, 0
mov [Fibs], eax      ; assign 0 to location of index 0
mov eax, 1
mov [Fibs + 4], eax  ; assign 1 to location of index 1
mov eax, 0           ; assign 0 to eax before loop begins

mov ecx, 2 ; counter
fibonacciLoop:
    mov ebx, [Fibs + eax]   ; move current value into ebx 
    sub eax, 4
    add ebx, [Fibs + eax]
    add eax, 8              ; increase eax by 4
    add [Fibs + eax], ebx   ; add value of ebx to new current value
    add ecx, 1              ; increase counter 
    cmp ecx, 16             ; compare counter    
    jle fibonacciLoop       ; loop again if less than 16

lastBreak:
; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

