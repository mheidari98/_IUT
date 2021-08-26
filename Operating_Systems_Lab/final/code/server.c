#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

#define SERVER_PORT 6000

sem_t sem1;
int client_num;
int MAX;
int THREADS;

struct Details
{
    int *client_socket;
    struct sockaddr_in *client_address ;
};

void *routine1(void * Source)
{
    char buffer[256];
    
    struct sockaddr_in *client_address;
    client_address = (struct sockaddr_in*)malloc(sizeof(struct sockaddr_in));
    client_address = (((struct Details *)Source)->client_address);
    int *client_socket;
    client_socket= (((struct Details*)Source)->client_socket);
    while (MAX)
    {
        bzero(buffer,256);
        read(*client_socket , buffer , 256) ;

        //beginning of critical section
        sem_wait(&sem1);
        if(MAX>0)
        {
            MAX-= atoi(buffer);
            printf("player(%d) plays, num=%s  & remain=%d\n", (int)htons(client_address->sin_port) , buffer , MAX);
        }
        else
        {
            printf("player(%d) plays, num=%s  but the game is finished:(\n", (int)htons(client_address->sin_port) , buffer);
            sem_post(&sem1);
            break;
        }
        
        if(MAX <= 0)
        {
            MAX = 0;
            printf("----> player(%d) is the winner <----\n",(int)htons(client_address->sin_port) );
            sem_post(&sem1);
            break;
        }
        //end of critical section
        sem_post(&sem1);

    }
    close(*client_socket);

    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{   
    //printf("argv[1]=%s\targv[2]=%s\n",argv[1] ,argv[2]);
    client_num = atoi(argv[1]);
    MAX = atoi(argv[2]);
    THREADS = client_num;

    sem_init(&sem1,0,1);

    pthread_t threads[THREADS];

    char buffer [256];
    int server_socket , client_socket ;

    struct sockaddr_in server_address , client_address ;

    server_address.sin_family=AF_INET; //IPv4
    server_address.sin_port=htons(SERVER_PORT);
    server_address.sin_addr.s_addr=inet_addr("127.0.0.1");

    server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );

    bind ( server_socket , (struct sockaddr * ) & server_address ,sizeof(server_address)) ;
    //listening to incoming requests from clients with backlog of 5 clients
    listen (server_socket , client_num);

    int clientsize = sizeof(client_address);
    int tedad;
    for(tedad=0 ; tedad<THREADS ;)
    {
        if ((client_socket = accept ( server_socket , (struct sockaddr * ) & client_address , &(clientsize)))>=0)
        {
            struct Details *Source = (struct Details*)malloc(sizeof(struct Details));
            Source->client_socket = (int*)malloc(sizeof(int));
            Source->client_address = (struct sockaddr_in*)malloc(sizeof(struct sockaddr_in ));
            *(Source->client_socket) = client_socket;
            *(Source->client_address) = client_address ;
            printf("A connection(%d) from a client is recieved\n",tedad);
            pthread_create(&threads[tedad++], NULL, routine1, (void *)Source);
        }
        else
            printf("Error in accepting the connection from the client\n ");

    }

    for (int i=0; i<tedad; i++)
    {
        //int *retval = (int*)malloc(sizeof(int));
        int retval;
        //pthread_join(threads[i],(void**)&retval);
        pthread_join(threads[i],(void**)&retval);
        printf("threadIdx %d finished, return_value = %d \n",i,retval);
        //free(retval);
    }
    // while (MAX>=0);
    // sleep(2);
    
    
    printf("END\n");
    while(1);
    return 0;

}
