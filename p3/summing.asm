; NAME : Louisa Houser
; CSC 322 <10/01/23>
; P3 - Summing Arrays
; Program will sum three arrays of signed integers and then sum of all three together

SECTION .data
; define data/variables here.  Think DB, DW, DD, DQ

bArray:		DB		1,-2,3,-4,5
wArray:		DW		100,200,300,400,500
dArray:		DD		-322,-322h,-322q,-1833,-1833h
bArraySum:	DB		0
wArraySum:	DW		0
dArraySum:	DD		0
grandTotal:	DD		0


SECTION .bss
; define uninitialized data here

SECTION .text
global _main
_main:

mov al, [bArray]	; move first value of bArray into al register
add al, [bArray + 1]    ; add second value to al reg.
add al, [bArray + 2]    ; add third value to al reg.
add al, [bArray + 3]	; add fourth value to al reg.
add al, [bArray + 4]	; add last value to al reg.
mov [bArraySum], al	; move final sum of first array that is stores in al to the bArraySum

mov ax, [wArray]        ; move first value of wArray into ax register
add ax, [wArray + 2]    ; add second value to ax reg.
add ax, [wArray + 4]    ; add third value to ax reg.
add ax, [wArray + 6]    ; add fourth value to ax reg.
add ax, [wArray + 8]    ; add last value to ax reg.
mov [wArraySum], ax       ; move final sum of second array that is stores in ax to the wArraySum

mov eax, [dArray]        ; move first value of dArray into eax register
add eax, [dArray + 4]    ; add second value to eax reg.
add eax, [dArray + 8]    ; add third value to eax reg.
add eax, [dArray + 12]    ; add fourth value to eax reg.
add eax, [dArray + 16]    ; add last value to eax reg.
mov [dArraySum], eax       ; move final sum of third array that is stores in eax to the dArraySum

mov [grandTotal], eax	; move value of eax into grandTotal
movsx eax, WORD[wArraySum]	; move signed wArraySum to eax
add [grandTotal], eax	; add value of eax to grandTotal
movsx eax, BYTE[bArraySum]	; move signed bArraySum to eax
add [grandTotal], eax	; move value of eax to grandTotal

; label to help with debugging
lastBreak:

; Normal termination code
mov eax, 1
mov ebx, 0
int 80h

