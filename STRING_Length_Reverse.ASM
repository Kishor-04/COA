data segment
msg db 10,13, "Enter a string: $"
msg1 db 10,13, "String is: $"
msg2 db 10,13, "Length of String is: $"
line db 10,13, "$"
msg3 db 10,13, "reverse of string is :$"
str db 25 dup("$")
str2 db 25 dup("$")

data ends

code segment
assume cs : code, ds : data
start: mov ax, data
mov ds, ax

lea dx, msg
mov ah, 09h
int 21h

mov ah, 0Ah
lea dx, str
int 21h

lea dx, msg1
mov ah, 09h
int 21h

lea dx, str+2
mov ah, 09h
int 21h

lea dx, msg1
mov ah, 09h
int 21h

mov dl,[str+1]
add dl, 30h
mov ah, 02h
int 21h

lea dx, msg3
mov ah, 09h
int 21h

lea dx, line
mov ah, 09h
int 21h

mov di, 00h
mov cl, [str+1]
mov si, cx
add si, 02h
up:     mov dl, [str+si]
        mov ah, 02h
mov [str2+di], dl
inc di
dec si
cmp si, 01h
jne up

lea dx, str2
mov ah,09h
int 21h

mov ah, 04ch
int 21h

code ends
end start
