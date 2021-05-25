/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    addcustomer.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef ADDCUSTOMER_H
#define ADDCUSTOMER_H
#include <QLineEdit>
#include <QGraphicsScene>
#include <QPushButton>
#include <QLabel>
#include <QObject>
#include <QRadioButton>
#include <QGroupBox>
#include <QComboBox>


class LibrarySystem;

class AddCustomer: public QObject
{
    Q_OBJECT

    QLineEdit *name_led;
    QComboBox* gender_btn;
    QLabel *no_lbl;
    QPushButton *back_btn,*add_btn;
    LibrarySystem *libsystem;

public:

    QGraphicsScene *addcustomer_scene;
    AddCustomer(LibrarySystem*);
    void GoBack();
    void AddNewCustomerToQueue();
};

#endif // ADDCUSTOMER_H
