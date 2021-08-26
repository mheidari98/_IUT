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
int MAX_CLIENT;

struct Details
{
    int *client_socket;
    struct sockaddr_in *client_address ;
};


void *CLIENT(void * Source)
{
    char buffer [256];

    struct sockaddr_in *client_address;
    client_address = (((struct Details *)Source)->client_address);
    int *client_socket;
    client_socket= (((struct Details*)Source)->client_socket);

    while(1)
    {
        bzero(buffer,256);
        read(*client_socket , buffer , 256) ;
        printf("Client(%d) = %s\n", (int)htons(client_address->sin_port) , buffer);

        if(!strcmp(buffer , "bye"))
        {
            printf("Client(%d) left\n", (int)htons(client_address->sin_port));
            pthread_exit(NULL);
        }

        bzero(buffer,256);
        printf("Server to client(%d) : " , (int)htons(client_address->sin_port)  );
        scanf("%s", buffer);
        write( *client_socket , buffer , 256);
    }
}

int main(int argc, char *argv[])
{
    MAX_CLIENT = atoi(argv[3]);

    int server_socket , client_socket ;
    struct sockaddr_in server_address , client_address ;

    server_address.sin_family=AF_INET; //IPv4
    server_address.sin_port=htons(atoi(argv[2]));
    server_address.sin_addr.s_addr=inet_addr(argv[1]);
   
    server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
    bind ( server_socket , (struct sockaddr * ) & server_address ,sizeof(server_address) );
    listen (server_socket , MAX_CLIENT);
    int clientsize = sizeof(client_address);

    pthread_t *threads = (pthread_t*)malloc(MAX_CLIENT*sizeof(pthread_t));

    for(int i=0 ; i<MAX_CLIENT ;)
    {
        if ((client_socket = accept ( server_socket , (struct sockaddr * ) & client_address , &(clientsize)))>=0)
        {
            struct Details *Source = (struct Details*)malloc(sizeof(struct Details));
            Source->client_socket = (int*)malloc(sizeof(int));
            Source->client_address = (struct sockaddr_in*)malloc(sizeof(struct sockaddr_in ));
            *(Source->client_socket) = client_socket;
            *(Source->client_address) = client_address ;
            printf("A connection from a client is recieved\n");
            pthread_create(&threads[i++], NULL, CLIENT, (void *)Source);
        }
        else
            printf("Error in accepting the connection from the client\n ");
    }


    while(1);

    return 0;
}