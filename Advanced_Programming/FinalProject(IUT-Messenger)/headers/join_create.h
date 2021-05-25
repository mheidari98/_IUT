/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    join_create.h	
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef JOIN_CREATE_H
#define JOIN_CREATE_H

#include <QGraphicsScene>
#include <QLineEdit>
#include <QPushButton>
#include <QLabel>
#include <QCoreApplication>
#include <QTime>
#include "network.h"
#include "qdebug.h"
#include "windows.h"

class Chat;
class Join_Create : public Network
{

    Chat* chatpage;
    QFile* listfile;
    QString token, request_type;
    QGraphicsScene *join_scene;
    QLineEdit *name_led, *title_led;
    QLabel *background_lbl, *message_lbl;
    QPushButton *joinch_btn, *joingp_btn, *creategp_btn, *createch_btn ,*cancel_btn, *startchat_btn;


public:
    Join_Create(QString token, Chat* chatpage);
    ~Join_Create();
    void join_gp();
    void join_channel();
    void create_gp();
    void create_channel();
    void set_items_hidden();
    virtual void server_reply(QNetworkReply *reply);

    friend class Chat;

};

#endif // JOIN_H
