#makefile for func3, circle, rect
func3: func3.o circle.o rect.o
	gcc -g -o func3 func3.o circle.o rect.o -no-pie
func3.o: func3.asm
	nasm -f elf64 -g -F dwarf func3.asm -l func3.lst
circle.o: circle.asm
	nasm -f elf64 -g -F dwarf circle.asm -l circle.lst
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst
