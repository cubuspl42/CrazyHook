SOURCES=$(wildcard *.asm)

all: CrazyPatches.lua

clean:
	del *.obj *.exe *.lua

CrazyPatches.lua: CrazyPatches.exe
	python build_patches.py $^ > $@

CrazyPatches.exe: $(SOURCES:.asm=.obj)
	ld -T .\CrazyPatches.ld --file-alignment=0 --section-alignment=0 -o $@

%.obj: %.asm
	yasm -f win32 $^
