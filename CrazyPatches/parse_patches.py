import configparser
import os.path

config = configparser.ConfigParser()
config.optionxform=str
config.read('CrazyPatches.ini')
f=open('./CrazyPatches.ld', 'w')
for j in config['GLOBALS']:
	f.write(j+" = "+config['GLOBALS'][j]+";\n")
f.write('\nSECTIONS\n{\n')
for i in config['INLINES']:
	f.write('\t. = '+i+';\n')
	f.write('\t.'+i+' ALIGN(1): { '+i+'.obj }\n')
	if os.path.isfile('./'+i+'.obj'):
		continue
	f2=open('./'+i+'.asm', 'w')
	for j in config['GLOBALS']:
		if config['INLINES'][i].find(j) >= 0:
			f2.write("extern "+j+'\n')
	f2.write("section .text align=1\n")
	f2.write(config['INLINES'][i])
	f2.close()
	print(i+".asm")
for i in config['FILES']:
	f.write('\t. = '+i+';\n')
	f.write('\t.'+config['FILES'][i]+' ALIGN(1): { '+config['FILES'][i]+'.obj }\n')
	print(config['FILES'][i]+".asm")
f.write('}')
f.close()