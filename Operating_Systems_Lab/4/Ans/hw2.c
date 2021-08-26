#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAXCHILD 100000

int main(){
    pid_t child [MAXCHILD];
    int inChild=0;
    int status=0;
    for (int i=0;i<MAXCHILD;i++){
        child[i]=fork();
        if(child[i]==0){
            inChild=1;
            break;
        }
        else
        {
            printf("child %d created\n",child[i]);
        }
    }

    while(inChild==0){
        for(int i=0;i<MAXCHILD;i++){
            int child_d;
            child_d = waitpid(child[i],&status,WNOHANG);
            if(child_d>0)
            {
                printf(" child[%d] is dead now \n",child[i]);
                child[i]=fork();
                if(child[i]!=0)
                    printf(" child %d created\n",child[i]);
                else
                {
                    inChild=1;
                    break;
                }
                
            }
            sleep(1);
        }
    }
    while (inChild==1){
        srand(getpid());
        //int r = rand()%1000;

        int sum=0;
        for(int i=0;i<10000;i++)
            for(int j=0;j<10000;j++)
                for(int k=0;k<10000;k++)
                    sum++;
        printf("sumed\n");
        //printf("‫‪‫‪message‬‬ from child %d, waited for %d seconds\n",getpid(), r);
        //sleep(r);
        inChild=-1;
        exit(0);
    }
    return 0;
}