/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    librarysystem.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef LIBRARYSYSTEM_H
#define LIBRARYSYSTEM_H

#include <QGraphicsScene>
#include <QGraphicsView>
#include <QPushButton>
#include <QListWidget>
#include <qdebug.h>
#include <QObject>
#include <QDebug>
#include <QFile>
#include "Queue.h"

class AddBook;
class ShowBook;
class AddCustomer;
class LinkedList;
class GetFactor;
class Queue;

class LibrarySystem :public QObject
{
    Q_OBJECT

public:
    LibrarySystem();
    ~LibrarySystem();
    QPushButton *AddBook_btn, *ShowBookList_btn, *AddCustomer_btn, *GetFactor_btn;
    QGraphicsScene *scene;
    QGraphicsView *view;
    QFile *BookFile;
    LinkedList *Library;
    Queue *menqueue, *womenqueue;
    ShowBook *ShowBook_obj;
    AddBook *AddBook_obj;
    AddCustomer *AddCustomer_obj;
    GetFactor *GetFactor_obj;


public slots:
    void ChangeSceneToLibrarySystem();
    void ChageSceneToAddBook();
    void ChangeSceneToShowBook();
    void ChangeSceneToAddCustomer();
    void ChangeSceneToGetFactor();
    void ReadBooksFromFile();
    void WriteBooksInFile();
    int BookTypes();
    int BookNumber();
    void DeleteBookFromLibrary(QString,QString);
  //  void PrintBookList(QListWidget*);
    void AddBookToLibrary(QString ,QString ,QString ,QString,QString num ="1");
    int AddCustomerToQueue(QString,QString);
    Book* SearchInLibrary(QString,QString);
    Customer* SearchInQueue(QString);
    Customer* GetFirstCustomerInfo(QString);
};

#endif // LIBRARYSYSTEM_H
