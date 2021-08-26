#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h> //gettimeofday
#include <time.h> //time


int main()
{
    int status, inChild=0 ,j;
    char s[3][10];
    pid_t child;
    struct timeval start,stop;
    srand(time(NULL));

    for(j=1;;j++)
    {
        status=0;
        printf("Enter program path & parogram name & 1 arg(separated by sapce) : %d : \n",getpid());
        for(int i=0;i<3;i++)
            scanf("%s",s[i]);
        gettimeofday(&start,NULL);
        child=fork();
        if(child == 0){
            inChild=1;
            printf("\nchild %d created with parent %d\n",getpid(),getppid());
            execl(s[0],s[1],s[2], NULL);
        }
        else
        {
            int child_d = wait(&status);
            //int child_d = waitpid(child,&status,0);
            if(child_d>0)
            {
                printf("child[%d] is dead now \n",child_d);
            }
            else
            {
                printf("no child to wait for \n");
            }
            gettimeofday(&stop,NULL);

            long sec = stop.tv_sec - start.tv_sec;
            float m1 = start.tv_usec;
            float m2 = stop.tv_usec;
            long elapsed = sec*1000000+(m2-m1);

            char buffer[400];
            time_t time_ptr; 
            time_ptr = time(NULL); 
            struct tm* tm_local = localtime(&time_ptr); 
            sprintf(buffer ,"‫‪%2d | Date‬‬ = %d/%02d/%02d\t time = %2d:%02d\t ‫‪execution time(usec) = %ld\t path = %s\n",j,tm_local->tm_year+1900,tm_local->tm_mon,tm_local->tm_mday,tm_local->tm_hour,tm_local->tm_min,elapsed,s[0]);
            printf("%s",buffer);

            FILE *filePointer;
            filePointer = fopen("log.txt", "a+");
            fprintf(filePointer,"%s",buffer);
            fclose(filePointer);
        }
        sleep(2);
    }
    return 0;
}