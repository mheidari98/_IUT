#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    pid_t pid;
    while(1)
    {
        pid=fork();
        if(pid==0)
        {
            printf("%d\n",getpid());
            exit(0);
        }
        sleep(5);
    }

    return 0;
}