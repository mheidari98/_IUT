/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    customer.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QString>
#include "stack.h"

class Customer
{

public:
    int no;
    QString name;
    Customer(int,QString);
    Customer(Customer&);
    Stack *shoppingbag;
    Customer *next_custumer;
    void AddBookToShopphingBag(Book*);
    void PrintShoppingBag(QListWidget*);
};

#endif // CUSTOMER_H
