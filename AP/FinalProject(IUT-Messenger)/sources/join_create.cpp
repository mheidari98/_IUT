/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    join_create.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "join_create.h"
#include "chat.h"


Join_Create::Join_Create(QString token, Chat* chatpage): token(token)
{

    this->chatpage = chatpage;
    this->join_scene = chatpage->scene;

    message_lbl = new QLabel;
    background_lbl = new QLabel;
    name_led = new QLineEdit;
    title_led = new QLineEdit;
    joingp_btn = new QPushButton("join");
    joinch_btn = new QPushButton("join");
    createch_btn = new QPushButton("create");
    creategp_btn = new QPushButton("create");
    startchat_btn = new QPushButton("start");
    cancel_btn = new QPushButton("cancel");

    join_scene->addWidget(background_lbl);
    join_scene->addWidget(name_led);
    join_scene->addWidget(title_led);
    join_scene->addWidget(joingp_btn);
    join_scene->addWidget(joinch_btn);
    join_scene->addWidget(createch_btn);
    join_scene->addWidget(creategp_btn);
    join_scene->addWidget(startchat_btn);
    join_scene->addWidget(cancel_btn);
    join_scene->addWidget(message_lbl);


    message_lbl->setGeometry(100,60,300,40);
    name_led->setGeometry(150,110,200,30);
    title_led->setGeometry(150,150,200,30);
    joingp_btn->setGeometry(260,190,100,30);
    joinch_btn->setGeometry(260,190,100,30);
    createch_btn->setGeometry(260,190,100,30);
    creategp_btn->setGeometry(260,190,100,30);
    background_lbl->setGeometry(100,50,300,200);
    startchat_btn->setGeometry(260,190,100,30);
    cancel_btn->setGeometry(140,190,100,30);

    joingp_btn->setFixedSize(100,40);
    joinch_btn->setFixedSize(100,40);
    createch_btn->setFixedSize(100,40);
    creategp_btn->setFixedSize(100,40);
    startchat_btn->setFixedSize(100,40);
    cancel_btn->setFixedSize(100,40);

    joingp_btn->setStyleSheet("font: 14pt Century");
    joinch_btn->setStyleSheet("font: 14pt Century");
    createch_btn->setStyleSheet("font: 14pt Century");
    creategp_btn->setStyleSheet("font: 14pt Century");
    startchat_btn->setStyleSheet("font: 14pt Century");
    cancel_btn->setStyleSheet("font: 14pt Century");

    background_lbl->setStyleSheet("background-color:rgb(4, 51, 59)");

    message_lbl->setAlignment(Qt::AlignCenter);

    set_items_hidden();

    connect(joingp_btn, &QPushButton::clicked, this, &Join_Create::join_gp);
    connect(joinch_btn, &QPushButton::clicked, this, &Join_Create::join_channel);
    connect(createch_btn, &QPushButton::clicked, this, &Join_Create::create_channel);
    connect(creategp_btn, &QPushButton::clicked, this, &Join_Create::create_gp);
    connect(cancel_btn, &QPushButton::clicked, this, &Join_Create::set_items_hidden);
}

Join_Create::~Join_Create()
{
    delete name_led;
    delete title_led;
    delete cancel_btn;
    delete startchat_btn;
    delete background_lbl;
    delete joinch_btn;
    delete joinch_btn;
    delete createch_btn;
    delete creategp_btn;
    delete join_scene;
    delete message_lbl;
}

void Join_Create::join_gp()
{
    QString arg_keys[2] = {"token","group_name"};
    QString arg_values[2] = {token, name_led->text()};

    send_request("joingroup",2,arg_keys,arg_values);
    request_type = "joingroup";
}


void Join_Create::join_channel()
{
    QString arg_keys[2] = {"token","channel_name"};
    QString arg_values[2] = {token, name_led->text()};

    send_request("joinchannel",2,arg_keys,arg_values);
    request_type = "joinchannel";
}


void Join_Create::create_gp()
{
    QString arg_keys[3] = {"token","group_name","group_title"};
    QString arg_values[3] = {token, name_led->text(), title_led->text()};

    send_request("creategroup",2,arg_keys,arg_values);
    request_type = "creategroup";
}

void Join_Create::create_channel()
{
    QString arg_keys[3] = {"token","channel_name","channel_title"};
    QString arg_values[3] = {token, name_led->text(), title_led->text()};

    send_request("createchannel",2,arg_keys,arg_values);
    request_type = "createchannel";
}

void Join_Create::set_items_hidden()
{
    name_led->setHidden(1);
    title_led->setHidden(1);
    cancel_btn->setHidden(1);
    joingp_btn->setHidden(1);
    joinch_btn->setHidden(1);
    createch_btn->setHidden(1);
    creategp_btn->setHidden(1);
    startchat_btn->setHidden(1);
    background_lbl->setHidden(1);
    message_lbl->setHidden(1);
}

void Join_Create::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();

    message_lbl->setHidden(0);
    if(jObj["code"].toString().compare("200")==0)
    {
        if(!request_type.compare("joingroup") || !request_type.compare("creategroup"))
            chatpage->update_grouplist();

        else if(!request_type.compare("joinchannel") || !request_type.compare("createchannel"))
            chatpage->update_channellist();

        name_led->clear();
        title_led->clear();

        message_lbl->setStyleSheet("background-color:rgb(4, 51, 59);color:rgb(52, 172, 70);font: 14pt Century");
        message_lbl->setText("successfully done !");
    }
    else
    {
        message_lbl->setStyleSheet("background-color:rgb(4, 51, 59);color:rgb(255, 0, 0);font: 14pt Century");
        message_lbl->setText("sorry something is wrong !");
    }

    QTime dieTime= QTime::currentTime().addSecs(1);
        while (QTime::currentTime() < dieTime)
            QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
    set_items_hidden();
}
