/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    linkedlist.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "linkedlist.h"
#include "librarysystem.h"

LinkedList::LinkedList():first(0),last(0),size(0),booknums(0)
{
}


void LinkedList::Push(QString name, QString author, QString year, QString price,QString number)
{
    Book *newbook = new Book(name,author,year,price,number);
    booknums += number.toInt();

    if(size)
    {
        Book *current = first;
        if(current->name > name)
        {
            newbook->next_book = current;
            last->next_book = newbook;
            first = newbook;

        }
        else if(current->name == name)
        {
            while(current->next_book->year > year && current!=last && current->next_book->name == name)
                current = current->next_book;
            if(current == first && year >= current->year)
            {
                last->next_book=newbook;
                newbook->next_book=first;
                first=newbook;
            }
            else
            {
                newbook->next_book = current->next_book;
                current->next_book = newbook;
                if(current == last)
                    last = newbook;
            }
        }
        else
        {
            while(current->next_book->name < name && current!=last)
                current = current->next_book;
            if(current->next_book->name == name)
            {
                while(current->next_book->year > year && current!=last && current->next_book->name <= name)
                    current = current->next_book;
            }
            newbook->next_book = current->next_book;
            current->next_book = newbook;
            if(current == last)
                last = newbook;
        }
    }
    else
    {
        first = last = newbook;
        last->next_book = first;
    }
    size++;
}

bool LinkedList::Pop(QString name,QString year)
{
    Book* current = first;
    Book* previous = 0;
    Book* temp;
    do
    {
        if(current->name == name && current->year == year)
        {
            if(current == first)
            {
              temp = first;
              first = first->next_book;
              last->next_book = first;
            }
            else
            {
               temp = current;
               previous->next_book = current->next_book;
            }
            delete(temp);
            size--;
            return 1;

        }

        previous = current;
        current = current->next_book;
    }while(current != first);
    return 0;
}

int LinkedList::Size()
{
    return size;
}

int LinkedList::BookNum()
{
    return booknums;
}


Book *LinkedList::First()
{
    return first;
}

Book *LinkedList::Search(QString name,QString year)
{

    Book *temp = first;
    for(int i = 0 ;i < size; i++)
    {
        if(temp->name == name && temp->year == year)
            return temp;

        temp = temp->next_book;
    }
    return 0;
}

void LinkedList::ReduceBookNums()
{
    booknums--;
}

void LinkedList::Print(QListWidget* list)
{
    list->clear();
    Book *temp = first;
    for(int i = 0 ;i < size; i++)
    {

        bookitem = new QListWidgetItem(temp->name + "   ( " + temp->year + " ) " +"   available number = "+temp->number );
        list->addItem(bookitem);

        if(i%2)
            bookitem->setBackgroundColor(QColor::fromRgb(64, 193, 193));
        else
            bookitem->setBackgroundColor(QColor::fromRgb(51, 153, 153));
        bookitem->setSizeHint(QSize(0,50));

        temp = temp->next_book;
    }
}
