/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    profile_show.cpp
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

/*#include "profile_show.h"
#include "chat.h"

profile_show::profile_show(QString username, Chat *chatpage)
{
    this->chatpage = chatpage;
    this->join_scene = chatpage->scene;

    background_lbl =new QLabel;
    nameuser = username;
    firstname =new QLabel;
    lastname =new QLabel;
    name =new QLabel;
    ok_btn = new QPushButton("OK");

    join_scene->addWidget(ok_btn);
    join_scene->addWidget(background_lbl);
    join_scene->addWidget(firstname);
    join_scene->addWidget(lastname);
    join_scene->addWidget(name);

    ok_btn->setHidden(1);
    background_lbl->setHidden(1);
    firstname->setHidden(1);
    lastname->setHidden(1);
    name->setHidden(1);

    background_lbl->setGeometry(100,50,300,325);
    firstname->setGeometry(125,150,250,50);
    lastname->setGeometry(125,225,250,50);
    name->setGeometry(125,75,250,50);
    ok_btn->setGeometry(250,300,250,50);


    background_lbl->setStyleSheet("background-color:rgb(4, 51, 59)");

    QString arg_keys[1] = {"username"};
    QString arg_values[1] = {username};
    send_request("getname",1,arg_keys,arg_values);

    connect(ok_btn,&QPushButton::clicked,this,&profile_show::set_items_hidden);
}

void profile_show::set_items_hidden()
{
    ok_btn->setHidden(1);
    background_lbl->setHidden(1);
    firstname->setHidden(1);
    lastname->setHidden(1);
    name->setHidden(1);
}

void profile_show::set_items_show()
{
    ok_btn->setHidden(0);
    background_lbl->setHidden(0);
    firstname->setHidden(0);
    lastname->setHidden(0);
    name->setHidden(0);
}

void profile_show::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();

    firstname->setText("firstname : " + jObj["firstname"].toString());
    lastname->setText("lastname : " + jObj["lastname"].toString());
    name->setText("username : " + jObj["username"].toString());
}
*/
