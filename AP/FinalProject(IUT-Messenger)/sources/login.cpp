/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    login.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "login.h"

Login::Login(QGraphicsView* view)
{

    this->view = view;
    view->setScene(scene);

    username_led = new QLineEdit;
    password_led = new QLineEdit;
    login_message = new QLabel;

    login_message->setAlignment(Qt::AlignCenter);
    password_led->setEchoMode(QLineEdit::Password);
    login_message->setHidden(true);

    username_led->setPlaceholderText("username*");
    password_led->setPlaceholderText("password*");

    login_Button = new QPushButton("login");
    signup_button = new QPushButton("singup");

    login_message->setStyleSheet("background : white");
    login_Button->setStyleSheet("background-color: #27a9e3;font: 14pt Century");

    scene->addWidget(username_led);
    scene->addWidget(password_led);
    scene->addWidget(login_message);
    scene->addWidget(login_Button);
    scene->addWidget(signup_button);

    username_led->setGeometry(150,200,200,30);
    password_led->setGeometry(150,250,200,30);
    login_message->setGeometry(125,300,250,30);
    login_Button->setGeometry(175,350,150,40);
    signup_button->setGeometry(200,400,100,30);


    connect(login_Button, &QPushButton::clicked, this, &Login::login);

}

void Login::login()
{
    if(password_led->text()!=Q_NULLPTR && username_led->text()!=Q_NULLPTR)
    {
        QString arg_keys[2] = {"username","password"};
        QString arg_values[2] = {username_led->text(),password_led->text()};
        send_request("login",2,arg_keys,arg_values);
    }
}

void Login::server_reply(QNetworkReply* reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();
    if(jObj["code"].toString().compare("200")== 0)
    {
        QFile fprofile("fprofile.txt");
        if(fprofile.open(QFile::WriteOnly | QFile::Text))
        {
            QTextStream output(&fprofile);
            output << jObj["token"].toString()<<"\n"<<username_led->text()<<"\n"<<password_led->text();

            fprofile.flush();
            fprofile.close();
        }
        else
            qDebug()<<"could not open fprofile";

        login_message->setHidden(false);
        login_message->setStyleSheet("color:green ; background:white ; font: 8pt Century");
        login_message->setText("<b>you are already logged in</b>");

        QTime dieTime= QTime::currentTime().addSecs(1);
            while (QTime::currentTime() < dieTime)
                QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
        set_scene_chatpage();

    }
    else if(jObj["code"].toString().compare("401")== 0)
    {
        login_message->setHidden(false);
        login_message->setStyleSheet("color:red ; background:white ; font: 8pt Century");
        login_message->setText("<b>sorry username or password is wrong</b>");
    }
    else
    {
        login_message->setHidden(false);
        login_message->setStyleSheet("color:red ; background:white ; font: 8pt Century");
        login_message->setText("<b>check your connection</b>");
    }

    username_led->clear();
    password_led->clear();

}

void Login::set_scene_loginpage()
{
    view->setScene(scene);
}

void Login::set_scene_chatpage()
{
    chat = new Chat(view, true);
}

Login::~Login()
{
    delete username_led;
    delete password_led;
    delete login_Button;
    delete signup_button;
    delete login_message;
    delete chat;
}

