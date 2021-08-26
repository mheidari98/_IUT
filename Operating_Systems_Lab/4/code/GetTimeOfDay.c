#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h> //gettimeofday
#include <time.h> //time

int main(int argc,char ** argv)
{
    struct timeval start,stop;
    srand(time(NULL));

    gettimeofday(&start,NULL);

    int x = rand()%10;
    sleep(x);
    printf("%d\n",x);

    gettimeofday(&stop,NULL);

    long sec = stop.tv_sec - start.tv_sec;
    float m1 = start.tv_usec;
    float m2 = stop.tv_usec;

    long elapsed = sec*1000+(m2-m1)/1000;
    printf("%ld\n",elapsed);

    return 0;
}