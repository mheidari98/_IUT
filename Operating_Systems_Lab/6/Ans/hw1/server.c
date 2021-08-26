#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>

#define SERVER_PORT 6000
#define MAX_CLIENT 5

static char *readcontent(const char *filename)
{
    char *fcontent = NULL;
    FILE *fp;

    fp = fopen(filename, "r+");

    if(fp) {
        fseek(fp, 0, SEEK_END); 
        long size = ftell(fp);
        fseek(fp, 0, SEEK_SET); 
        rewind(fp);

        fcontent = (char*) malloc(sizeof(char) * size);
        fread(fcontent, 1, size, fp);

        fclose(fp);
    }
    return fcontent;
}

int main()
{
    char buffer [256];
    int server_socket , client_socket ;
    // server_address = explicit address of server
    //client_address = client information
    struct sockaddr_in server_address , client_address ;
    //filling the server address record
    server_address.sin_family=AF_INET; //IPv4
    server_address.sin_port=htons(SERVER_PORT);
    server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
    //server_address.sin_addr.s_addr=INADDR_ANY;
    //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
    server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
    //binding socket to the server address
    bind ( server_socket , (struct sockaddr * ) & server_address ,sizeof(server_address) );
    //listening to incoming requests from clients with backlog of 5 clients
    listen (server_socket , MAX_CLIENT);
    int clientsize = sizeof(client_address);
    if ((client_socket = accept ( server_socket , (struct sockaddr * ) & client_address , &(clientsize)))>=0)
        printf("A connection from a client is recieved\n");
    else
        printf("Error in accepting the connection from the client\n ");

    char content[256];
    while(1)
    {
        bzero(buffer,256);
        bzero(content,256);
        read(client_socket , buffer , 256) ;
        printf("(server)path = %s\n", buffer);

        
        //content = readcontent(buffer);
        FILE *fp;
        fp = fopen(buffer, "r+");
        fread(content, 1, 255, fp);
        fclose(fp);

        printf("(server)File content :\n %s\n", content);
        printf("--------------------\n");
        write(client_socket , content , 256);
        printf("-----------msg is sent to the client!-----------\n");
    }
    return 0;
}