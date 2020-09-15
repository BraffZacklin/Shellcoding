#!/usr/bin/python3

import sys, re

shellcode = ""
length = 0

while True:
	item = sys.stdin.readline()
	if item:
		if re.match("^[ ]*[0-9a-f]*:.*$", item):
			item = item.split(":")[1].lstrip()
			x = item.split("\t")
			opcode = re.findall("[0-9a-f][0-9a-f]", x[0])
			for i in opcode:
				shellcode += "\\x" + i
				length += 1
	else:
		break

if length == 0:
	print("Nothing to extract")
else:
	print(f'\n{shellcode}')
	print(f'\nLength: {length}')