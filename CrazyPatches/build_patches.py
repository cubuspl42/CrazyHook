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

list(map(build_patch, pe.sections))
