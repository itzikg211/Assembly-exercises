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
    ;;setting values for a,b,c registers
    mov eax, 2
    mov ebx, 9
    mov ecx, 4
find_max:
    cmp eax,ebx ;;compare a and b
    jae Abigger ;;if a>=b go to Abigger
    mov eax, ebx ;;else (means b>a) a=b
Abigger:
    cmp eax, ecx ;;compare a and c (or in case b was bigger- compare b(new a) and c)
    jae end_prog ;;if a>=c go to end_prog
    mov eax, ecx ;;else (means c>a) a=c
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
