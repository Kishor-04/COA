data segment
msg1 db 10,13,"Enter the Number: $"
msg2 db 10,13,"Entered number is: $"
n db 30h

data ends

code segment
assume cs:code, ds:data
start:
	mov ax,data
	mov ds,ax

	lea dx,msg1
	mov ah,09h
	int 21h

	call take
	
	lea dx,msg2
	mov ah,09h
	int 21h

	call display

	mov ah,4ch
	int 21h

take proc near
	mov ah,01h
	int 21h

	cmp al,39h
	jbe down
	sub al,07h

down:sub al,30h
	mov cl,04h
	rol al,cl
	
	mov bh,al

	mov ah,01h
	int 21h
	
	cmp al,39h
	jbe down1
	sub al,07h

down1:sub al,30h
	add bh,al
	
	ret
	take endp

display proc near
	mov ch,bh
	and ch,0f0h
	mov cl,04h
	rol ch,cl
	cmp ch,09h
	jbe down2
	add ch,07h

down2:
	add ch,30h
	mov dl,ch
 	mov ah,02h
	int 21h

	mov ch,bh
	and ch,0fh
	cmp ch,09h
	jbe down3
	add ch,07h

down3:
	add ch,30h
	mov dl,ch

	mov ah,02h
	int 21h

	ret 
	display endp

code ends
end start	
	





