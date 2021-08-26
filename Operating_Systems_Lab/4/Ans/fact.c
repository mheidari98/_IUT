#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <string>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h> //gettimeofday
#include <time.h> //time

int main(int argc , char** argv)
{
    int sum=1 , n=0 , i;
    for(i=0;i<strlen(argv[1]);i++)
        n = (n*10) + (argv[1][i]-'0');
    for(i=1;i<n;i++)
        sum*=i;
    sleep(5);
    printf("factorial %d = %d\n",n,sum);
    return 0;
}