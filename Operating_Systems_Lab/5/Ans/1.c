#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <signal.h>

#define MAX_CHILD 5
#define MAXIMUM 100

int main()
{
    int total = 0;
    char buffer[256];
    int fd[MAX_CHILD][2];
    pid_t pid[MAX_CHILD];
    int inChild = 0;
    for(int i=0;i<MAX_CHILD;i++)
    {
        int x=pipe(fd[i]);
    }

    for(int i=0;i<MAX_CHILD;i++)
    {
        pid[i]=fork();
        if(!pid[i])
        {
            inChild = i+1;
            break;
        }
    }

    srand(getpid());   // Initialization, should only be called once.
    if(inChild)
    {
        close(fd[inChild-1][0]);
        while(1)
        {
            int r = rand()%11;      // Returns a pseudo-random integer between 0 and RAND_MAX.
            sprintf(buffer,"%d",r);
            printf("child %d generate %d\n",inChild , r);
            write(fd[inChild-1][1],buffer,strlen(buffer));
            sleep(r);
        }
    }
    else
    {
        for(int i=0;i<MAX_CHILD;i++)
            close(fd[i][1]);
        while(1)
        {
            for(int i=0;i<MAX_CHILD;i++)
            {
                bzero(buffer , 255);
                if(read(fd[i][0],buffer,255)>0)
                {
                    int r = atoi(buffer);
                    total += r;
                    printf("parent recive %d from child %d\t total=%d\n",r , i+1 ,total);

                }
                if(total>MAXIMUM)
                    break;
            }

            if(total>MAXIMUM)
                break;
        }
        for(int i=0;i<MAX_CHILD;i++)
            {
                printf("child with pid=%d killed\n",pid[i]);
                kill(pid[i] , SIGKILL);
            }
    }
    


}