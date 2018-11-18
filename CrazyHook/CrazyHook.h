// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the CRAZYHOOK_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// CRAZYHOOK_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef CRAZYHOOK_EXPORTS
#define CRAZYHOOK_API __declspec(dllexport)
#else
#define CRAZYHOOK_API __declspec(dllimport)
#endif

struct ObjectA;
typedef int(*Logic)(ObjectA*);

struct UnknownStruct {};
struct Object;

struct Rect {
	int Left;
	int Top;
	int Right;
	int Bottom;
};

struct ObjectV {
	int offset[4];
	Logic logic;
	int pdata;
	Object* userdata;
	int state;
};

struct ObjectA {
    void * const _vtable;
    const int ID;
    int Flags;
	int * const _Game_;
    int _field_10;
    int _field_14;
    int _field_18;
    int _field_1C;
    int _field_20;
    int _field_24;
    int _field_28;
    int _field_2C;
    int _field_30;
    int _field_34;
    int _field_38;
    int _field_3C;
    int DrawFlags;
    int _field_44;
    int _field_48;
    int _field_4C;
    int _field_50;
    int _field_54;
    int _field_58;
    int X;
    int Y;
    Rect ClipRect;
    int Z;
    int _field_78;
    ObjectV* v;
    int _field_80;
    int _field_84;
    int _field_88;
    int _field_8C;
    int _field_90;
    int _field_94;
    struct ObjectA* _ObjectBelow;
    int _field_9C;
    int _field_A0;
    int _field_A4;
    int _field_A8;
    int _field_AC;
    int _field_B0;
    int _field_B4;
    int _field_B8;
    int _field_BC;
    int _field_C0;
    int _field_C4;
    int _field_C8;
    int _field_CC;
    int _field_D0;
    int _field_D4;
    int _field_D8;
    const char* _Name;
    int _GlitterPointer_;
    int PhysicsType;
    int ObjectTypeFlags;
    int HitTypeFlags;
    int AttackTypeFlags;
    int _field_F4;
    int MoveResX;
    int MoveResY;
    int _field_100;
    int EditorX;
    int EditorY;
    int _EditorZ_;
    int _field_110;
    int Score;
    int Points;
    int Powerup;
    int Damage;
    int Smarts;
    int Health;
    int Direction;
    int _FacingDir_;
    Rect MoveRect;
    Rect HitRect;
    Rect AttackRect;
    int SpeedX;
    int SpeedY;
    int _field_16C;
    int _field_170;
    int MoveClawX;
    int MoveClawY;
    int _field_17C;
    int _field_180;
    int _field_184;
    int _field_188;
    int _field_18C;
    int I;
    void* Image;
    int _field_198;
    void* Sound;
    int _field_1A0;
    int _field_1A4;
    int _field_1A8;
    int _field_1AC;
    int _field_1B0;
    int _Animation_;
    int _field_1B8;
    int _field_1BC;
    int _unkn_bool1;
    int _field_1C4;
    int _unkn_bool2;
};
