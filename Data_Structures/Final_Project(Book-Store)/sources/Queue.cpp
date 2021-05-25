/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    Queue.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "queue.h"
#include "librarysystem.h"

Queue::Queue()
{
    front = rear = 0;
    size = 0;
    turn = 0;
}

int Queue::Push(QString name)
{
    Customer *newcustomer = new Customer(++turn,name);

    if(++size == 1)
    {
        front = rear = newcustomer;
    }
    else
    {
        rear->next_custumer = newcustomer;
        rear = newcustomer;
    }
    rear->next_custumer = 0;
    return turn;
}

void Queue::Pop()
{
    Customer *temp = front;
    front = front->next_custumer;
    size--;
    qDebug() << temp->name << "deleted";
    delete(temp);
}

Customer *Queue::Front()
{
    return front;
}

bool Queue::IsEmpty()
{
    if(size)
        return 0;
    return 1;
}

Customer *Queue::Search(QString name)
{
    Customer *temp = front;
    for(int i=0; i<size; i++)
    {
        if(temp->name == name)
            return temp;
        temp = temp->next_custumer;
    }
    return 0;
}
