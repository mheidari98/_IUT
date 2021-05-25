/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chat_list.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "chat_list.h"

Chat_list::Chat_list(QGraphicsScene *scene,QString list_type)
{
    QFile fprofile("fprofile.txt");
    if(fprofile.open(QFile::ReadOnly | QFile::Text))
    {
        QTextStream input(&fprofile);
        token = input.readLine();
        user = input.readLine();
    }
    else
        qDebug()<<"could not open fprofile for reading";

    fprofile.close();
    listitem_num =0;
    written_listitem_num =0;
    this->list_type = list_type;
    this->scene = scene;

    list = new QListWidget;

    scene->addWidget(list);

    list->setGeometry(500,100,300,400);

    list->setStyleSheet("font: 12pt Century");

}

Chat_list::~Chat_list()
{
    delete scene;
    delete list;
    delete list_item;
}
int Chat_list::get_listitem_num(QString json_message)
{
    int num = 0,a=0;
    for(int i=0; i < json_message.size() ; i++)
    {
        if(a%2 && json_message.at(i) != QChar('-'))
        {
            QChar C=json_message[i];
            num = num*10 + ( C.digitValue());
        }
        if(json_message.at(i) == QChar('-'))
            a++;
    }

    return num;
}

void Chat_list::get_new_messages(QString request_type)
{
    current_msglist->send_request(request_type);
}

void Chat_list::set_current_msg_list(QString contactname)
{
    for(int i=0; i<listitem_num; i++)
    {
        if(!msg_list[i]->owner.compare(contactname))
        {
            current_msglist = msg_list[i];
            current_msglist->list->setHidden(0);
        }
        else
            msg_list[i]->list->setHidden(1);
    }
}

void Chat_list::read_listfile()
{
    if(!list_type.compare("userlist"))
        listfile = new QFile("pv_list.txt");

    else if(!list_type.compare("grouplist"))
        listfile = new QFile("gp_list.txt");

    else if(!list_type.compare("channellist"))
        listfile = new QFile("ch_list.txt");


    if(listfile->open(QFile::ReadOnly | QFile::Text))
    {
        QTextStream input(listfile);
        int num = input.readLine().toInt();

        QString new_contact;

        for(int i=0;i<num;i++)
        {
            new_contact = input.readLine();
            list_item = new QListWidgetItem(new_contact, list);
            msg_list[i] = new Messages_List(scene,new_contact,token, user);
            msg_list[i]->read_chatsfile(new_contact);

           if((i+num)%2)
               list_item->setBackgroundColor(QColor::fromRgb(64, 193, 193));
           else
               list_item->setBackgroundColor(QColor::fromRgb(51, 153, 153));
           list_item->setSizeHint(QSize(0,50));

         }
        listitem_num = num;

        listfile->close();
    }

    else
        qDebug()<<"could not open" << list_type << "for reading";
}

void Chat_list::new_pv_chat(QString new_contact)
{
    msg_list[written_listitem_num] = new Messages_List(scene, new_contact, token, user);
    list_item = new QListWidgetItem(new_contact, list);
    set_current_msg_list(new_contact);

    if(written_listitem_num%2)
        list_item->setBackgroundColor(QColor::fromRgb(51, 153, 153));
    else
        list_item->setBackgroundColor(QColor::fromRgb(64, 193, 193));
    list_item->setSizeHint(QSize(0,50));
    written_listitem_num++;
    listitem_num;
}

void Chat_list::set_msglist_hidden()
{
    for(int i=0; i<listitem_num; i++)
        msg_list[i]->list->setHidden(1);
}

void Chat_list::send_request(QString request_type)
{
    QString arg_keys[1] = {"token"};
    QString arg_values[1] = {token};
    Network::send_request(request_type,1,arg_keys,arg_values);
}

void Chat_list::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();

    QString block_type;
    QString getmessage_type;

    if(jObj["code"].toString().compare("200")==0)
    {
        listitem_num = get_listitem_num(jObj["message"].toString());
        if(list_type.compare("userlist")==0)
        {
            block_type = "src";
            listfile = new QFile("pv_list.txt");
            getmessage_type = "getuserchats";
        }

        else if(list_type.compare("grouplist")==0)
        {
            block_type = "group_name";
            listfile = new QFile("gp_list.txt");
            getmessage_type = "getgroupchats";
        }

        else if(list_type.compare("channellist")==0)
        {
            block_type = "channel_name";
            listfile = new QFile("ch_list.txt");
            getmessage_type = "getchannelchats";
        }
        if(listfile->open(QFile::WriteOnly | QFile::Text))
        {
            for(int i=0; i<listitem_num; i++)
            {
                QString block_no = QString::number(i);

                QJsonObject jObj2 = jObj["block "+ block_no].toObject();

                if(i==written_listitem_num)
                {
                    list_item = new QListWidgetItem(jObj2[block_type].toString(), list);
                    qDebug()<< jObj2[block_type].toString() << "file is created";
                    msg_list[i] = new Messages_List(scene,jObj2[block_type].toString(),token,user);
                    msg_list[i]->send_request(getmessage_type);

                    qDebug()<<jObj2;

                    if(i%2)
                        list_item->setBackgroundColor(QColor::fromRgb(51, 153, 153));
                    else
                        list_item->setBackgroundColor(QColor::fromRgb(64, 193, 193));
                    list_item->setSizeHint(QSize(0,50));
                    written_listitem_num++;
                }
                    QTextStream output(listfile);

                    if(i==0)
                        output << listitem_num <<"\n";

                    output << jObj2[block_type].toString() <<"\n";
             }
             listfile->flush();
             listfile->close();
        }
        qDebug()<< "pvlist successfuly updated";
    }
}
