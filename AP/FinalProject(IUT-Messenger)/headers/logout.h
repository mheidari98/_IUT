/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    logout.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef LOGOUT_H
#define LOGOUT_H

#include "network.h"
#include "qdebug.h"

class Logout : public Network
{

public:
    Logout(QString username, QString password);
    void logout();
    virtual void server_reply(QNetworkReply *reply);

private:
    QString user , pass;
};

#endif // LOGOUT_H
