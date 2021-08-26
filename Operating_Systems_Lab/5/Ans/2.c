#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAX_CHILD 5
#define T 10

int main()
{
    pid_t pid[MAX_CHILD];
    int inChild = 0;
    int pipe;

    char path[20];
    sprintf(path,"1.pipe");
    //making the named-pipe
    mkfifo(path,0777);
    char buffer[256];
    bzero(buffer,256);
    

    for(int i=0;i<MAX_CHILD;i++)
    {
        pid[i]=fork();
        if(!pid[i])
        {
            inChild = i+1;
            break;
        }
    }

    if(inChild)
    {
        pipe=open(path,O_RDWR);
        sleep(T);
        while(1)
        {
            read(pipe,buffer,255); 
            printf("child %d read %s\n",inChild , buffer);
            if(atoi(buffer) == inChild)
            {
                bzero(buffer,256);
                sprintf(buffer,"%d",inChild-1);
                write(pipe,buffer,strlen(buffer));
                printf("child %d write %d on pipe\n",inChild , inChild-1);
            }
            else
            {
                write(pipe,buffer,strlen(buffer));
            }
            
            bzero(buffer,256);
            sleep(1);
        }
    }
    else
    {
        pipe=open(path,O_RDWR );
        sprintf(buffer,"%d",MAX_CHILD);
        write(pipe,buffer,strlen(buffer));
        while(1)
        {
            bzero(buffer,256);
            read(pipe,buffer,255); 
            if(!atoi(buffer))
                break;
            write(pipe,buffer,strlen(buffer));
        }
        for(int i=0;i<MAX_CHILD;i++)
        {
            printf("child with pid=%d killed\n",pid[i]);
            kill(pid[i] , SIGKILL);
        }
    }
    


}