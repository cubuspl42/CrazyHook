SOURCES=$(shell python parse_patches.py)

all: CrazyPatches.lua

clean: 
	rm *.obj *.exe *.lua 0x*.asm CrazyPatches.ld

CrazyPatches.lua: CrazyPatches.exe
	python build_patches.py $^ > $@

CrazyPatches.exe: $(SOURCES:.asm=.obj)
	ld -T CrazyPatches.ld --file-alignment=0 --section-alignment=0 -o $@

%.obj: %.asm
	yasm -f win32 $^