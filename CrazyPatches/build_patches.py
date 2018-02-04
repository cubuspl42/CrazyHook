import collections
import pefile
import fileinput
import sys
from mako.template import Template

pe_path = sys.argv[1]

Patch = collections.namedtuple('Patch', 'name virtual_address data')

mytemplate = Template(filename='CrazyPatches.mako')

pe = pefile.PE(pe_path)
image_base = pe.OPTIONAL_HEADER.ImageBase

def build_patch(section):
	return Patch(
		name = section.Name,
		virtual_address = image_base + section.VirtualAddress,
		data = section.get_data()[:section.Misc_VirtualSize]
	)

patches = map(build_patch, pe.sections)

print(mytemplate.render(patches=patches))
