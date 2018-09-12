#include "stdafx.h"
#include "CrazyHook.h"
#include "Object.h"

#include <cassert>
#include <string>
#include <sstream>
#include <lua.hpp>

using namespace std;
typedef int (*Logic)(ObjectA*);
extern lua_State *L;

static void msgbox(const char *fnName, ObjectA *a) {
	stringstream ss;
	ss << fnName << " " << a->_Name;
	MessageBox(0, ss.str().c_str(), "native exception", 0);
}

void call_lua(const char* fnName, ObjectA *a) {
	lua_getglobal(L, "_lua");
    if (!lua_isfunction(L, -1)) {
        MessageBox(0, "Critical error: function _lua does not exit" , fnName, 0);
		ExitProcess(1);
    }
	lua_pushstring(L, fnName);
	lua_pushlightuserdata(L, a);
	__try {
		lua_call(L, 2, 0);
	} __except(1) {
		msgbox(fnName, a);
	}
}

void call_lua(const char* fnName) {
	lua_getglobal(L, "_lua");
	if (!lua_isfunction(L, -1)) {
		MessageBox(0, "Critical error: function _lua does not exit", fnName, 0);
		ExitProcess(1);
	}
	lua_pushstring(L, fnName);
	__try {
		lua_call(L, 1, 0);
	}
	__except (1) {
		MessageBox(0, fnName, "native exception", 0);
	}
}

int CustomLogic(ObjectA* a) {
	Object *&userdata = a->v->userdata;
	if(!a->v->userdata) {
		if(a->v->state != 0) MessageBox(0, "state != 0", 0, 0);
		userdata = new Object(a);
		call_lua("_create", a);
	}
	assert(a->v->userdata->a == a);
	call_lua("_logic", a);
	return 1;
}

int CustomHit(ObjectA *a) {
	call_lua("_hit", a);
	return 1;
}

int CustomAttack(ObjectA *a) {
	call_lua("_attack", a);
	return 1;
}

int CustomBump(ObjectA *a) {
	call_lua("_bump", a);
	return 1;
}

int MenuHook(ObjectA* a) {
	call_lua("_menu");
	a->v->logic = 0x4614D0; //MenuClaw
	return 1;
}

#define REGISTER_LOGIC(logic) (s->*registerLogic)(logic, #logic, 0)

extern "C" {

// on map load
CRAZYHOOK_API void Chameleon(void *ptr)
{
	call_lua("_map", (ObjectA*)ptr);
}

// on logics register
CRAZYHOOK_API void CrazyHook(UnknownStruct *s)
{
	// Step 1. Register logics
	typedef void (UnknownStruct::*RegisterLogic)(Logic, const char*, int);
	static_assert(sizeof(RegisterLogic) == sizeof(int), "Wrong size of function pointer");
	RegisterLogic registerLogic;
	(int&)registerLogic = 0x004D6F70;
	REGISTER_LOGIC(CustomLogic);
	REGISTER_LOGIC(CustomHit);
	REGISTER_LOGIC(CustomAttack);
	REGISTER_LOGIC(CustomBump);
	REGISTER_LOGIC(MenuHook);

	// Step 2. Execute CrazyHook.lua
	if(luaL_dofile(L, "CrazyHook.lua")) {
		MessageBox(0, lua_tostring(L, -1), "CrazyHook.lua error", 0);
		ExitProcess(1);
	}
}

}
