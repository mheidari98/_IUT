#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>

int SIZE = 8;
int *array; 

void *MIN(void * x)
{
    printf("id=%d\tarray[%d]=%d vs array[%d]=%d\n" , *(int*)x , *(int*)x , array[*(int*)x] , *(int*)x + SIZE  , array[*(int*)x + SIZE ]);
    array[*(int*)x] = (array[*(int*)x] > array[*(int*)x + SIZE ])?(array[*(int*)x + SIZE ]) : (array[*(int*)x]);

}

int main()
{
    int i;
    array = (int*)malloc(SIZE * sizeof(int));

    for(i=0 ; i<SIZE ; i++)
    {
        srand(time(NULL)+i);
        array[i] = rand()%100;
    }

    while(SIZE)
    {
        for(i=0 ; i<SIZE ; i++)
            printf("%d\t" , array[i]);
        printf("\n");
        SIZE/=2;
        pthread_t threads[SIZE];
        int thread_id[SIZE];
        for (i=0 ; i<SIZE ; i++)
        {
            thread_id[i] = i;
            pthread_create(&threads[i], NULL, MIN, (void *)&thread_id[i]);
        }

        for (int i=0; i<SIZE; i++)
            pthread_join(threads[i], NULL );

    }

    printf("MIN in aray = %d\n" , array[0]);

    getchar();

    return 0;
}