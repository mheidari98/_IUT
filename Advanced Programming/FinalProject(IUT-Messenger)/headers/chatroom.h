/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chatroom.h		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef CHATROOM_H
#define CHATROOM_H

#include "login.h"
#include "chat.h"
#include "register.h"
#include "network.h"
#include <QEventLoop>
#include <QTimer>

class Chatroom : public QObject
{
    Q_OBJECT

    Login *log;
    Chat *chat;
    Register *reg;
    bool online;
    QTimer *timer;
public:
    explicit Chatroom(QObject *parent = 0);
    QGraphicsView* view;
private slots:
    void check_connection();

};

#endif // CHATROOM_H
