// dllmain.cpp : Defines the entry point for the DLL application.
#include "stdafx.h"
#include <cstdlib>
#include <lua.hpp>
#include "CrazyHook.h"

lua_State *L = NULL;

static void *l_alloc (void *ud, void *ptr, size_t osize, size_t nsize) {
	(void)ud;
	(void)osize;  /* not used */
	if (nsize == 0) {
		free(ptr);
		return NULL;
	} else return realloc(ptr, nsize);
}

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		L = luaL_newstate();
		luaL_openlibs(L);
		break;
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		break;
	case DLL_PROCESS_DETACH:
		lua_close(L);
		L = NULL;
		break;
	}
	return TRUE;
}

