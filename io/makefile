io: io.o
	gcc -o io io.o -no-pie
io.o: io.asm
	nasm -f elf64 -g -F dwarf io.asm -l io.lst
