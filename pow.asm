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
    numbers db 05h, 03h
;;_____________________CODE_______________________
.code
_start:
    xor eax, eax ;zero eax
    mov al, [numbers] ;read the base number
    mov ebx, dword ptr [numbers + 1] ;read the exponent number
    push ebx ;send base parameter to the function
    push eax ;send exponent parameter to the function
    call Pow ;execute the function
    jmp end_prog ;finish the program


Pow:
    push ebp ;keep the old stack base on stack
    mov ebp, esp ;set a new stack base
    push edi ;keep edi
    push esi ;keep esi
    mov edx, [ebp+8]; save the exponant value in edx
    cmp edx, 00h ;if the exponent is zero return 1
    jz set_one ;jump to the part that sets eax to be 1
    mov ecx, [ebp+12] ;setting the counter of the loop to be the exponent
    mov eax, edx ;set eax to be the base value (in case exponent is 1)
    
pow_loop:
    dec ecx ;decrease the counter. --couter.
    cmp ecx, 0 ;check if counter is zero
    jz finish_pow ;if the counter is zero finish the loop
    mov edx, [ebp+8] ;read the base parameter from the memory
    mul edx ;multiply eax with itself (as part of the pow function)
    jmp pow_loop ;repeat the loop

set_one:
    mov eax, 1 ;set eax to be 1 in case the exponent is 0
finish_pow:
    pop esi ;restore esi
    pop edi ;restore edi
    pop ebp ;restore the base pointer
    ret ;return
      
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
