/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    librarysystem.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "librarysystem.h"
#include "showbook.h"
#include "addbook.h"
#include "linkedlist.h"
#include "Queue.h"
#include "addcustomer.h"
#include "getfactor.h"

LibrarySystem::LibrarySystem()
{
    scene = new QGraphicsScene(0,0,800,500);
    AddBook_btn = new QPushButton("Add Book");
    AddBook_btn->setGeometry(200,200,100,50);
    //AddBook_btn->setStyleSheet("QPushButton { border-radius : 5px;}");

    ShowBookList_btn = new QPushButton("Show Books");
    ShowBookList_btn->setGeometry(500,200,100,50);
    AddCustomer_btn = new QPushButton("Add Customer");
    AddCustomer_btn->setGeometry(200,300,100,50);
    GetFactor_btn = new QPushButton("Get Factor");
    GetFactor_btn->setGeometry(500,300,100,50);

    Library = new LinkedList;
    menqueue = new Queue;
    womenqueue = new Queue;
    ShowBook_obj = new ShowBook(this);
    AddBook_obj = new AddBook(this);
    AddCustomer_obj = new AddCustomer(this);
    GetFactor_obj = new GetFactor(this);


    scene->addWidget(AddBook_btn);
    scene->addWidget(ShowBookList_btn);
    scene->addWidget(AddCustomer_btn);
    scene->addWidget(GetFactor_btn);

    BookFile = new QFile("BookFile.txt");

    ReadBooksFromFile();

    view = new QGraphicsView(scene);
    view->setStyleSheet("background-image: url(:/background/bg1.jpg)");
    view->show();

    connect(AddBook_btn,&QPushButton::clicked,this,&LibrarySystem::ChageSceneToAddBook);
    connect(ShowBookList_btn,&QPushButton::clicked,this,&LibrarySystem::ChangeSceneToShowBook);
    connect(AddCustomer_btn,&QPushButton::clicked,this,&LibrarySystem::ChangeSceneToAddCustomer);
    connect(GetFactor_btn,&QPushButton::clicked,this,&LibrarySystem::ChangeSceneToGetFactor);
}

LibrarySystem::~LibrarySystem()
{
    WriteBooksInFile();
}

void LibrarySystem::ReadBooksFromFile()
{
    if(BookFile->open(QFile::ReadOnly | QFile::Text))
    {
        QString name, author, year, price, number;
        QTextStream input(BookFile);
        int book_num = input.readLine().toInt();

        for(int i=0; i<book_num; i++)
        {
            name = input.readLine();
            author = input.readLine();
            year = input.readLine();
            price = input.readLine();
            number = input.readLine();
            Library->Push(name,author,year,price,number);
        }

        BookFile->close();
    }
    else
        qDebug() << "bookfile could not open";

}

void LibrarySystem::WriteBooksInFile()
{
    if(BookFile->open(QFile::WriteOnly | QFile::Text))
    {
        QTextStream output(BookFile);
        int book_num = Library->Size();
        output << book_num << endl;
        for(int i=0; i<book_num; i++)
        {
            output << Library->First()->name << endl;
            output << Library->First()->author << endl;
            output << Library->First()->year << endl;
            output << Library->First()->price << endl;
            output << Library->First()->number << endl;
            Library->Pop(Library->First()->name, Library->First()->year);
        }

        BookFile->flush();
        BookFile->close();
    }
    else
        qDebug() << "bookfile could not open";

}

int LibrarySystem::BookTypes()
{
    qDebug() << Library->Size();
    return Library->Size();
}

int LibrarySystem::BookNumber()
{
    return Library->BookNum();
}

void LibrarySystem::DeleteBookFromLibrary(QString name,QString year)
{
    if(Library->Search(name,year)->number <= "1")
        Library->Pop(name,year);
    else
        Library->Search(name,year)->ReduceNumber();

    Library->ReduceBookNums();
    Library->Print(ShowBook_obj->BookList);

}

void LibrarySystem::ChangeSceneToShowBook()
{

    view->setScene(ShowBook_obj->ShowBookScene);
    Library->Print(ShowBook_obj->BookList);
    ShowBook_obj->SetType_NumbersLabel(Library->Size(),Library->BookNum());
}

void LibrarySystem::ChangeSceneToLibrarySystem()
{
    view->setScene(scene);
}

void LibrarySystem::ChageSceneToAddBook()
{
    view->setScene(AddBook_obj->addbook_scene);
}

void LibrarySystem::ChangeSceneToAddCustomer()
{
    view->setScene(AddCustomer_obj->addcustomer_scene);
}

void LibrarySystem::ChangeSceneToGetFactor()
{
    view->setScene(GetFactor_obj->getfactor_scene);
}

void LibrarySystem::AddBookToLibrary(QString name,QString author,QString year,QString price,QString number)
{
    Library->Push(name,author,year,price,number);
}

int LibrarySystem::AddCustomerToQueue(QString name,QString gender)
{
    if(gender == "man")
       return menqueue->Push(name);
    else
       return womenqueue->Push(name);
}

Book* LibrarySystem::SearchInLibrary(QString name, QString year)
{
    return Library->Search(name,year);
}

Customer* LibrarySystem::SearchInQueue(QString name)
{
    Customer *result;
    if((result = menqueue->Search(name)))
        return result;
    else if (( result = womenqueue->Search(name)))
        return result;
    else
        return 0;
}

Customer* LibrarySystem::GetFirstCustomerInfo(QString gender)
{
    Customer *temp;

    if(gender == "man")
    {
        if(!menqueue->IsEmpty())
        {
            temp = new Customer(*menqueue->Front());
            menqueue->Pop();
        }
        else
            return 0;
    }
    else
    {
        if(!womenqueue->IsEmpty())
        {
            temp = new Customer(*womenqueue->Front());
            womenqueue->Pop();
        }
        else
            return 0;
    }

    return temp;

}
