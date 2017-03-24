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
    mov ecx, 010h ;;setting value for eax
    mov eax, ecx ;;copying ecx value to eax (so we can use ecx for the loop)
    mov ecx, 20h ;;setting the number of iterations for the loop (32 iterations)
    mov ebx, 0h ;;setting the counter of 1(on) bits
rotate:
    shl eax, 1 ;;shift the left bit of the number so we can check if the left bit is 1
    jc increaseCounter ;;check if the left bit is 1, if so increase the counter
    loop rotate ;;go to another iteration in the loop

power2: ;;means the number is a power of 2
    mov eax, 0h ;;set eax to be 0
    jmp end_prog ;;finish the program

increaseCounter: ;;increase the counter and check if there was more than one 1 (on) bits
    inc ebx ;;increase the counter 
    cmp ebx, 1 ;;check if there are more than one 1 (on) bits
    ja notPower2 ;;in case there are jump to not power of 2 label
    jmp rotate ;;else return to the loop

notPower2: ;;means the number is not a power of 2
    mov eax, 0ffffffffh
    jmp end_prog ;;finish the program 
end_prog: ;;call the end of _start
    end _start ;;end the program
