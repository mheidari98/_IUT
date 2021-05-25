/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    register.cpp
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include"register.h"

Register::Register(QGraphicsView* view)
{
    this->view = view;

    username_led = new QLineEdit;
    password_led = new QLineEdit;
    signup_message_lbl = new QLabel;
    firstname_led = new QLineEdit;
    lastname_led = new QLineEdit;
    password_error_lbl = new QLabel;
    username_error_lbl = new QLabel;
    register_Button = new QPushButton("register");
    login_Button = new QPushButton("login");

    signup_message_lbl->setStyleSheet("background : white");
    register_Button->setStyleSheet("background-color: #27a9e3 ; font: 14pt Century");
    password_error_lbl->setStyleSheet("color:red ; background:white ; font: 8pt Century");
    username_error_lbl->setStyleSheet("color:red ; background:white ; font: 8pt Century");
    password_error_lbl->setHidden(true);
    username_error_lbl->setHidden(true);


    password_error_lbl->setAlignment(Qt::AlignCenter);
    username_error_lbl->setAlignment(Qt::AlignCenter);
    signup_message_lbl->setAlignment(Qt::AlignCenter);
    password_led->setEchoMode(QLineEdit::Password);

    signup_message_lbl->setHidden(true);

    firstname_led->setPlaceholderText("firstname");
    lastname_led->setPlaceholderText("lastname");
    username_led->setPlaceholderText("username*");
    password_led->setPlaceholderText("password*");

    scene->addWidget(username_led);
    scene->addWidget(password_led);
    scene->addWidget(signup_message_lbl);
    scene->addWidget(firstname_led);
    scene->addWidget(lastname_led);
    scene->addWidget(register_Button);
    scene->addWidget(login_Button);
    scene->addWidget(password_error_lbl);
    scene->addWidget(username_error_lbl);

    username_led->setGeometry(150,200,200,30);
    password_led->setGeometry(150,250,200,30);
    signup_message_lbl->setGeometry(125,300,250,30);
    firstname_led->setGeometry(150,100,200,30);
    lastname_led->setGeometry(150,150,200,30);
    register_Button->setGeometry(175,350,150,40);
    login_Button->setGeometry(200,400,100,30);
    password_error_lbl->setGeometry(370,250,100,30);
    username_error_lbl->setGeometry(370,200,100,30);

    connect(register_Button, &QPushButton::clicked, this, &Register::signup);


}

Register::~Register()
{
    delete firstname_led;
    delete lastname_led;
    delete username_led;
    delete password_led;
    delete password_error_lbl;
    delete username_error_lbl;
    delete login_Button;
    delete register_Button;
    delete signup_message_lbl;
    delete chat;
}

void Register::signup()
{
    if(password_led->text()!=Q_NULLPTR && username_led->text()!=Q_NULLPTR)
    {
        QString arg_keys[4] = {"firstname","lastname","username","password"};
        QString arg_values[4] = {firstname_led->text(),lastname_led->text(),username_led->text(),password_led->text()};
        send_request("signup",4,arg_keys,arg_values);
    }
    if(password_led->text()==Q_NULLPTR)
    {
        password_error_lbl->setHidden(false);
        password_error_lbl->setText("Password is empty");
        signup_message_lbl->setHidden(true);
    }
    else
        password_error_lbl->setHidden(true);

    if(username_led->text()==Q_NULLPTR)
    {
        username_error_lbl->setHidden(false);
        username_error_lbl->setText("Username is empty");
        signup_message_lbl->setHidden(true);
    }
    else
        username_error_lbl->setHidden(true);
}

void Register::server_reply(QNetworkReply* reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();
    if(jObj["code"].toString().compare("204")== 0)
    {
        signup_message_lbl->setHidden(false);
        signup_message_lbl->setStyleSheet("color:red ; background:white ; font: 8pt Century");
        signup_message_lbl->setText("<b>username exists try another</b>");
    }
    else if (jObj["code"].toString().compare("200")== 0)
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

        signup_message_lbl->setHidden(false);
        signup_message_lbl->setStyleSheet("color:green ; background:white ; font: 8pt Century");
        signup_message_lbl->setText("<b>signedup successfuly</b>");

        QTime dieTime= QTime::currentTime().addSecs(1);
            while (QTime::currentTime() < dieTime)
                QCoreApplication::processEvents(QEventLoop::AllEvents, 100);

        set_scene_chatpage();

    }
    else
    {
        signup_message_lbl->setHidden(false);
        signup_message_lbl->setStyleSheet("color:red ; background:white ; font: 8pt Century");
        signup_message_lbl->setText("<b>check your connection</b>");
    }

    firstname_led->clear();
    lastname_led->clear();
    username_led->clear();
    password_led->clear();

}


void Register::set_scene_signuppage()
{
    view->setScene(scene);
}

void Register::set_scene_chatpage()
{
    chat = new Chat(view, true);
}

