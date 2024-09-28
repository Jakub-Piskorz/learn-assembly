reverse: reverse.o
	gcc -o reverse reverse.o -no-pie
reverse.o: reverse.asm
	nasm -f elf64 -g -F dwarf reverse.asm -l reverse.lst
