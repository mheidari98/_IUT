/****************************************************************
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    profile_show.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef PROFILE_SHOW_H
#define PROFILE_SHOW_H

#include <QGraphicsScene>
#include <QPushButton>
#include <QLabel>
#include "network.h"

class Chat;


class profile_show : public Network
{
    Chat* chatpage;
    QString nameuser;
    QGraphicsScene *join_scene;
    QLabel *background_lbl,*firstname,*lastname,*name;
    QPushButton *ok_btn;
public:
    profile_show(QString username, Chat* chatpage);
    ~profile_show();
    void set_items_hidden();
    void set_items_show();
    virtual void server_reply(QNetworkReply *reply);
    friend class Chat;
};

#endif // PROFILE_SHOW_H
