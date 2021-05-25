/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    Queue.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef QUEUE_H
#define QUEUE_H

#include"customer.h"

class Queue
{
    Customer *front,*rear;
    int size;
    int turn;

public:
    Queue();
    int Push(QString);
    void Pop();
    bool IsEmpty();
    Customer* Front();
    Customer* Search(QString);
};

#endif // QUEUE_H
