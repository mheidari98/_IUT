/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    set_background.cpp
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "set_background.h"

set_background::set_background()
{
    scene =new QGraphicsScene(0,0,800,500);
    label = new QLabel("Please Select one background");
    push[0] = new QPushButton("0");
    push[1] = new QPushButton("1");
    push[2] = new QPushButton("2");
    push[3] = new QPushButton("3");
    push[4] = new QPushButton("4");

    label->setGeometry(300,40,200,50);
    push[0]->setGeometry(50,130,200,150);
    push[1]->setGeometry(300,130,200,150);
    push[2]->setGeometry(550,130,200,150);
    push[3]->setGeometry(175,320,200,150);
    push[4]->setGeometry(425,320,20,150);

    for(int i=0;i<5;i++)
    {
        push[i]->setStyleSheet("border-image:url(:/pics/background" + QString::number(i+1) + ".jpg); color: rgba(0,0,0,0);");
        scene->addWidget(push[i]);
    }

}
