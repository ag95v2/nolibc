
all:
	# Dynamic lib is loaded, size of file ~ 9kb 43 syscalls (finding dynamic lib)
	gcc -Wall -g greet.c -o greet_stdlib

	# Statically link stdlib, size ~ 900kb 13 syscalls
	gcc -Wall -g -static greet.c -o greet_static
	gcc -Wall -g -static greet2.c -o greet_static2

	# Rewrite syscalls in asm;
	# use 32-bit mode in both asm and c files
	nasm  -f elf start.asm
	nasm  -f elf calls.asm
	gcc -m32 -Wall -c greet3.c
	ld -m elf_i386 start.o calls.o greet3.o  -o greet3
	# Program without stdlib ~1.6 kb 5 syscalls!
	# Super cool
