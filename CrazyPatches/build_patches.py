import collections
import pefile
import fileinput
import sys
import binascii

pe_path = sys.argv[1]

pe = pefile.PE(pe_path)
image_base = pe.OPTIONAL_HEADER.ImageBase

def fhex(byte):
	return hex(byte)[2:].zfill(2)+" "

def build_patch(section):
	print("_chamAdd(0x" + hex(image_base + section.VirtualAddress)[2:].upper() + ',"' + "".join(map(fhex, section.get_data()[:section.Misc_VirtualSize]))[:-1].upper() + '")')

print('local function _chamAdd(addr, code) \
	local cham_exe = ffi.cast("char*",addr) \
	local i = 0 \
	for v in string.gmatch(code, "([^ ]+)") do \
		cham_exe[i] = tonumber(v, 16) \
		i = i+1 \
	end \
end')

list(map(build_patch, pe.sections))
