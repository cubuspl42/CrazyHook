@echo off
set parsed=0
python parse_patches.py > .sources
for /F %%A in (.sources) do (
	echo %%A
	if /I "%%~xA" equ ".asm" (
		yasm -f win32 %%A -o obj/%%~nA.obj
	) else if /I "%%~xA" equ ".c" (
		gcc -c %%A -o obj/%%~nA.o
	) else (
		echo Unknown file extension.
		echo Build failed.
		EXIT /B 0
	)
	set /A parsed+=1
)
IF NOT '%ERRORLEVEL%'=='0' (
	echo Build failed.
	EXIT /B 0
)
if %parsed% gtr 0 (
	echo -----------------------------
	echo Total number of parsed files: %parsed%.
	call :makeExe
	IF NOT '%ERRORLEVEL%'=='0' (
		echo Build failed.
		EXIT /B 0
	)
	call :makeLua
) else (
	if exist CrazyPatches.lua (
		echo Nothing to do here.
	) else (
		if not exist CrazyPatches.exe (
			call :makeExe
			IF NOT '%ERRORLEVEL%'=='0' (
				echo Build failed.
				EXIT /B 0
			)
		)
		call :makeLua
		IF NOT exist CrazyPatches.lua (
			echo Build failed.
			EXIT /B 0
		)
		echo Build success.
	)
)
EXIT /B 0

:makeExe 
echo Making CrazyPatches.exe...
ld -T CrazyPatches.ld --file-alignment=0 --section-alignment=0 -o CrazyPatches.exe
EXIT /B 0

:makeLua 
echo Making CrazyPatches.lua...
python build_patches.py CrazyPatches.exe > CrazyPatches.lua
IF NOT '%ERRORLEVEL%'=='0' (
	rm -f CrazyPatches.lua
)
EXIT /B 0