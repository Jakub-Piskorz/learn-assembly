io2: io2.o
	gcc -o io2 io2.o -no-pie
io2.o: io2.asm
	nasm -f elf64 -g -F dwarf io2.asm -l io2.lst
