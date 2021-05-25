/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    stack.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "stack.h"

Stack::Stack():top(0),size(0)
{
}

void Stack::Push(Book *newbook)
{
    Book *temp = new Book(*newbook);
    temp->next_book = top;
    top = temp;
    size++;
    qDebug()<< temp->name;
}

void Stack::Pop()
{
    Book *temp;
    temp = top;
    top = top->next_book;
    delete(temp);
    size--;
}

Book *Stack::Top()
{
    return top;
}

bool Stack::IsEmpty()
{
    if(size)
        return 0;
    return 1;
}

void Stack::Print(QListWidget *list)
{
    list->clear();
    Book *temp = top;
    for(int i = 0 ;i < size; i++)
    {

        bookitem = new QListWidgetItem(temp->name + "   ( " + temp->year + " )");
        list->addItem(bookitem);

        if(i%2)
            bookitem->setBackgroundColor(QColor::fromRgb(64, 193, 193));
        else
            bookitem->setBackgroundColor(QColor::fromRgb(51, 153, 153));
        bookitem->setSizeHint(QSize(0,50));

        temp = temp->next_book;
    }
}
