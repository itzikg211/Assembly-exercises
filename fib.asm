.486
.model flat,stdcall
option casemap :none  ;case sensitive

;;_____________________MASM MACROS_______________________
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
;;_____________________DATA_________________________
.data
;;_____________________CODE_______________________
.code
_start:
    mov eax, 07h ;eax = n -> later we calulate fib(n)
    push eax ;pass eax as a parameter to the function
    call fib ;call the fibonacci function
    jmp end_prog ;finish the program

fib:
    push ebp ;store ebp
    mov  ebp,esp ;ebp = esp
    sub esp, 4 ;make space for 1 local variable for the function. It will store the result of fib(n-1)
    mov eax, [ebp+8] ;eax = n (that we got as a parameter)
    cmp eax, 02h ;if n == 2 return 1
    je set_1 ;set return value to be 1
    cmp eax, 01h ;if n == 1 return 1
    je set_1 ;set return value to be 1

    dec eax ;eax = n-1
    push eax ;pass eax as a parameter to fib
    call fib ;call the fibonacci function
    mov [ebp-4], eax ;store in the local variable = fib(n-1)
    pop ebx ;restore the value we passed to fib function into ebx, ebx = n-1
    dec ebx ;decrease 1 from ebx, ebx = n-2
    push ebx ;pass ebx as a parameter to fib function
    call fib ;call the fibonacci function
    add esp, 4 ;we subbed 4 from esp and now we add 4 to it so it will remain the same in the end of the function
    add eax, [ebp-4] ;eax+=local variable -> eax = fib(n-1) + fib(n-2)
    jmp fin_fib ;jump to the end of the function

set_1:
    mov eax, 1 ;eax = 1, return value is 1
fin_fib:
    mov esp, ebp ;restore the address of the beginning of the stack
    pop ebp ;restore ebp
    ret ;return from the function
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
