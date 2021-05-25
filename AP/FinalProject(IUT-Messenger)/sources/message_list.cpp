/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    message_list.cpp	
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "message_list.h"

Messages_List::Messages_List(QGraphicsScene *scene, QString owner, QString token, QString user)
{
    this->token = token;
    this->user = user;
    this->scene = scene;
    this->owner = owner;
    written_messageitem_num = 0;
    messageitem_num = 0;

    filename = owner +".txt";
    list = new QListWidget;

    scene->addWidget(list);

    list->setGeometry(0,50,500,400);

    list->setStyleSheet("background-image: url(:/pics/background.jpg)");

    list->setStyleSheet("font: 12pt Century");
}

Messages_List::~Messages_List()
{
    delete scene;
}

void Messages_List::read_chatsfile(QString contactname)
{
    chatsfile = new QFile(contactname+".txt");
    if(chatsfile->open(QFile::ReadOnly | QFile::Text))
    {
        QString msg_num, src, body;
        msg_num = chatsfile->readLine();
        QTextStream input(chatsfile);
        for(int i=0; i<msg_num.toInt(); i++)
        {
            src = input.readLine();
            body = input.readLine();

            if(src.compare(user)==0)
            {
                chat_item = new QListWidgetItem("You : " +body, list);
                chat_item->setBackgroundColor(QColor::fromRgb(64, 193, 193));
            }
            else
            {
                chat_item = new QListWidgetItem(src+ " : " +body, list);
                chat_item->setBackgroundColor(QColor::fromRgb(51, 153, 153));
            }
            chat_item->setSizeHint(QSize(0,50));
        }

    }
    else
       qDebug()<<"could not open "<< contactname << "'s file for reading";
}

int Messages_List::get_messages_num(QString json_message)
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

void Messages_List::send_request(QString request_type)
{
    QString arg_keys[2] = {"token", "dst"};
    QString arg_values[2] = {token, owner};
    Network::send_request(request_type,2,arg_keys,arg_values);
}

void Messages_List::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug() << "new messages got";
    if(jObj["code"].toString().compare("200")==0)
    {

        messageitem_num = get_messages_num(jObj["message"].toString());
        chatsfile = new QFile(filename);

        if(chatsfile->open(QFile::WriteOnly | QFile::Text))
        {
            for(int i=0; i<messageitem_num; i++)
            {
                QString block_no = QString::number(i);

                QJsonObject jObj2 = jObj["block "+ block_no].toObject();
                if(i==written_messageitem_num)
                {
                    chat_item = new QListWidgetItem(list);

                    if(!jObj2["src"].toString().compare(user))
                    {
                        chat_item->setBackgroundColor(QColor::fromRgb(64, 193, 193));
                        chat_item->setText("You : " + jObj2["body"].toString());
                    }
                    else
                    {
                        chat_item->setBackgroundColor(QColor::fromRgb(51, 153, 153));
                        chat_item->setText(jObj2["src"].toString()+ " : " + jObj2["body"].toString());
                    }
                    chat_item->setSizeHint(QSize(0,50));
                    written_messageitem_num++;
                }
                if(i==messageitem_num-1)
                    lastupdate_date = jObj2["date"].toString();

                QTextStream output(chatsfile);
                if(i==0)
                    output << messageitem_num <<"\n";

                output << jObj2["src"].toString() << "\n" << jObj2["body"].toString() <<"\n";

            }
            chatsfile->flush();
            chatsfile->close();
        }
        else
            qDebug()<<"could not open "<< owner << "'s file for reading";
    }
}
