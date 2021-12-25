; ============================================================
; What we want to write on the console (for size = 5):
;     *
;    ***
;   *****
;  *******
; *********
; ============================================================

            global      _start

            section     .text
_start:     mov         rbp, 1                 ; rbp is the line counter
            mov         rbx, 1                 ; rbx is the char index in the line
            mov         r12, size-1            ; r12 is the index of last blank space in a line
            mov         r13, size              ; r13 is the index of last star char in a line
            call        row                    ; execute label row

print_b:    inc         rbx                    ; increment char counter by one
            mov         rax, 1                 ; syscall 1 is write
            mov         rdi, 1                 ; fd 1 is stdout
            mov         rsi, space             ; address of char to write
            mov         rdx, 1                 ; count, number of bytes to write
            syscall                            ; write syscall
            call        row                    ; execute label row

print_s:    inc         rbx                    ; increment char counter by one
            mov         rax, 1                 ; syscall 1 is write
            mov         rdi, 1                 ; fd 1 is stdout
            mov         rsi, draw              ; address of char to write
            mov         rdx, 1                 ; count, number of bytes to write
            syscall                            ; write syscall
            call        row                    ; execute label row (here, this is not necessary)

row:        cmp         rbx, r12               ; compare char counter and index of last blank space
            jle         print_b                ; jump to print_b if it is <=

            cmp         rbx, r13               ; compare char counter and index of last star char
            jle         print_s                ; jump to print_s if it is <=

            mov         rax, 1                 ; syscall 1 is write
            mov         rdi, 1                 ; fd 1 is stdout
            mov         rsi, bline             ; address of string to write
            mov         rdx, 1                 ; count, number of bytes to write
            syscall                            ; write syscall
            
            mov         rbx, 1                 ; reset char counter
            inc         rbp                    ; increment line counter
            inc         r13                    ; increment index of last star
            dec         r12                    ; decrement index of last blank space
            cmp         rbp, size              ; compare counter with size
            jle         row                    ; jump to row if counter <= size
            
exit:       mov         rax, 60                ; syscall 60 is exit
            mov         rdi, 0                 ; exit status 0
            syscall                            ; exit syscall

            section     .data
size:       equ         20                     ; piramid size
draw:       db          '*'                    ; char to draw
space:      db          ' '                    ; empty string of one char
bline:      db          `\n`                   ; line break
