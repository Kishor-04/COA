data segment
msg db 10,13,"Multiplication is : $"
no1 dw 1000h
no2 dw 2000h
ansl dw ?
ansh dw ?
data ends

code segment
assume cs : code, ds : data
start:  
 	mov ax,data
	mov ds,ax

	lea dx,msg
	mov ah,09h
	int 21h

	mov ax,[no1]
	mov cx,[no2]
	mul cx
	mov [ansh],dx
	mov [ansl],ax

	mov bx,[ansh]
	call display
	mov bx,[ansl]
	call display

	mov ah,4ch
	int 21h

display proc near
        mov ch, bh
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down4
        add ch, 07h
down4 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down5
        add ch, 07h
down5 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov bh, bl
        mov ch, bh
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down6
        add ch, 07h
down6 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down7
        add ch, 07h
down7 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        ret
        display endp
mov ah,4ch
int 21h
code ends
end start
