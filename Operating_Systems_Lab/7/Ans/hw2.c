#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <fcntl.h>

#define MAXCHILD 5
#define MAXIMUM 100


int total = 0;
pid_t pid[MAXCHILD];

void handler1(int signo)
{
    char buffer[256];
    int pipe;
    switch(signo)
    {
    case SIGUSR1:
        pipe = open("1.pipe",O_RDONLY | O_NONBLOCK);
        read(pipe,buffer,255);
        printf("recived %s\n" , buffer);
        total += atoi(buffer);
        printf("total is now = %d\n" , total);
        bzero(buffer,256);
        if(total > MAXIMUM)
        {
            for(int i=0 ; i< MAXCHILD ;i++)
                {
                    printf("child with pid=%d killed\n" , getpid());
                    kill( pid[i], SIGKILL );
                }
            exit(0);
        }
        break;
    }
}

int main()
{
    int pipe, inChild = 0;
    pid_t parent=getpid();

    struct sigaction action1;
    action1.sa_handler = handler1;
    action1.sa_flags = 0;
    sigaction(SIGUSR1,(struct sigaction *) &action1,NULL);

    char path[20];
    sprintf(path,"1.pipe");
    mkfifo(path,0777);

    for(int i=0 ; i<MAXCHILD ;i++)
    {
        pid[i] = fork();
        if(pid[i]==0)
        {
            inChild = i+1;
            break;
        }
    }

    char buffer[256];

    if(inChild)
    {
        printf("child pid = %d\n" , getpid());
        pipe=open(path, O_WRONLY | O_NONBLOCK);
        srand(getpid());
        while(1)
        {
            bzero(buffer,256);
            int tmp = rand()%10 ;
            sleep(tmp);
            sprintf(buffer,"%d",tmp);
            printf("child[%d] with pid=%d creat %s\n", inChild , getpid()  , buffer);
            write(pipe,buffer,strlen(buffer));
            kill(parent,SIGUSR1);
        }
    }
    else
    {
        printf("parent pid = %d\n" , getpid());
        while(1);
    }
}
