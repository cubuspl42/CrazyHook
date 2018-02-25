extern ChameleonString
extern IsChameleonLoaded
extern DllNotFoundString
extern CoreFunctionNotFoundString
extern GetProcAddress
extern SelfTest
extern Chameleon
extern CLAW_46FF50
extern CLAW_46D5F4
extern CLAW_4A5C50
extern CLAW_50B56D
extern CLAW_4B6000
extern CLAW_4B60F0
extern CLAW_4B7214
extern LABEL_BackFromChameleon5
extern LABEL_BackFromChameleon7

global LABEL_Chameleon5
global LABEL_Chameleon7
global LABEL_SomethingRelatedToAssetsLoading

section .text align=1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CHAMELEON MAIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CALL CLAW_46FF50                            ; \CLAW.0046FF50
PUSH EAX
PUSH EDX
MOV EAX,[IsChameleonLoaded]
MOV EDX,DllNotFoundString                ; ASCII "CrazyHook.dll not found."
CALL SelfTest                            ; [CLAW.0050B432
PUSH ChameleonString                     ; /Procname = "Chameleon"
PUSH EAX                                 ; |hModule
CALL [GetProcAddress]					 ; \KERNEL32.GetProcAddress
MOV EDX,CoreFunctionNotFoundString       ; ASCII "Core function not found."
CALL SelfTest                            ; [CLAW.0050B432
PUSH 0
CALL EAX
POP EAX
POP EDX
POP EAX
JMP CLAW_46D5F4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GDI hook
LABEL_Chameleon5:
	PUSH EDX
	MOV EDX,5
	PUSH ESI
	PUSH EAX
	POP ESI
	CALL Chameleon
	POP ESI
	NOP
	POP EDX
	JMP LABEL_BackFromChameleon5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Customs Window hook
LABEL_Chameleon7:
	PUSH EDX
	PUSH ESI
	MOV ESI,ESP
	MOV EDX,7
	CALL Chameleon
	POP ESI
	POP EDX
	SUB EAX,272
	JMP LABEL_BackFromChameleon7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUSH EDX
PUSH 36
PUSH EAX
CALL CLAW_4A5C50
POP EDX
PUSH EDX
TEST EAX,EAX
JNZ LABEL_ToMov
JMP LABEL_ToPop
LABEL_ToMov:
	MOV BYTE [EAX], 0
	JMP LABEL_ToPop2
LABEL_ToPop:
	POP EAX
	POP EDX
	POP EDX
	MOV ECX,EBX
	JMP LABEL_ToPush
LABEL_SomethingRelatedToAssetsLoading:
	PUSH ESI
	PUSH EAX
	CALL CLAW_50B56D
	TEST EAX,EAX
	JNZ LABEL_ToPush2
	PUSH CLAW_4B6000                         ; Entry point
	JMP LABEL_PushOut
LABEL_ToPush2:
	PUSH CLAW_4B60F0                         ; Entry point
LABEL_PushOut:
	POP ESI
	POP EAX
	JMP LABEL_ToAdd
LABEL_ToPop2:
	POP EAX
	POP EDX
	POP EDX
	MOV ECX,EBX
	PUSH 1
	JMP LABEL_SkipPush
LABEL_ToPush:
	PUSH 0
	LABEL_SkipPush:
	POP EAX
	RETN
LABEL_ToAdd:
	ADD ESP,4
	CALL ESI
	SUB ESP,4
	POP ESI
	JMP CLAW_4B7214
