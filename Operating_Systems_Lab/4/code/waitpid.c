#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAXCHILD 5

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
    }
    while (inChild==1){
        srand(getpid());
        int r = rand()%10;
        printf("message from child %d : sleeping %d seconds\n",getpid(), r);
        sleep(r);
        inChild=-1;
    }
    while(inChild==0){
        sleep(1);
        for(int i=0;i<MAXCHILD;i++){
            int child_d;
            
            //**comment from next line
            child_d = wait(&status);
            if (child_d>0)
                printf("child[%d] is dead now \n",child_d);
            else if(child_d==-1)
                printf("no child to wait for \n");
            //**comment till this line

            // child_d = waitpid(child[i],&status,0);
            // if(child_d==0)
            //     printf("child[%d] is still alive\n",child[i]);
            // else if(child_d>0) 
            //     printf("child[%d] is dead now \n",child[i]);
            // else
            //     printf("no specified child to wait for \n");
        }
    }
    return 0;
}