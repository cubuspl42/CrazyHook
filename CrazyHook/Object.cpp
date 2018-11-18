#include "stdafx.h"
#include "Object.h"
#include "CrazyHook.h"

#include <sstream>
#include <cassert>
#include <lua.hpp>
extern lua_State *L;

using namespace std;

Object::Object(ObjectA *a_) {
	a = a_;
}

Object::~Object() {
	call_lua("_destroy", a);
}
