import configparser
import os.path

alignStr = 'section .text align=1\n'
if not os.path.exists("inlines"):
    os.makedirs("inlines")
if not os.path.exists("obj"):
    os.makedirs("obj")
config = configparser.ConfigParser()
config.optionxform = str
config.read('CrazyPatches.ini')
f = open('./CrazyPatches.ld', 'w')
for j in config['GLOBALS']:
    f.write(j + " = " + config['GLOBALS'][j] + ";\n")
f.write('\nSECTIONS\n{\n')
for i in config['INLINES']:
    f.write('\t. = ' + i + ';\n')
    f.write('\t.' + i + ' ALIGN(1): { obj/' + i + '.obj }\n')
    # IF FILE EXISTS, CHECK FOR MODIFICATIONS
    if os.path.isfile('./obj/' + i + '.obj') and os.path.isfile('./inlines/' + i + '.asm'):
        with open('./inlines/' + i + '.asm', 'r') as f3:
            data = f3.read()
            pos = data.find(alignStr) + len(alignStr)
            if data[pos:] == config['INLINES'][i]:
                continue
    f2 = open('./inlines/' + i + '.asm', 'w')
    for j in config['GLOBALS']:
        if config['INLINES'][i].find(j) >= 0:
            f2.write("extern " + j + '\n')
    f2.write(alignStr)
    f2.write(config['INLINES'][i])
    f2.close()
    print("inlines/" + i + ".asm")
for i in config['FILES']:
    ext = os.path.splitext(config['FILES'][i])[-1].lower()
    name = os.path.splitext(os.path.basename(config['FILES'][i]))[0]
    f.write('\t. = ' + i + ';\n')
    if ext == '.asm':
        ext = '.obj'
    elif ext == '.c':
        ext = '.o'
    else:
        f.close()
        raise Exception('Unknown file extension.')
    f.write('\t.' + name + ' ALIGN(1): { obj/' + name + ext + ' }\n')
    if os.path.isfile('obj/' + name + ext):
        if os.path.getmtime(config['FILES'][i]) < os.path.getmtime('obj/' + name + ext):
            continue
    print(config['FILES'][i])
f.write('}')
f.close()
