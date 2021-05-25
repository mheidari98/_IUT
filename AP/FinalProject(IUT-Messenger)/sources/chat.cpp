/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chat.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "chat.h"
#include "chatroom.h"

Chat::Chat(QGraphicsView* view, bool online):online(online)
{
    this->view = view;
    view->setScene(scene);

    QFile fprofile("fprofile.txt");
    if(fprofile.open(QFile::ReadOnly | QFile::Text))
    {
        QTextStream input(&fprofile);
        token = input.readLine();
        user = input.readLine();
        pass = input.readLine();
        qDebug() << token << user << pass;
    }
    else
        qDebug()<<"could not open fprofile for reading";

    fprofile.close();

    check_open_menue = false;
    msg_Box = new QLineEdit;
    profile_pic = new QLabel;
    connection_lbl = new QLabel;
    menue = new QListWidget;
    profile_lbl = new QLabel(user);
    menue_Button = new QPushButton("...");
    pv_list_button = new QPushButton("pv_chats");
    group_list_button = new QPushButton("groups");
    channel_list_button = new QPushButton("channels");
    send_Button = new QPushButton("Send");
    pv_list = new Chat_list(scene,"userlist");
    group_list = new Chat_list(scene,"grouplist");
    channel_list = new Chat_list(scene,"channellist");
    logout = new Logout(user, pass);

    timer = new QTimer;
    connect(timer,SIGNAL(timeout()),this,SLOT(check_connection()));
    timer->start(2000);

    scene->addWidget(send_Button);
    scene->addWidget(msg_Box);
    scene->addWidget(pv_list_button);
    scene->addWidget(channel_list_button);
    scene->addWidget(group_list_button);
    scene->addWidget(profile_lbl);
    scene->addWidget(menue);
    scene->addWidget(menue_Button);
    scene->addWidget(profile_pic);
    scene->addWidget(connection_lbl);

    msg_Box->setPlaceholderText("type message...");
    profile_lbl->setAlignment(Qt::AlignCenter);

    profile_lbl->setGeometry(500,0,300,50);
    connection_lbl->setGeometry(0,0,50,50);
    profile_pic->setGeometry(500,0,50,50);
    menue->setGeometry(600,50,200,305);
    msg_Box->setGeometry(0,450,400,50);
    menue_Button->setGeometry(750,0,50,50);
    send_Button->setGeometry(400,450,100,50);
    pv_list_button->setGeometry(500,50,100,50);
    group_list_button->setGeometry(600,50,100,50);
    channel_list_button->setGeometry(700,50,100,50);

    menue->setHidden(1);

    send_Button->setStyleSheet("background-color: #27a9e3;font: 14pt Century");
    pv_list_button->setStyleSheet("background-color: rgb(4, 51, 59);color: white ;font: 14pt Century;border-radius: 3px");
    channel_list_button->setStyleSheet("background-color: rgb(4, 51, 59);color: white ;font: 14pt Century;border-radius: 3px");
    group_list_button->setStyleSheet("background-color: rgb(4, 51, 59);color: white ;font: 14pt Century;border-radius: 3px");
    menue_Button->setStyleSheet("background-color:rgb(4, 51, 59);color: white ;font: 18pt Century;border-radius: 3px");
    profile_lbl->setStyleSheet("background-color:rgb(4, 51, 59);color: white ;font: 14pt Century");
    QPixmap pix(":/pics/propic.png");
    profile_pic->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));

    menue->setStyleSheet("font: 12pt Century");

    menue_item[0]= new QListWidgetItem("New Chat",menue);
    menue_item[1]= new QListWidgetItem("Join Group",menue);
    menue_item[2]= new QListWidgetItem("Join Channel",menue);
    menue_item[3]= new QListWidgetItem("Create Group",menue);
    menue_item[4]= new QListWidgetItem("Create Channel",menue);
    menue_item[5]= new QListWidgetItem("Logout",menue);

    for(int i=0;i<6;i++)
    {
        menue_item[i]->setBackgroundColor(QColor::fromRgb(4, 51, 59));
        menue_item[i]->setTextColor(QColor::fromRgb(255,255,255));
        menue_item[i]->setSizeHint(QSize(10, 50));
    }
    if(online)
    {
        QPixmap pix(":/pics/connected.png");
        connection_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
        update_pvlist();
        update_grouplist();
        update_channellist();

        timer = new QTimer;
        connect(timer,SIGNAL(timeout()),this,SLOT(update_pvlist()));
        timer->start(5000);

        timer_getmsg = new QTimer;
        connect(timer_getmsg,SIGNAL(timeout()),this,SLOT(update_current_msglist()));
        timer_getmsg->start(3000);
    }
    else
    {
        QPixmap pix(":/pics/unconnected.png");
        connection_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
        pv_list->read_listfile();
        channel_list->read_listfile();
        group_list->read_listfile();
    }
    connect(send_Button, &QPushButton::clicked, this, &Chat::send_message);

    connect(pv_list_button,&QPushButton::clicked,this,&Chat::show_user_list);
    connect(group_list_button,&QPushButton::clicked,this,&Chat::show_group_list);
    connect(channel_list_button,&QPushButton::clicked,this,&Chat::show_channel_list);

    connect(pv_list->list,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(handle_pvlistitem_click(QListWidgetItem*)));
    connect(group_list->list,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(handle_grouplistitem_click(QListWidgetItem*)));
    connect(channel_list->list,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(handle_channelllistitem_click(QListWidgetItem*)));

    connect(menue_Button,&QPushButton::clicked,this,&Chat::show_menue);
    connect(menue,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(handle_menueitem_click(QListWidgetItem*)));

   // list_tr = new Thread(this);
   // list_tr->start();

}

Chat::~Chat()
{
    delete timer;
    delete timer_getmsg;
}
void Chat::send_message()
{
    if(msg_Box->text()!= Q_NULLPTR)
    {
        QString arg_keys[3] = {"token","dst","body"};
        QString arg_values[3] = {token,contact,msg_Box->text()};
        send_request(send_type,3,arg_keys,arg_values);
    }
    qDebug()<< "you are chatting with " << contact;
    qDebug()<< "your type_sending is " << send_type;
}

void Chat::deletefiles(QString filename)
{
    listfile = new QFile( filename );
    listfile->open(QFile::ReadOnly | QFile::Text);
    QTextStream input(listfile);
    QString name;
    int num = input.readLine().toInt();
    for( int i=0 ; i<num ; i++)
    {
        name = input.readLine();
        msgfile = new QFile(name + ".txt");
        msgfile->open(QFile::ReadOnly | QFile::Text);
        msgfile->remove();
    }
    listfile->remove();
}

void Chat::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();

    msg_Box->clear();
}

void Chat::set_thread_net_manager(QNetworkAccessManager *manager)
{
    net_manager_server = manager;
}
void Chat::check_connection()
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
        QPixmap pix(":/pics/connected.png");
        connection_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
    }
    else
    {
        online = false;
        QPixmap pix(":/pics/unconnected.png");
        connection_lbl->setPixmap(pix.scaled (50,50,Qt::KeepAspectRatio));
    }
}

void Chat::update_pvlist()
{
    pv_list->send_request("getuserlist");
}

void Chat::update_grouplist()
{
    group_list->send_request("getgrouplist");
}

void Chat::update_channellist()
{
    channel_list->send_request("getchannellist");
}

void Chat::set_selected_contact(QString contact)
{
    this->contact = contact;
    top_frame->setText(contact);
    qDebug() << "now your contact is "<< contact;
}

void Chat::handle_menueitem_click(QListWidgetItem *item)
{
    selected_menueitem = new Join_Create(token, this);
    selected_menueitem->background_lbl->setHidden(0);
    selected_menueitem->name_led->setHidden(0);
    selected_menueitem->cancel_btn->setHidden(0);

    if(item->text().compare("Join Group")==0)
    {
       selected_menueitem->name_led->setPlaceholderText("group name*");
       selected_menueitem->joingp_btn->setHidden(0);
    }
    else if(item->text().compare("Join Channel")==0)
    {
       selected_menueitem->name_led->setPlaceholderText("channel name*");
       selected_menueitem->joinch_btn->setHidden(0);
    }
    else if(item->text().compare("Create Channel")==0)
    {
       selected_menueitem->name_led->setPlaceholderText("channel name*");
       selected_menueitem->title_led->setPlaceholderText("channel title");
       selected_menueitem->title_led->setHidden(0);
       selected_menueitem->createch_btn->setHidden(0);
    }
    else if(item->text().compare("Create Group")==0)
    {
       selected_menueitem->name_led->setPlaceholderText("group name*");
       selected_menueitem->title_led->setPlaceholderText("group title");
       selected_menueitem->title_led->setHidden(0);
       selected_menueitem->creategp_btn->setHidden(0);
    }
    else if(item->text().compare("New Chat")==0)
    {
        selected_menueitem->name_led->setPlaceholderText("username*");
        selected_menueitem->startchat_btn->setHidden(0);
        connect(selected_menueitem->startchat_btn, &QPushButton::clicked, this, &Chat::start_newchat);
    }
    else if(item->text().compare("Logout")==0)
    {
        selected_menueitem->set_items_hidden();
        logout->logout();
        Chatroom *chatroom = new Chatroom;
        timer->stop();
        timer_getmsg->stop();
        deletefiles("pv_list.txt");
        deletefiles("gp_list.txt");
        deletefiles("ch_list.txt");
        view->close();
        chatroom->view->show();
    }

}

void Chat::show_menue()
{
    if(!check_open_menue)
        menue->setHidden(0);
    else
        menue->setHidden(1);
    check_open_menue=!check_open_menue;
}

void Chat::show_user_list()
{
    pv_list->list->setHidden(0);
    group_list->list->setHidden(1);
    channel_list->list->setHidden(1);
}

void Chat::show_group_list()
{
    pv_list->list->setHidden(1);
    group_list->list->setHidden(0);
    channel_list->list->setHidden(1);
}

void Chat::show_channel_list()
{
    pv_list->list->setHidden(1);
    group_list->list->setHidden(1);
    channel_list->list->setHidden(0);
}

void Chat::start_newchat()
{
    set_selected_contact(selected_menueitem->name_led->text());
    selected_menueitem->set_items_hidden();
    pv_list->new_pv_chat(selected_menueitem->name_led->text());
    send_type = "sendmessageuser";
}


void Chat::update_current_msglist()
{
    if(!send_type.compare("sendmessageuser"))
        pv_list->get_new_messages("getuserchats");

    else if(!send_type.compare("sendmessagegroup"))
        group_list->get_new_messages("getgroupchats");

    else if(!send_type.compare("sendmessagechannel"))
        channel_list->get_new_messages("getchannelchats");
}


void Chat::handle_pvlistitem_click(QListWidgetItem *item)
{
    send_type = "sendmessageuser";
    set_selected_contact(item->text());
    qDebug() <<pv_list->listitem_num;
    pv_list->set_current_msg_list(contact);
    group_list->set_msglist_hidden();
    channel_list->set_msglist_hidden();
}

void Chat::handle_grouplistitem_click(QListWidgetItem *item)
{
    send_type = "sendmessagegroup";
    set_selected_contact(item->text());
    group_list->set_current_msg_list(contact);
    pv_list->set_msglist_hidden();
    channel_list->set_msglist_hidden();
}

void Chat::handle_channelllistitem_click(QListWidgetItem *item)
{
    send_type = "sendmessagechannel";
    set_selected_contact(item->text());
    channel_list->set_current_msg_list(contact);
    pv_list->set_msglist_hidden();
    group_list->set_msglist_hidden();
}

void Chat::set_scene_pvpage()
{
    view->setScene(scene);
}
