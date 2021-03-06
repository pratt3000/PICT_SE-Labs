      section .bss
              pos_count resb 1
              neg_count resb 1
    	%macro display 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro


        section .data
        array: dq 1,-2,3,-4,5,-6,7,8,-9,10
        count: equ 10
        Msg1 db 'No. of positive elements : '           ;Ask the user to enter a number
        len1 equ $-Msg1                              ;The length of the message
        Msg2 db 'No. of negative elements : '           ;Ask the user to enter a number
        len2 equ $-Msg2                              ;The length of the message
	newline db " ",10
	newlen equ $-newline 
        
     section .text
        
    global _start
    _start:
    mov rsi,array                                         ;copying base address of array in rsi
    mov r8,00h                                            ;initializing register for positive numbers
    mov r9,00h                                            ;initializing register for negative numbers
    mov rdx, count
   
     l11:
        mov rax,[rsi]
        add rax,0h                                             ;condition for js, checks sign bit
        js l1
        inc r8                                                 ;positive increment  
        jmp l
     l1:
        inc r9                                                 ;negative increment
     l:
        add rsi,8
        dec rdx
        jnz l11

   cmp r8,09h
   jbe next1
   add r8,07h
next1:  add r8,30h                                                   ;converting to ascii value
   mov [pos_count],r8                                              ;storing no. of positive numbers in pcount
   cmp r9,09h
   jbe next2
   add r9,07h
next2: add r9,30h
   mov [neg_count],r9                                               ;storing no. of negative numbers in ncount

   display Msg1,len1
   display pos_count,1
   display newline,newlen
   display Msg2,len2
   display neg_count,1
   display newline,newlen
     
 exit: 
    nop
    mov rax, 60
    mov rdi, 0
    syscall
