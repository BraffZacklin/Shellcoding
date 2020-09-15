#include <stdio.h>
#include <unistd.h>

int main(void)
{
	char * command[2];

	command[0] = "/bin/sh";
	command[1] = NULL;

	execve(command[0], command, NULL);

	return 0;
}