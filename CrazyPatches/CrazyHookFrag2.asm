extern MenuHookString
extern CreateObject
extern LABEL_GottaMoveThis
extern ResetNameString
extern Chameleon
extern LABEL_BackFromMenuHook
extern LABEL_BackFromChameleon1
extern LABEL_BackFromChameleon2
extern LABEL_BackFromChameleon4
extern ClawLogicFrag
extern Chameleon1Jump
extern CLAW_45D503

global LABEL_MenuHook
global LABEL_MenuHook2
global LABEL_Chameleon4
global LABEL_Chameleon3
global LABEL_Chameleon2
global LABEL_Chameleon1

section .text align=1

DB "CUSTOM_SPLASH",0
LABEL_TestExit:
MOV EAX, [LABEL_GottaMoveThis]
TEST EAX, EAX
JMP $+2+7
MOV EAX, MenuHookString
JMP $+2+5
MOV EAX, ResetNameString
JMP LABEL_MenuHookEnd

LABEL_MenuHook:
PUSH 60
PUSH 16
PUSH -52
PUSH -16
POP DWORD [EBX+308]
POP DWORD [EBX+312]
POP DWORD [EBX+316]
POP DWORD [EBX+320]
CALL ClawLogicFrag
JMP LABEL_BackFromMenuHook

LABEL_MenuHook2:
PUSH 0
PUSH MenuHookString
PUSH 9999
PUSH 100
PUSH -30
PUSH 0
CALL CreateObject
MOV ECX, EAX
JMP LABEL_TestExit

LABEL_MenuHookEnd:
MOV [ECX+220], EAX
MOV EAX, ECX
JMP CLAW_45D503

LABEL_Chameleon4:
PUSH EDX
MOV EDX,4
CALL Chameleon
POP EDX
CMP EAX, 167
JMP LABEL_BackFromChameleon4

LABEL_Chameleon3:
PUSH EDX
MOV EDX,3
CALL Chameleon
POP EDX
RETN 8

LABEL_Chameleon2:
PUSH EDX
MOV EDX,2
CALL Chameleon
POP EDX
JMP LABEL_BackFromChameleon2

LABEL_Chameleon1:
JZ Chameleon1Jump
PUSH EDX
MOV EDX,1
CALL Chameleon
POP EDX
JMP LABEL_BackFromChameleon1