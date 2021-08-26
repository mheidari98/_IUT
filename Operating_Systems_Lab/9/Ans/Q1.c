#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <stdlib.h> 
#include<time.h> 

#define SIZE 10
#define THREADS 10

sem_t sem1;
int product=0;
int A[SIZE], B[SIZE];

void *routine1(void * id )
{
    int idx=(int)id;
    int ans = A[idx]*B[idx];
    printf("thread=%d creat=%d \n",idx,ans);
    sem_wait(&sem1);
    //beginning of critical section
    product+=ans;
    printf("====>thread=%d and total=%d \n",idx,product);
    sleep(1);
    //end of critical section
    sem_post(&sem1);
    pthread_exit((void *)idx);
}

int main()
{
    for(int i=0;i<SIZE;i++)
    {
        srand(i*27);
        A[i] = rand()%10;
    }
    for(int i=0;i<SIZE;i++)
    {
        srand(i*100);
        B[i] = rand()%10;
    }
    printf("A = ");
    for(int i=0;i<SIZE;i++)
        printf("%d ",A[i]);
    printf("\n");
    printf("B = ");
    for(int i=0;i<SIZE;i++)
        printf("%d ",B[i]);
    printf("\n");

    sem_init(&sem1,0,1);
    pthread_t threads[THREADS];
    for ( int i=0;i<THREADS;i++)
        pthread_create(&threads[i],NULL,routine1,(void *)i);
    for (int i=0; i<THREADS; i++)
        pthread_join(threads[i],NULL);
    return 0;
}