#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <stdlib.h> 
#include<time.h> 


#define philsof 5
#define changal 6

sem_t FORK[changal] , mutex;

void *func1(void * id )
{
    int idx=(int)id;
    srand(idx);
    //printf("phisof %d come in func:D\n",idx);

    while(1)
    {
        sem_wait(&mutex);
        //printf("phisof %d come in mutex:D\n",idx);

        int val_l,val_r;  
        do
        {
            sem_getvalue(&FORK[idx] , &val_l) ;
            sem_getvalue(&FORK[(idx+1)%(changal)] , &val_r);
        }while ( !(val_l &&  val_r));

        sem_wait(&FORK[idx] );
        sleep(1);
        sem_wait( &FORK[(idx+1)%(changal)] );

        sem_post(&mutex);

        printf("phisof %d eating(3) :D\n",idx);
        sleep(3);

        sem_post(&FORK[idx]);
        sem_post(&FORK[(idx+1)%(philsof+1)]);

        int think=rand()%3;
        printf("phisof %d thinking(%d) :D\n", idx ,think );
        sleep(think);

    }


    //pthread_exit((void *)idx);
}
int main ()
{
    for ( int i=0;i<changal;i++)
        sem_init(&FORK[i],0,1);
    sem_init(&mutex,0,1);
    pthread_t threads[philsof];
    for ( int i=0;i<philsof;i++)
        pthread_create(&threads[i],NULL,func1,(void *)i);
    for (int i=0; i<philsof; i++)
        pthread_join(threads[i],NULL);
    return 0;
}