            global      _start

            section     .text
_start:     mov         rax, 1             ; syscall 1 is write
            mov         rdi, 1             ; fd ("file descriptor") 1 is stdout
            mov         rsi, mssg0         ; address of string to output
            mov         rdx, 6             ; count, number of bytes to write
            syscall
            
            mov         rax, 0             ; syscall 0 is read
            mov         rdi, 0             ; fd 0 is stdin
            mov         rsi, name          ; address of string to read
            mov         rdx, 20            ; count, number of bytes to read
            syscall

            mov         rdi, 0
            mov         [name+21], rdi     ; save line break after name address
            mov         rax, 1             ; syscall 1 is write
            mov         rdi, 1             ; fd 1 is stdout
            mov         rsi, mssg1         ; string to output
            mov         rdx, 27+1          ; count, number of bytes to write
            syscall
            
            mov         rax, 60            ; syscall 60 is exit
            xor         rdi, rdi           ; exit status 0
            syscall

            section     .data
mssg0:      db          "Name: "           ; string to output
mssg1:      db          "Hello, "          ; string to output

            section     .bss
name:       resb        20                 ; name to read
