/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    showbook.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef SHOWBOOK_H
#define SHOWBOOK_H
#include <QListWidget>
#include <QListWidgetItem>
#include <QPushButton>
#include <QGraphicsScene>
#include <QFile>
#include <QTextStream>
#include <qdebug.h>
#include <QLabel>
#include <QLineEdit>
#include <QWidget>
#include <QGridLayout>
#include <QMessageBox>
#include "customer.h"
class LibrarySystem;


class ShowBook: public QObject
{
    Q_OBJECT

    Book *CurrentBook;
    QListWidget *ShoppingBagList;
    QListWidgetItem *item;
    QPushButton *back_btn,*add_btn;
    QFile *BookFile;
    LibrarySystem *LibSystem;
    QLabel *MoreInfo_lbl,*Typs_lbl,*Nums_lbl;
    QLineEdit *CustomerName_led;
    Customer* CurrentCustomer;
    QWidget *window;
    QGridLayout *Layout;
    QLabel *CustomerName_lbl,*ErrorName_lbl;
    QPushButton *button,*GetTurn_btn;


public :
    ShowBook(LibrarySystem*);
    ~ShowBook();
    void ReadBooksFromFile();
    void GoBack();
    void SetType_NumbersLabel(int,int);
    QGraphicsScene *ShowBookScene;
    QListWidget *BookList;
public slots:
    void ShowMoreInformation(QListWidgetItem*);
    void AddBookToShophingBag();
    void LoginToSelectBook();
    void GetTurn();

};

#endif // SHOWBOOK_H
