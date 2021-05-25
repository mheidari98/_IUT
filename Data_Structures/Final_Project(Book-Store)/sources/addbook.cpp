/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    addbook.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "addbook.h"
#include "librarysystem.h"

AddBook::AddBook(LibrarySystem *libsystem):libsystem(libsystem)
{

    addbook_scene = new QGraphicsScene(0,0,800,500);
    back_btn = new QPushButton("Back");
    add_btn = new QPushButton("Add");
    name_led = new QLineEdit;
    author_led = new QLineEdit;
    year_led = new QLineEdit;
    price_led = new QLineEdit;
    number_led = new QLineEdit;
    name_lbl = new QLabel;
    author_lbl = new QLabel;
    year_lbl = new QLabel;
    price_lbl = new QLabel;
    result_lbl = new QLabel;


    name_lbl->setStyleSheet("background-color:white");
    author_lbl->setStyleSheet("background-color:white");
    year_lbl->setStyleSheet("background-color:white");
    price_lbl->setStyleSheet("background-color:white");
    result_lbl->setStyleSheet("background-color:white;color:green");
    result_lbl->setAlignment(Qt::AlignCenter);

    QPixmap pix(":/err/err1.png");
    name_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
    author_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
    year_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
    price_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));

    name_lbl->setHidden(1);
    author_lbl->setHidden(1);
    year_lbl->setHidden(1);
    price_lbl->setHidden(1);
    result_lbl->setHidden(1);

    result_lbl->setText("<b> The Book Succesfully Added </b>");

    name_led->setPlaceholderText("Book's Name");
    author_led->setPlaceholderText("Author's Name");
    year_led->setPlaceholderText("PublishedYear");
    price_led->setPlaceholderText("Book's Price ");
    number_led->setPlaceholderText("Book's Number = 1");

    name_led->setGeometry(200,100,100,50);
    author_led->setGeometry(500,100,100,50);
    year_led->setGeometry(200,200,100,50);
    price_led->setGeometry(500,200,100,50);
    back_btn->setGeometry(0,0,50,50);
    add_btn->setGeometry(500,300,100,50);
    name_lbl->setGeometry(150,100,50,50);
    author_lbl->setGeometry(450,100,50,50);
    year_lbl->setGeometry(150,200,50,50);
    price_lbl->setGeometry(450,200,50,50);
    number_led->setGeometry(200,300,100,50);
    result_lbl->setGeometry(300,350,200,50);

    addbook_scene->addWidget(name_led);
    addbook_scene->addWidget(author_led);
    addbook_scene->addWidget(year_led);
    addbook_scene->addWidget(price_led);
    addbook_scene->addWidget(number_led);
    addbook_scene->addWidget(back_btn);
    addbook_scene->addWidget(add_btn);
    addbook_scene->addWidget(name_lbl);
    addbook_scene->addWidget(author_lbl);
    addbook_scene->addWidget(year_lbl);
    addbook_scene->addWidget(price_lbl);
    addbook_scene->addWidget(result_lbl);

    connect(back_btn,&QPushButton::clicked,this,&AddBook::GoBack);
    connect(add_btn,&QPushButton::clicked,this,&AddBook::AddNewBookToLibrary);

}

void AddBook::GoBack()
{
    name_led->clear();
    author_led->clear();
    year_led->clear();
    price_led->clear();
    number_led->clear();
    name_lbl->setHidden(1);
    author_lbl->setHidden(1);
    year_lbl->setHidden(1);
    price_lbl->setHidden(1);
    result_lbl->setHidden(1);
    libsystem->ChangeSceneToLibrarySystem();
}

void AddBook::AddNewBookToLibrary()
{

    if(name_led->text()!="" && author_led->text()!="" && year_led->text()!="" && price_led->text()!="")
    {
        name_lbl->setHidden(1);
        author_lbl->setHidden(1);
        year_lbl->setHidden(1);
        price_lbl->setHidden(1);
        if(number_led->text() == "")
            libsystem->AddBookToLibrary(name_led->text(),author_led->text(),year_led->text(),price_led->text());
        else
            libsystem->AddBookToLibrary(name_led->text(),author_led->text(),year_led->text(),price_led->text(),number_led->text());
        name_led->clear();
        author_led->clear();
        year_led->clear();
        price_led->clear();
        number_led->clear();
        result_lbl->setHidden(0);
    }
    else
    {
        result_lbl->setHidden(1);

        if(name_led->text()== Q_NULLPTR)
            name_lbl->setHidden(0);
        else
            name_lbl->setHidden(1);

        if(author_led->text()== Q_NULLPTR)
            author_lbl->setHidden(0);
        else
            author_lbl->setHidden(1);

        if(year_led->text()== Q_NULLPTR)
            year_lbl->setHidden(0);
        else
            year_lbl->setHidden(1);

        if(price_led->text()== Q_NULLPTR)
            price_lbl->setHidden(0);
        else
            price_lbl->setHidden(1);
    }
}
