/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chat_list.h			
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef CHAT_LIST_H
#define CHAT_LIST_H

#include "network.h"
#include "screen.h"
#include "message_list.h"

class Chat_list : public Network
{
public:

    Chat_list(QGraphicsScene* scene, QString list_type);
    ~Chat_list();
    int get_listitem_num(QString jsonmessage);
    void set_current_msg_list(QString contactname);
    void get_new_messages(QString request_type);
    void send_request(QString request_type);
    void read_listfile();
    void new_pv_chat(QString new_contact);
    void set_msglist_hidden();
    virtual void server_reply(QNetworkReply*reply);

    friend class Chat;

private:

    QListWidget *list;
    QGraphicsScene *scene;
    QListWidgetItem *list_item;
    QFile *listfile, *fprofile;
    QString token, list_type, user;
    Messages_List *msg_list[50], *current_msglist;
    int listitem_num, written_listitem_num ;



};

#endif // GET_CHAT_LIST_H
