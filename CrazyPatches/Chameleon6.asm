extern Chameleon

section .text align=1

push esi
mov esi,esp
push edx
mov edx,6
call Chameleon
pop edx
pop esi
jmp $+2+25
