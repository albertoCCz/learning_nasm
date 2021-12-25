; ============================================================
; What we want to write on the console (for size = 5):
; *
; **
; ***
; ****
; *****
; ============================================================

            global      _start

            section     .text
_start:     mov         rbp, 1          ; rbp is the line counter
            mov         rbx, 1          ; rbx is the char counter in the line
            call        row

print:      inc         rbx             ; increment char counter by one
            mov         rax, 1          ; syscall 1 is write
            mov         rdi, 1          ; fd 1 is stdout
            mov         rsi, draw       ; address of char to write
            mov         rdx, 1          ; count, number of bytes to write
            syscall

row:        cmp         rbx, rbp        ; compare char counter and line counter
            jle         print           ; jump to print if char counter <= line counter

            mov         rax, 1          ; syscall 1 is write
            mov         rdi, 1          ; fd 1 is stdout
            mov         rsi, bline      ; address of string to write
            mov         rdx, 1          ; count, number of bytes to write
            syscall                     ; write syscall
            
            mov         rbx, 1          ; reset char counter
            inc         rbp             ; increment line counter
            cmp         rbp, size       ; compare counter with size
            jle         row             ; jump to row if counter <= size
            
exit:       mov         rax, 60         ; syscall 60 is exit
            mov         rdi, 0          ; exit status 0
            syscall                     ; exit syscall

            section     .data
size:       equ         40              ; piramid size
draw:       db          '*'             ; char to draw
bline:      db          `\n`            ; line break
