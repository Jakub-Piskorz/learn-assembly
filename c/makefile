rect: rect.o
	gcc -o rect rect.o -no-pie
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst
