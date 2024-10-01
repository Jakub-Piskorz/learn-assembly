# makefile for bits and printb
bits: bits.o printb.o
	gcc -g -o bits bits.o printb.o -no-pie
bits.o: bits.asm
      	nasm -f elf64 -g -F dwarf bits.asm -l bits.lst
printb: printb.c
      	cc -c -o printb.o printb.c
