/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    login.h	
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef LOGIN_H
#define LOGIN_H

#include <QCoreApplication>
#include <QTime>
#include "screen.h"
#include "network.h"
#include "chat.h"

class Login : public Network, public screen
{


public:
    Login(QGraphicsView* view);
    ~Login();
    void login();
    void set_scene_chatpage();
    virtual void server_reply(QNetworkReply*);

    QPushButton *login_Button, *signup_button;
private:
    QLineEdit *username_led, *password_led;
    QLabel *login_message;
    Chat *chat;

public slots:
    void set_scene_loginpage();

};

#endif // LOGIN_H
