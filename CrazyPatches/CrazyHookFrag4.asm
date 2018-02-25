extern LABEL_BackFromSomeTestExit
extern LABEL_BackFromSaveNRes
extern ExitProcess
extern nRes
extern SomeFun

global LABEL_SaveNRes
global LABEL_SomeTestExit
global LABEL_GottaMoveThis

section .text align=1

LABEL_SaveNRes:
	MOV DWORD [nRes], EBP ;save nRes for CH
	CALL SomeFun ; copy what was there originally
	JMP LABEL_BackFromSaveNRes ;go back

LABEL_GottaMoveThis:
	DD 0 ;0x50BFD3 - local TestExit

LABEL_SomeTestExit:
	MOV EAX, DWORD [LABEL_GottaMoveThis]
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