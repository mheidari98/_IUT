/****************************************************************
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    set_background.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef SET_BACKGROUND_H
#define SET_BACKGROUND_H

#include <QPushButton>
#include <QLabel>
#include <QGraphicsScene>
class set_background
{
public:
    set_background();

    QGraphicsScene *scene;
    QPushButton *push[5];
    QLabel *label;
};

#endif // SET_BACKGROUND_H
