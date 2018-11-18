extern LABEL_BackFromClawLevel11Fix
extern LABEL_BackFromChameleon1
extern LABEL_BackFromChameleon2
extern LABEL_BackFromChameleon4
extern ClawLogicFrag
extern Chameleon1Jump
extern CLAW_45D503
extern LoopThroughObjects

global LABEL_ClawLevel11Fix
global LABEL_Chameleon4
global LABEL_Chameleon3
global LABEL_Chameleon2
global LABEL_Chameleon1

extern IsChameleonLoaded
extern DllNotFoundString
extern CoreFunctionNotFoundString
extern SelfTest
extern ChameleonString
extern GetProcAddress
extern ChameleonVar
extern CObjectString
extern CObListString
extern CreateObject
extern CreateObject_sub
extern LABEL_AfterObjectCreate

global Chameleon
global LABEL_InitObjectsLoop
global LABEL_CreateAndInitObject

extern LABEL_BackFromObjectsInitialization
extern LABEL_BackFromSomeTestExit
extern LABEL_BackFromSaveNRes
extern ExitProcess
extern nRes
extern SomeFun
extern TestExit

global LABEL_SaveNRes
global LABEL_SomeTestExit

section .text align=1

DB "CUSTOM_SPLASH",0

LABEL_ClawLevel11Fix:
	PUSH 60
	PUSH 16
	PUSH -52
	PUSH -16
	POP DWORD [EBX+308]
	POP DWORD [EBX+312]
	POP DWORD [EBX+316]
	POP DWORD [EBX+320]
	CALL ClawLogicFrag
	JMP LABEL_BackFromClawLevel11Fix

LABEL_Chameleon1:
	JZ Chameleon1Jump
	PUSH EDX
	MOV EDX,1
	CALL Chameleon
	POP EDX
	JMP LABEL_BackFromChameleon1
	
LABEL_Chameleon2:
	PUSH EDX
	MOV EDX,2
	CALL Chameleon
	POP EDX
	JMP LABEL_BackFromChameleon2

LABEL_Chameleon3:
	PUSH EDX
	MOV EDX,3
	CALL Chameleon
	POP EDX
	RETN 8
	
LABEL_Chameleon4:
	PUSH EDX
	MOV EDX,4
	CALL Chameleon
	POP EDX
	CMP EAX, 167
	JMP LABEL_BackFromChameleon4
	
Chameleon:
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
	
LABEL_SaveNRes:
	MOV DWORD [nRes], EBP ;save nRes for CH
	CALL SomeFun ; copy what was there originally
	JMP LABEL_BackFromSaveNRes ;go back

LABEL_SomeTestExit:
	MOV EAX, DWORD [TestExit]
	TEST EAX, EAX
	JNZ LABEL_ST_AFTER
	PUSH 0
	PUSH 0
	PUSH 1
	PUSH 5
	JMP LABEL_BackFromSomeTestExit
LABEL_ST_AFTER:
	PUSH 1337
	CALL [ExitProcess]
	
LABEL_CreateAndInitObject:
	CALL CreateObject_sub
;	PUSH EAX
;	PUSH EDX
;	MOV EAX, DWORD [IsChameleonLoaded]
;	MOV EDX, DllNotFoundString
;	CALL SelfTest
;	PUSH CObjectString
;	PUSH EAX
;	CALL [GetProcAddress]
;	MOV EDX, CoreFunctionNotFoundString
;	CALL SelfTest
;	POP EDX
	; save
;	CALL EAX
;	POP EAX
	JMP LABEL_AfterObjectCreate
	
LABEL_InitObjectsLoop:
	PUSH EAX
	PUSH EDX
	MOV EAX, DWORD [IsChameleonLoaded]
	MOV EDX, DllNotFoundString
	CALL SelfTest
	PUSH CObListString
	PUSH EAX
	CALL [GetProcAddress]
	MOV EDX, CoreFunctionNotFoundString
	CALL SelfTest
	POP EDX
	; save
	CALL EAX
	POP EAX
	JMP LABEL_BackFromObjectsInitialization
