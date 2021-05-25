/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    screen.cpp
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "screen.h"

screen::screen()
{
    scene=new QGraphicsScene(0,0,800,500);
    top_frame = new QLabel;

    scene->addWidget(top_frame);

    top_frame->setGeometry(0,0,800,50);

    top_frame->setAlignment(Qt::AlignCenter);

    top_frame->setStyleSheet("background-color:rgb(4, 51, 59);color: white ;font: 16pt Century");

}

screen::~screen()
{
    delete scene;
}



