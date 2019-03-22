.include console.S

#
#  Ввод целого числа и вывод суммы его цифр
#

Rec record a:31,b:1

.equ MaxLongInt 0x80000000

.macro 
    local K
    K=0
    K=K+1
    outintln K
.endm

.data
   X:
       .space 4 
   Sum:
       .byte   # Сумма цифр
   Y:
       .   sbyte 1
 Xesp  dw 0FFFFh
   Z   byte ?
   T   db "ASDFGHJKL",0
   FZF db ?
   FSF db ?
   FCF db ?
   FOF db ?
_DATA  ends

.code
.global _start
_start:
   GotoXY 10,10
   do_pause    'Начнём, пожалуй...'
   ConsoleTitle "   Ввод целого числа, вывод суммы его цифр"
Begin:
   clrscr
   newline 2
   mov   Sum,0
   outstr 'Введите целое X='
   inintln X
   jnc   @F
   outstrln 'Слишком большое число!'
   jmp   Next
@@:jnz   @F
   pushfd
   outstrln 'Введено число меньше нуля!'
   popfd
@@:jns   @F
   outstrln 'Плохой конец лексемы целого числа!'
@@:mov   ebx,10
   mov   eax,X
L: cdq
   idiv  ebx
L1:neg   edx
   js    L1; edx:=abs(edx)
   add   Sum,dl; Sum:=Sum+цифра
   cmp   eax,0
   jne   L
   outwordln Sum,,"Сумма цифр="

Next:
   MsgBox "Конец программы","Желаете ещё раз?",  \
          MB_YESNO+MB_ICONQUESTION
   cmp   eax,IDYES
   outwordln eax,,'EAX='
   je    Begin

   exit
_TEXT  ends
   end Start
