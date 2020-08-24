; Tic Tac Toe DOS program
; by Noah Abrigo

.model small
.stack 100h
.386
.data
	board   db '1','2','3','4','5','6','7','8','9' ; initializing a byte array of 9 for display
	player1 db 0,0,0,0,0,0,0,0,0 ; initializing a byte array of 9 for player 1
	player2 db 0,0,0,0,0,0,0,0,0 ; initializing a byte array of 9 for player 2
	x       db 'x' ; finds the ascii character number for X
	o       db 'o' ; finds the ascii character number for O
	choice  db ?   ; the players' choice
	
	welcome db 10,13,'Lets play a game of Tic Tac Toe!','$' ; welcome message
	copy    db 10,13,'Created by Noah Abrigo 2019','$'  ; copyright info
	prompt1 db 10,13,'[PLAYER 1]','$' ; prompt for player 1
	prompt2 db 10,13,'[PLAYER 2]','$' ; prompt for player 2
	pick    db ' Type a number between 1 and 9: ','$'
	three   db 10,13,'Three in a row!','$' ; declares three in a row
	win1    db 10,13,'Player 1 is the winner!','$' ; player 1 win dialogue
	win2    db 10,13,'Player 2 is the winner!','$' ; player 2 win dialogue
	again   db 10,13,'Want to play again? (y/n): ','$'
	newline db 10,13,'$'

	tlc db 218 ; Top left corner ascii character
	trc db 191 ; Top right corner ascii character
	blc db 192 ; Bottom left corner ascii character
	brc db 217 ; Bottom right corner ascii character
	reg db 179 ; normal line ascii character
	row db 196 ; row ascii character
	tcross db 194 ; top cross ascii character
	bcross db 193 ; bottom cross ascii character
	cross  db 197 ; middle cross ascii character
	lcross db 195 ; left side cross ascii character
	rcross db 180 ; right side cross ascii character
	space  db 0   ; space ascii character
	
.code

	include macros.asm ; includes all the macros

	mov ax,@data
	mov ds,ax
	
	start:
		reset player1
		reset player2
		; Resets the display board with the numbers
		modify board, 1, '1'
		modify board, 2, '2'
		modify board, 3, '3'
		modify board, 4, '4'
		modify board, 5, '5'
		modify board, 6, '6'
		modify board, 7, '7'
		modify board, 8, '8'
		modify board, 9, '9'

	p1:
		clearScr       ; clears the screen
		changeScr 1fh  ; changes screen color to blue bg white text
		
		prtStr welcome
		prtStr copy
		
		prtStr newline ; prints a new line

		disp board     ; displays the board

		prtStr newline ; prints a new line

		prtStr prompt1  ; prints the player 1 prompt to DOS screen
		prtStr pick
		readChar choice ; takes input from user and stores value in choice

		modify player1, choice, 1 ; puts a value of 1 in player1 array
		modify player2, choice, 0 ; puts a value of 0 in player2 array
		modify board, choice, x   ; puts an ascii char X in board array

		jmp p1check ; jumps to p1check label


	p2:
		clearScr       ; clears the screen
		changeScr 4fh  ; changes screen color to red bg white text
		
		prtStr welcome
		prtStr copy
		
		prtStr newline ; prints a new line

		disp board     ; displays the board

		prtStr newline ; prints a new line
		
		prtStr prompt2 ; prints the player 2 prompt to DOS screen
		prtStr pick
		readChar choice ; takes input from user and stores value in choice

		modify player2, choice, 1 ; puts a value of 1 in player2 array
		modify player1, choice, 0 ; puts a value of 0 in player1 array
		modify board, choice, o   ; puts an ascii char O in board array

		jmp p2check ; jumps to p2check label

	p1check:

		; finds three in a row top row
		mov cx, 0       ; moves 0 into CX register
		lea si, player1 ; find starting address of array with index addressing using source index
		mov bx, 0       ; moves 0 into BX register
		
		mov ax, [si+bx] ; moves the value at array into AX
		add cl, al      ; adds 0 or 1 to cl

		mov bx, 1       ; move 1 into bx
		mov ax, [si+bx] ; store value at si+bx into ax
		add cl, al      ; adds 1 or 0 into CX register

		mov bx, 2       ; moves 2 into bx
		mov ax, [si+bx] ; store value at si+bx into ax
		add cl, al      ; adds 0 or 1 to cl

		cmp cl, 3       ; if cl is equal to 3
		je p1w			; jump to player 1 win dialogue

		; finds three in a row middle row
		mov cx, 0
		mov bx, 3
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 5
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row bottom row
		mov cx, 0
		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		mov bx, 7
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row first column
		mov cx, 0
		mov bx, 0
		mov ax, [si+bx]
		add cl, al

		mov bx, 3
		mov ax, [si+bx]
		add cl, al

		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row middle column
		mov cx, 0
		mov bx, 1
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 7
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row last column
		mov cx, 0
		mov bx, 2
		mov ax, [si+bx]
		add cl, al

		mov bx, 5
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row diagnal
		mov cx, 0
		mov bx, 0
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		; finds three in a row diagnal
		mov cx, 0
		mov bx, 2
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p1w

		jmp p2

	p2check:
		mov cx, 0
		lea si, player2
		mov bx, 0
		
		mov ax, [si+bx]
		add cl, al

		mov bx, 1
		mov ax, [si+bx]
		add cl, al

		mov bx, 2
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 3
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 5
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		mov bx, 7
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 0
		mov ax, [si+bx]
		add cl, al

		mov bx, 3
		mov ax, [si+bx]
		add cl, al

		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 1
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 7
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 2
		mov ax, [si+bx]
		add cl, al

		mov bx, 5
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 0
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 8
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		mov cx, 0
		mov bx, 2
		mov ax, [si+bx]
		add cl, al

		mov bx, 4
		mov ax, [si+bx]
		add cl, al

		mov bx, 6
		mov ax, [si+bx]
		add cl, al

		cmp cl, 3
		je p2w

		jmp p1

	p1w:
		clearScr      ; clears the screen
		changeScr 1fh ; changes screen color to blue bg white text
		prtStr three
		prtStr win1   ; prints player 1 win dialogue
		prtStr newline
		disp player1    ; displays the board
		jmp replay

	p2w:
		clearScr      ; clears the screen
		changeScr 4fh ; changes screen color to red bg white text
		prtStr three
		prtStr win2   ; prints player 1 win dialogue
		prtStr newline
		disp player2    ; displays the board
		jmp replay
		
	replay:
		prtStr again
		readAsc choice
		cmp choice, 'y'
		je start
		cmp choice, 'n'
		je exit
		
		jne replay
	
	exit:
		clearScr
		return
	

end