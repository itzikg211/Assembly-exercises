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
;;rotating eax:
    ;;setting value of eax
    mov eax, 0aabbccddh
    ;;copy eax to ebx register
    mov ebx, eax
    ;;set eax to be zero
    xor eax, eax
    mov edx, 0 ;;initializing the counter of our loop
    mov ecx, 0h ;;setting ecx to be 0. This register stores the number of rotations we should do.
myloop:
    ror ebx, 08h ;;rotate the number 8 (one byte) times.
    mov edi, ebx ;;copy the rotated number
    and edi, 0ff000000h ;;save only the first byte (make the rest be zero)
    ror edi, cl ;;rotate the saved byte to the right place
    add ecx, 08h ;;increase ecx with the size of one byte for the next iteration.
    or eax, edi ;;update eax with the byte in the new place
    inc edx ;;increase edx (the counter)
    cmp edx, 4 ;;compare edx to 4 (the number of iterations we run in the loop)
    jb myloop ;;if edx < 4 jump to myloop
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
