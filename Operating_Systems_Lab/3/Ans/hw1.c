// mahdi heidari ( 9626903 )
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
	if(strcmp(argv[1],"-c") == 0)
	{
		umask(0);
		char path[100];
		//strcpy(permission,argv[2]);
		int permission = strtol( argv[2] , 0 , 8);
		//int permission = atoi( argv[2] );
		strcpy(path,argv[3]);
		int file = open( path , O_CREAT | O_TRUNC , permission );
		close(file);
	}
	else if(strcmp(argv[1],"-w") == 0)
	{
		char path[100] , temp[100];
		strcpy(path,argv[2]);
		printf("please enter ur text : ");
		fgets( temp ,255 , stdin );
		//printf("%s\n" , temp );
		int file = open( path , O_CREAT | O_TRUNC | O_RDWR , 00755 );
		write( file , temp , strlen(temp));
		close(file);

	}
	else if(strcmp(argv[1],"-r") == 0)
	{
		char path[100],temp[2];
		strcpy(path,argv[2]);
		int file = open( path , O_RDONLY );
		temp[1]='\0';
		while(read(file,temp,1))
		{
			printf("%s",temp);
			//strcpy(temp , "");
		}
		close(file);
	}
	else if(strcmp(argv[1],"-m") == 0)
	{
		char dirPath[100] , prefix[100] , ext[100] , v1[10] , v2[10] ,temp[100];
		strcpy(dirPath,argv[2]);
		strcpy(prefix,argv[3]);
		strcpy(ext,argv[4]);
		strcpy(v1,argv[5]);
		strcpy(v2,argv[6]);

		for(int i=atoi(v1) ; i <= atoi(v2) ; i++)
		{

			strcpy(temp,"");
			sprintf(temp , "%s%s%d.%s", dirPath , prefix , i , ext);
			int file = open( temp , O_CREAT | O_TRUNC , 00744 );
			close(file);
		}
		
	}
	return 0;
}




