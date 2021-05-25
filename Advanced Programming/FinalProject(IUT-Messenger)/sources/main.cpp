/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    main.cpp	
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include <QApplication>

#include "chatroom.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    Chatroom chatroom;
    chatroom.view->show();


    return a.exec();
}
