prtStr macro string
		lea dx, string ; set dx to address of prompt
		mov ah, 09h           ; set high order byte of ax to have 9 (DOS write string operation)
		int 21h               ; interrupt to DOS
endm

readChar macro num
	mov ah,1		;high order byte set to 1 invoke ascii char read
	int 21h			; DOS interrupt
	sub al,'0'		;strip ascii to get decimal digit
	mov num,al
endm

readAsc macro num
	mov ah,1		;high order byte set to 1 invoke ascii char read
	int 21h			; DOS interrupt
	mov num,al
endm
 
write macro y
	mov dl,y
	add dx,'0'
	mov ah,2		;high order byte set to 2 to invoke ascii char write
	int 21h
endm

wascii macro y ; writes ascii char to DOS
	mov dl, y
	mov ah, 2
	int 21h
endm

return macro 
	mov ah,4ch		; high order byte of has 4c hex to return to DOS
	int 21h			; DOS interrupt
endm

clearScr macro
	mov ax,2
	int 10h
endm

changeScr macro scr
	mov ah,6       ; Scroll up function
	mov al,0       ; Clear entire screen
	mov cx,0       ; Upper left corner CH=row, CL=column
	mov dx, 184fh  ; lower right corner DH=row(25), DL=column(80) 
	mov bh, scr    ; Color of screen
	int 10h
endm

disp macro arry ; draws a 9 x 9 array in table format
	mov ax, 0 ; resets AX
	mov bx, 0 ; resets BX

	; table styling
	wascii 10
	wascii 13
	wascii tlc
	wascii row
	wascii row
	wascii row
	wascii tcross
	wascii row
	wascii row
	wascii row
	wascii tcross
	wascii row
	wascii row
	wascii row
	wascii trc
	wascii 10
	wascii 13

	; table styling
	wascii reg
	wascii space

	lea bx, arry ; finds starting address of array and loads into BX
	mov ax, [bx] ; moves value at byte of array into AX
	wascii al    ; writes the ascii character to DOS

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx       ; increments BX
	mov ax, [bx] ; moves value at byte of array into AX
	wascii al    ; writes the ascii character to DOS

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg

	; table styling
	wascii 10
	wascii 13
	wascii lcross
	wascii row
	wascii row
	wascii row
	wascii cross
	wascii row
	wascii row
	wascii row
	wascii cross
	wascii row
	wascii row
	wascii row
	wascii rcross
	wascii 10
	wascii 13

	; table styling
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg

	; table styling
	wascii 10
	wascii 13
	wascii lcross
	wascii row
	wascii row
	wascii row
	wascii cross
	wascii row
	wascii row
	wascii row
	wascii cross
	wascii row
	wascii row
	wascii row
	wascii rcross
	wascii 10
	wascii 13

	; table styling
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg
	wascii space

	inc bx
	mov ax, [bx]
	wascii al

	; table styling
	wascii space
	wascii reg

	; table styling
	wascii 10
	wascii 13
	wascii blc
	wascii row
	wascii row
	wascii row
	wascii bcross
	wascii row
	wascii row
	wascii row
	wascii bcross
	wascii row
	wascii row
	wascii row
	wascii brc
	wascii 10
	wascii 13
endm

modify macro arry, choice, symb ; modifies array
	mov cx, 0       ; moves 0 into CX
	mov cl, choice  ; moves user choice into Low Order Byte of CX
	dec cl          ; decrements cl, in order to correct for array
	lea si, arry    ; find starting address of array
	mov bx, 0       ; mov 0 into bx
	mov ax, [si+bx] ; mov value stored at array into AX
	add bl, cl      ; add choice into Low Order Byte of BX
	mov ax, [si+bx] ; mov value at the spot in choice into AX
	mov al, symb    ; mov symb value into al
	mov [si+bx], ax ; store value in AX into the spot in the array
endm

reset macro arry ; sets all values in 9 array to zero
modify arry, 1, 0
modify arry, 2, 0
modify arry, 3, 0
modify arry, 4, 0
modify arry, 5, 0
modify arry, 6, 0
modify arry, 7, 0
modify arry, 8, 0
modify arry, 9, 0
endm

