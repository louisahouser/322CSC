; NAMEi: Louisa Houser
; Assignment: Program 2 - Adding Integers
; Date - 09/19/2023
; Etc...

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

SECTION .bss
; define uninitialized data here

SECTION .text
global _main
_main:

; put your code here.
; #1
mov AX, 0CDBAh;
mov BX, 0CDABh;
add AX, BX;
; #2
mov AX, 0ABCDh;
mov BX, 0ABCDh;
add AX, BX;
; #3
mov AX, 0FAFAh;
mov BX, 0505h;
add AX,BX;
; #4
mov AX, 0F0F0h;
mov BX, 0FF00h;
add AX, BX;
; #5
mov AX, 0D468h;
mov BX, 2B98h;
add AX, BX;
; #6
mov AX, 700Fh;
mov BX, 0FF1h;
add AX, BX;
; #7
mov AX, 1234h;
mov BX, 7654h;
add AX, BX;
; #8
mov AX, 0B0Bh;
mov BX, 0A11Eh;
add AX, BX;
; #9
mov AX, 7654h;
mov BX, 789Ah;
add AX, BX;
; #10
mov AX, 8000;
mov BX, 8000;
add AX, BX;


; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

