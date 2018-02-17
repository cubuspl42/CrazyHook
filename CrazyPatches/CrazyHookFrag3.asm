extern IsChameleonLoaded
extern DllNotFoundString
extern CoreFunctionNotFoundString
extern SelfTest
extern ChameleonString
extern GetProcAddress
extern ChameleonVar

section .text align=1

PUSH EAX
PUSH EDX
MOV EAX, DWORD [IsChameleonLoaded]
MOV EDX, DllNotFoundString
CALL SelfTest
PUSH ChameleonString
PUSH EAX
CALL [GetProcAddress]
MOV EDX, CoreFunctionNotFoundString
CALL SelfTest
POP EDX
MOV DWORD [ChameleonVar], EDX
PUSH ESI
CALL EAX
POP EAX
MOV EAX, 0
MOV DWORD [ChameleonVar], EAX
POP EAX
RETN