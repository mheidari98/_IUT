/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    linkedlist.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include <QListWidgetItem>
#include <QListWidget>
#include <QListWidget>
#include <QString>
#include "book.h"

class LinkedList
{
private:
    Book *first,*last;
    int size;
    int booknums;

    QListWidget* booklist;
    QListWidgetItem* bookitem;

public:
    LinkedList();
    void Push(QString , QString , QString , QString, QString num = "1");
    bool Pop(QString,QString);
    int Size();
    int BookNum();
    Book* First();
    Book* Search(QString,QString);
    void ReduceBookNums();
    void Print(QListWidget*);
};

#endif // LINKEDLIST_H

