/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Nov 2018 				
# 	Module Name:    main.cpp
# 	Project Name:   Bookstore	
#								
#								
****************************************************************/

#include <QApplication>
#include "librarysystem.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    LibrarySystem m;

    return a.exec();
}
