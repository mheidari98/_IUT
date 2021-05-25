/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    getfactor.h
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#ifndef GETFACTOR_H
#define GETFACTOR_H

#include <QGraphicsScene>
#include <QLabel>
#include <QPushButton>

class LibrarySystem;

class GetFactor: public QObject
{
    Q_OBJECT

public:
    GetFactor(LibrarySystem*);
    LibrarySystem *libsystem;
    QLabel* factor_lbl;
    QPushButton *back_btn, *Calculate_btn;
    QGraphicsScene *getfactor_scene;
    bool ManTurn;
    void GoBack();
    void CalculateNextFactor();
};

#endif // GETFACTOR_H
