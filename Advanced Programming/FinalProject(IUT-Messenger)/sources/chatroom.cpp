/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chatroom.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "chatroom.h"

Chatroom::Chatroom(QObject *parent) : QObject(parent)
{

    view = new QGraphicsView;

    view->setFixedSize(805,505);

    timer = new QTimer;
    connect(timer,SIGNAL(timeout()),this,SLOT(check_connection()));
    timer->start(5000);


    QFile fprofile("fprofile.txt");
    QString token;
    if(fprofile.open(QFile::ReadOnly | QFile::Text ))
    {
        QTextStream input(&fprofile);
        token = input.readLine();
        if(token.compare("0"))
           chat = new Chat(view, online);
        else
        {
            log = new Login(view);
            reg = new Register(view);
            connect(log->signup_button, &QPushButton::clicked, reg, &Register::set_scene_signuppage);
            connect(reg->login_Button, &QPushButton::clicked, log, &Login::set_scene_loginpage);
        }
    }
    else
    {
        qDebug()<<"could not open fprofile for reading";

        log = new Login(view);
        reg = new Register(view);
        connect(log->signup_button, &QPushButton::clicked, reg, &Register::set_scene_signuppage);
        connect(reg->login_Button, &QPushButton::clicked, log, &Login::set_scene_loginpage);

    }


    view->setStyleSheet("background-image: url(:/pics/background1.jpg)");
}

void Chatroom::check_connection()
{
    QNetworkAccessManager nam;
    QNetworkRequest req(QUrl("http://www.google.com"));
    QNetworkReply *reply = nam.get(req);
    QEventLoop loop;
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    loop.exec();
    if(reply->bytesAvailable())
    {
        online = true;
        qDebug()<< "online";
    }
    else
    {
        online = false;
        qDebug()<< "offline";
    }

}





