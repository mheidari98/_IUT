/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    getfactor.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include "getfactor.h"
#include "librarysystem.h"

GetFactor::GetFactor(LibrarySystem* libsystem):libsystem(libsystem),ManTurn(0)
{
    getfactor_scene = new QGraphicsScene(0,0,800,500);
    factor_lbl = new QLabel;
    back_btn = new QPushButton("Back");
    Calculate_btn = new QPushButton("Calculate Next Factor");

    factor_lbl->setAlignment(Qt::AlignHCenter);

    getfactor_scene->addWidget(factor_lbl);
    getfactor_scene->addWidget(back_btn);
    getfactor_scene->addWidget(Calculate_btn);

    Calculate_btn->setGeometry(325,420,150,50);
    factor_lbl->setGeometry(200,100,400,300);
    back_btn->setGeometry(0,0,50,50);

    connect(back_btn,&QPushButton::clicked,this,&GetFactor::GoBack);
    connect(Calculate_btn,&QPushButton::clicked,this,&GetFactor::CalculateNextFactor);
}

void GetFactor::GoBack()
{
    factor_lbl->clear();
    libsystem->ChangeSceneToLibrarySystem();
}

void GetFactor::CalculateNextFactor()
{
    Customer *current;
    factor_lbl->clear();

    if(ManTurn)
    {
        current = libsystem->GetFirstCustomerInfo("man");
        if(current == 0)
        {
            qDebug() << "safe man finish";
            current = libsystem->GetFirstCustomerInfo("woman");
        }
        if(current == 0)
            factor_lbl->setText("<b>there is not any Customers<b>");
        else
        {
            long int sum = 0;
            Book* temp = current->shoppingbag->Top();
            factor_lbl->setText("Customer's Name : " + current->name);
            for(; temp; temp = temp->next_book)
            {
                sum += temp->price.toLong();
                factor_lbl->setText(factor_lbl->text()+"\n\n" + temp->name + "      "+ temp->price +"\n\n" );
            }
            factor_lbl->setText(factor_lbl->text()+ QString::number(sum));
        }

    }
    else
    {
       current = libsystem->GetFirstCustomerInfo("woman");
       if(current == 0)
       {
           qDebug() << "safe woman finish";
           current = libsystem->GetFirstCustomerInfo("man");
       }
       if(current == 0)
           factor_lbl->setText("<b>there is not any Customers<b>");
       else
       {
           long int sum = 0;
           Book* temp = current->shoppingbag->Top();
           factor_lbl->setText("Customer's Name : " + current->name);
           for(; temp; temp = temp->next_book)
           {
               sum += temp->price.toLong();
               factor_lbl->setText(factor_lbl->text()+"\n\n" + temp->name + "      "+ temp->price +"\n\n" );
           }
           factor_lbl->setText(factor_lbl->text()+ QString::number(sum));
       }

    }

    ManTurn = !ManTurn;
}
