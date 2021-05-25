/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    message_list.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef MESSAGES_LIST_H
#define MESSAGES_LIST_H

#include "screen.h"
#include "network.h"

class Messages_List : public Network
{


public:
    Messages_List(QGraphicsScene* scene, QString fileowner, QString token, QString user);
    ~Messages_List();
    int get_messages_num(QString Jsonmessage);
    void send_request(QString request_type);
    void read_chatsfile(QString contactname);
    virtual void server_reply(QNetworkReply *);

    friend class Chat_list;
    friend class Chat;

private:
    QFile *chatsfile;
    QListWidget *list;
    QGraphicsScene *scene;
    QListWidgetItem *chat_item;
    QString token, filename, owner, lastupdate_date, user;
    int messageitem_num, written_messageitem_num;

};

#endif // MESSAGES_LIST_H


