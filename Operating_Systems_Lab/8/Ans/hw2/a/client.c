#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>


#define SERVER_PORT 6000

int main()
{
    int client_socket;
    char buffer [256];
    //making the server address record with a recognized server IP and port
    struct sockaddr_in server;
    server.sin_family = AF_INET;
    server.sin_port = htons(SERVER_PORT);
    server.sin_addr.s_addr = inet_addr("127.0.0.1");
    //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
    client_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
    //connecting to the server
    if (connect ( client_socket , (struct sockaddr * ) &server , sizeof(server))==0)
        printf("Client is connected to the server!\n");
    else
        printf("Error in connecting to the server\n");

    while(1) 
    {
        bzero (buffer ,256);
        printf("Client : ");
        scanf("%s", buffer);
        write(client_socket , buffer , 256);
        printf("-----------msg is sent to the server!-----------\n");

        if(!strcmp(buffer , "bye"))
        {
            printf("Client left\n");
            return 0;
        }

        bzero(buffer,256);
        read(client_socket , buffer , 256) ;
        printf("Server :  %s\n", buffer);
    }
    return 0;
}