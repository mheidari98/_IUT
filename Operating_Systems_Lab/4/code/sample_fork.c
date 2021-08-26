#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    pid_t pid;
    pid=fork();
    int inChild=0;
    if(pid==0)
    {
        inChild=1;
    }
    while(inChild==0)
    {
        printf("this is Parent\n");
        sleep(1);
    }
    while(inChild==1)
    {
        printf("this is Child\n");
        sleep(1);
    }
    return 0;
}