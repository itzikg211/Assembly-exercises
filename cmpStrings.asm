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
    str1 db "abc", 00h
    str2 db "abd", 00h
;;_____________________CODE_______________________
.code
_start:
    xor eax, eax ;eax=0
    lea eax, [str2] ;load the address of str2
    push eax ;pass str2 as a parameter to the function
    xor eax, eax ;eax=0
    lea eax, [str1] ;load the address of str1
    push eax ;pass str1 as a parameter to the function
    call cmp_strings ;call the string compare function
    jmp end_prog ;finish the program
    

cmp_strings:
    push ebp ;keep the old stack base on stack
    mov ebp, esp ;set a new stack base
    push edi ;keep edi
    push esi ;keep esi
    mov ebx, [ebp + 8] ;ebx = address of str1
    mov ecx, [ebp + 12] ;ecx = address of str2
    xor edx, edx ;edx=0
compare:
    mov al, [ebx+edx] ;al = first char of str1
    mov ah, [ecx+edx] ;ah = first char of str2
    inc edx ;increase edx(the index)
    cmp al, 00h ;check if we reached the end of str1
    jz check_null ;if we reached the end of str1 jump to check if we reached the end of str2
    cmp al, ah ;compare the char of str1 and the char of str2 at the same index 
    ja set_1 ;if str1[i] > str2[i] -> eax = 1
    je compare ;else, if the chars are the same continue to another iteration
    mov eax, 0ffffffffh ;else, set eax = -1
    jmp finish_cmp_string ;finish the function

check_null:
    cmp ah, 00h ;str1 reached to null, now check if str2 reached also to null
    jz set_0 ;if str2 reached null -> eax = 0, the strings are the same

set_1:
    mov eax, 01h ;set eax = 1, means str1 > str2
    jmp finish_cmp_string ;finish the function

set_0:
    xor eax, eax ;set eax = 0, means the strings are equal
finish_cmp_string:
    pop esi ;restore esi
    pop edi ;restore edi
    pop ebp ;restore the base pointer
    ret ;return
      
end_prog:
    ;;Exit the program, eax is the exit code
    push eax
    call ExitProcess
end _start
