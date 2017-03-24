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
    mov ecx, 100 ;;number of iterations
    xor eax, eax ;;this is our counter, set it to be 0
adder:
    add eax, ecx ;; eax = eax + ecx (eax+=i)
    loop adder ;;going back to the loop
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
