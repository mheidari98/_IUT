#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>

#define MAX_TRY 5

int flag = 0;

void handler1(int signo)
{
    switch(signo)
    {
    case SIGINT:
        printf("Interrupt Signal received \n");
        flag++;
        break;
    }
}

int main()
{
    //initializing sigaction structure
    struct sigaction action1;
    action1.sa_handler = handler1;
    action1.sa_flags = 0;
    sigaction(SIGINT,(struct sigaction *) &action1,NULL);
    //runnign forever, while process is sensitive to SIGINT
    while(1)
        if(flag == MAX_TRY)
            break;
    return 0;
}