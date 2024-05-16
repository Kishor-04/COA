data segment
msg1 db 10,13,"Enter Number: $"
msg2 db 10,13,"No is:  $"
msg3 db 10,13,"Additon is: $"
no dw 05h dup(0)
n db 30h
n1 db 30h

data ends

code segment
assume cs : code, ds : data

start:  mov ax, data
        mov ds, ax
	mov si,0000h

back12:
        lea dx, msg1
        mov ah, 09h
        int 21h

	mov dl,[n]
	mov ah,02h
	int 21h
  
        call take

	mov [no+si],bx
	inc si
	inc si
	inc [n]
	cmp [n],34h
	jbe back12

	mov si,0000h
	
	mov cl,00h
	mov ch,04h
clc
	mov si,0000h
	mov ax,[no+si]
up1:
	inc si
	inc si
	add ax,[no+si]
	jnc down20
	inc cl
down20:
	dec ch
	jnz up1

	mov bx,ax

	lea dx, msg3
        mov ah, 09h
        int 21h
	
	mov dl,cl
	cmp dl,09h
	jbe down21
	add dl,07h
down21:
	add dl,30h
	mov ah,02h
	int 21h

	call display

        mov ah, 4ch  ; Terminating the execution of the main program
        int 21h

take proc near   ; Start of procedure

        mov ah, 01h           ; consider that user wants to enter "2F" so he will enter 2 ie 32 will come in  al
        int 21h
      cmp al, 39h         ; in al 32 will be there.
        jbe down
        sub al, 07h

down :  sub al, 30h    ; so from al 30 will be subtracted so the al=02 h
        mov cl, 04h   ; But the digit is MSB, so we need to rotate it by 4 location. The rotation count will be always in cl register
        rol al, cl     ; after this al= 20h

        mov bh, al   ; bh=20

        mov ah, 01h  ; taking the second digit ie 'F'
        int 21h
        cmp al, 39h   ; al=46h
        jbe down1
        sub al, 07h ; al will be subtrated with 37h

down1 : sub al, 30h ; after this al=0Fh
        add bh, al  ; so bh= bh+al=20+0F=2Fh  

	mov ah, 01h           ; consider that user wants to enter "2F" so he will enter 2 ie 32 will come in  al
        int 21h
        cmp al, 39h         ; in al 32 will be there.
        jbe down2
        sub al, 07h

down2 : sub al, 30h    ; so from al 30 will be subtracted so the al=02 h
        mov cl, 04h   ; But the digit is MSB, so we need to rotate it by 4 location. The rotation count will be always in cl register
        rol al, cl     ; after this al= 20h

        mov bl, al   ; bh=20

        mov ah, 01h  ; taking the second digit ie 'F'
        int 21h
        cmp al, 39h   ; al=46h
        jbe down3
        sub al, 07h ; al will be subtrated with 37h

down3 : sub al, 30h ; after this al=0Fh
        add bl, al  ; so bh= bh+al=20+0F=2Fh  
        
        ret
        take endp   ; End of procedure

display proc near   ; Start of procedure

        mov ch, bh    ; we want to display "2F" . The number is in bh which we are storing in ch="2F"
        and ch, 0f0h  ; as we want "2". So will mask the "F" by anding the 2f with "F0" ie 2F and F0= 20h
        mov cl, 04h  ; as after amsking the number is 20, but we want "2", so we need to rotate it by 4 location. The rotation count will be always in cl
        rol ch, cl
        cmp ch, 09h  ; comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down4
        add ch, 07h

down4 :
        add ch, 30h  ; In oue case 30 will be added to 02 and ch=32h
        mov dl, ch   ; the number to be displayed should be in dl. Therefore dl=32h
        mov ah, 02h  ; code for displaying the ASCII number on monitor
        int 21h
        mov ch, bh   ; Know for the second digit ie "F"
        and ch, 0fh   ;as we want "F". So will mask the "2" by anding the 2f with "0F" ie 2F and 0F= 0Fh  
        cmp ch, 09h  ;comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down5
        add ch, 07h

down5 : add ch, 30h ;In oue case 37 will be added to 0F and ch=46h
        mov dl, ch
        mov ah, 02h
        int 21h

	mov ch, bl    ; we want to display "2F" . The number is in bh which we are storing in ch="2F"
        and ch, 0f0h  ; as we want "2". So will mask the "F" by anding the 2f with "F0" ie 2F and F0= 20h
        mov cl, 04h  ; as after amsking the number is 20, but we want "2", so we need to rotate it by 4 location. The rotation count will be always in cl
        rol ch, cl
        cmp ch, 09h  ; comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down6
        add ch, 07h

down6 :
        add ch, 30h  ; In oue case 30 will be added to 02 and ch=32h
        mov dl, ch   ; the number to be displayed should be in dl. Therefore dl=32h
        mov ah, 02h  ; code for displaying the ASCII number on monitor
        int 21h

        mov ch, bl   ; Know for the second digit ie "F"
        and ch, 0fh   ;as we want "F". So will mask the "2" by anding the 2f with "0F" ie 2F and 0F= 0Fh  
        cmp ch, 09h  ;comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down7
        add ch, 07h

down7 : add ch, 30h ;In oue case 37 will be added to 0F and ch=46h
        mov dl, ch
        mov ah, 02h
        int 21h
       

        ret
        display endp   ; End of procedure

code ends
end start