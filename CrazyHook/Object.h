#pragma once
struct ObjectA;

// high-level object wrapper
struct Object {
	Object(ObjectA*);
	virtual ~Object(void); // its memory offset must be 0
	ObjectA *a;
};

void call_lua(const char* fnName, ObjectA *a);
