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

int main(int argc, char *argv[])
{
    int client_socket;
    char buffer [256];
    struct sockaddr_in server;
    server.sin_family=AF_INET;
    server.sin_port=htons(SERVER_PORT);
    server.sin_addr.s_addr=inet_addr("127.0.0.1");
    //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
    client_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
    //connecting to the server
    if (connect ( client_socket , (struct sockaddr * ) &server , sizeof(server))==0)
        printf("Client is connected to the server!\n");
    else
        printf("Error in connecting to the server\n");

    srand(getpid());
    while(1) 
    {
        int T = rand()%5;
        bzero (buffer ,256);
        sprintf(buffer,"%d",T);
        write(client_socket , buffer , 256);
        printf("client produce %d\n",T);
        sleep(T);
    }

    return 0;
}