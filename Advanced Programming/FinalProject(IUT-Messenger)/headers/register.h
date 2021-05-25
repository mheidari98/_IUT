/****************************************************************
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    register.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef REGISTER_H
#define REGISTER_H

#include <QCoreApplication>
#include <QTime>
#include "screen.h"
#include "network.h"
#include "chat.h"

class Register :  public Network, public screen
{


public:
    Register(QGraphicsView* view);
    ~Register();
    void signup();
    void set_scene_chatpage();
    virtual void server_reply(QNetworkReply* reply);

    QPushButton *register_Button, *login_Button;
private:

    QLineEdit *firstname_led, *lastname_led,*username_led, *password_led;
    QLabel *signup_message_lbl;
    QLabel *username_error_lbl;
    QLabel *password_error_lbl;
    Chat *chat;


public slots:
    void set_scene_signuppage();


};

#endif // REGISTER_H
