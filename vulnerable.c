#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

unsigned char shellcode[] = "\x48\x31\xc0\x50\x68\x2f\x62\x69\x6e\xc7\x44\x24\x04\x2f\x62\x61\x73\xc6\x44\x24\x08\x68\x48\x89\xe7\x50\x48\x89\xe6\x48\x89\xc2\xb0\x3b\x0f\x05";

int main(void)
{
	mprotect((void*)((intptr_t)shellcode & ~0xFFF), 8192, PROT_READ|PROT_EXEC);

	int (*ret)();
	ret = (int(*)())shellcode;
	(int)(*ret)();
}