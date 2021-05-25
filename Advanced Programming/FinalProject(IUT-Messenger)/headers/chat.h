/****************************************************************  
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    chat.h			
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/


#ifndef CHAT_H
#define CHAT_H


#include "screen.h"
#include "network.h"
#include "join_create.h"
#include "logout.h"
#include "message_list.h"
#include "chat_list.h"
#include <QTimer>
#include <QEventLoop>

class Chatroom;

class Chat : public Network, public screen
{
    Q_OBJECT

public:

    Chat(QGraphicsView* view, bool online);
    ~Chat();
    void show_menue();
    void show_user_list();
    void show_group_list();
    void show_channel_list();
    void start_newchat();
    void send_message();
    void deletefiles(QString filename);
    void update_grouplist();
    void update_channellist();
    void set_scene_loginpage();
    void set_selected_contact(QString contact);
    void set_thread_net_manager(QNetworkAccessManager* manager);
    virtual void server_reply(QNetworkReply*reply);


public slots:
    void check_connection();
    void handle_menueitem_click(QListWidgetItem* item);
    void handle_pvlistitem_click(QListWidgetItem* item);
    void handle_grouplistitem_click(QListWidgetItem* item);
    void handle_channelllistitem_click(QListWidgetItem* item);

protected:
    QFile *msgfile, *listfile;
    QTimer *timer, *timer_getmsg;
    Logout *logout;
    QListWidget *menue;
    QLineEdit *msg_Box;
    QPushButton *send_Button;
    Join_Create *selected_menueitem;
    QListWidgetItem *menue_item[6], *chat_item;
    QLabel* message_lbl, *profile_lbl, *connection_lbl;
    QString token, user, pass, contact, send_type;
    Chat_list *pv_list, *channel_list, *group_list;
    QPushButton *pv_list_button, *channel_list_button, *group_list_button, *menue_Button;
    QLabel *profile_pic;
    Messages_List *contact_msglist;
    int contact_num;
    bool check_open_menue, online;

public slots:
    void set_scene_pvpage();
    void update_pvlist();
    void update_current_msglist();


};

#endif // POGOC_H
