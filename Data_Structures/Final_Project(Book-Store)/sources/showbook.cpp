/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    showbook.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "showbook.h"
#include "librarysystem.h"

ShowBook::ShowBook(LibrarySystem *LibSystem):LibSystem(LibSystem),CurrentCustomer(0)
{

    ShowBookScene = new QGraphicsScene(0,0,800,500);
    back_btn = new QPushButton("Back");
    add_btn = new QPushButton("Add to ShoppingBag");
    MoreInfo_lbl = new QLabel;
    Typs_lbl = new QLabel;
    Nums_lbl = new QLabel;
    BookList = new QListWidget;
    ShoppingBagList = new QListWidget;
    BookFile = new QFile("BookFile.txt");

    MoreInfo_lbl->setHidden(1);
    add_btn->setHidden(1);
    ShoppingBagList->setHidden(1);

    Typs_lbl->setAlignment(Qt::AlignCenter);
    Nums_lbl->setAlignment(Qt::AlignCenter);

    back_btn->setGeometry(0,0,50,50);
    add_btn->setGeometry(470,320,150,50);
    BookList->setGeometry(100,100,300,255);
    MoreInfo_lbl->setGeometry(420,150,250,150);
    Typs_lbl->setGeometry(700,0,100,50);
    Nums_lbl->setGeometry(700,70,100,50);
    ShoppingBagList->setGeometry(100,370,300,125);

    ShowBookScene->addWidget(add_btn);
    ShowBookScene->addWidget(back_btn);
    ShowBookScene->addWidget(BookList);
    ShowBookScene->addWidget(Typs_lbl);
    ShowBookScene->addWidget(Nums_lbl);
    ShowBookScene->addWidget(MoreInfo_lbl);
    ShowBookScene->addWidget(ShoppingBagList);

    window = new QWidget;
    window->setWindowTitle("Customer's Name");
    Layout = new QGridLayout;
    CustomerName_lbl = new QLabel("Customer's Name:");
    ErrorName_lbl = new QLabel;
    CustomerName_led = new QLineEdit;
    button = new QPushButton("Login");
    GetTurn_btn = new QPushButton("Signin");
    Layout->addWidget(CustomerName_lbl,0,0);
    Layout->addWidget(CustomerName_led,0,1);
    Layout->addWidget(ErrorName_lbl,1,0,2,2);
    Layout->addWidget(GetTurn_btn,4,0,1,2);
    Layout->addWidget(button,3,0,1,2);
    window->setLayout(Layout);

    connect(back_btn,&QPushButton::clicked,this,&ShowBook::GoBack);
    connect(BookList,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(ShowMoreInformation(QListWidgetItem*)));
    connect(add_btn,&QPushButton::clicked,this,&ShowBook::AddBookToShophingBag);
    connect(button,&QPushButton::clicked,this,&ShowBook::LoginToSelectBook);
    connect(GetTurn_btn,&QPushButton::clicked,this,&ShowBook::GetTurn);

}

ShowBook::~ShowBook()
{
    window->close();
}

void ShowBook::GoBack()
{
    CurrentCustomer = 0;
    ErrorName_lbl->clear();
    CustomerName_led->clear();
    add_btn->setHidden(1);
    MoreInfo_lbl->setHidden(1);
    ShoppingBagList->setHidden(1);
    LibSystem->ChangeSceneToLibrarySystem();
}

void ShowBook::SetType_NumbersLabel(int types, int nums)
{
    Typs_lbl->setText("Type : " + QString::number(types));
    Nums_lbl->setText("Numbers : " + QString::number(nums));
}


void ShowBook::ShowMoreInformation(QListWidgetItem* item)
{

    add_btn->setHidden(0);
    MoreInfo_lbl->setHidden(0);
    QString name, year, txt=item->text();
    int abc=1;
    for(int i=0;txt[i]!=')';i++)
    {
        if(txt[i] == ' ' && txt[i+1] == ' ')
            abc=2;
        if(abc == 1)
            name+=txt[i];
        else if(!abc)
        {
            if(txt[i]>='0' && txt[i]<='9')
                year+=txt[i];
        }
        if(txt[i]=='(')
            abc=0;
    }
    CurrentBook = LibSystem->SearchInLibrary(name,year);
    MoreInfo_lbl->setAlignment(Qt::AlignCenter);
    MoreInfo_lbl->setText("  name = " + name + "\n\n  author = " + CurrentBook->author + "\n\n  publish year = " + year + "\n\n  price = " + CurrentBook->price + "\n\n  available number = " + CurrentBook->number);

}

void ShowBook::AddBookToShophingBag()
{
    if(CurrentCustomer == 0)
    {
        window->show();
    }
    else
    {
        CurrentCustomer->AddBookToShopphingBag(CurrentBook);
        LibSystem->DeleteBookFromLibrary(CurrentBook->name,CurrentBook->year);
        CurrentCustomer->PrintShoppingBag(ShoppingBagList);
    }

}

void ShowBook::LoginToSelectBook()
{
    if(CustomerName_led->text() != "")
    {
        CurrentCustomer = LibSystem->SearchInQueue(CustomerName_led->text());
        if(CurrentCustomer)
        {
            ErrorName_lbl->clear();
            CurrentCustomer->AddBookToShopphingBag(CurrentBook);
            LibSystem->DeleteBookFromLibrary(CurrentBook->name,CurrentBook->year);
            CurrentCustomer->PrintShoppingBag(ShoppingBagList);
            CustomerName_led->clear();
            window->close();
            ShoppingBagList->setHidden(0);
        }
        else
        {
            ErrorName_lbl->setText("name was not found please Enter again \nor if you dont get turn please get first");
        }
    }
}

void ShowBook::GetTurn()
{
    ErrorName_lbl->clear();
    CustomerName_led->clear();
    window->close();
    LibSystem->ChangeSceneToAddCustomer();
}
