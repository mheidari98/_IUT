/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    logout.cpp		
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "logout.h"


Logout::Logout(QString username, QString password):user(username),pass(password){}

void Logout::logout()
{
    QString arg_keys[2] = {"username", "password"};
    QString arg_values[2] = {user, pass};

    send_request("logout", 2, arg_keys, arg_values);
}


void Logout::server_reply(QNetworkReply *reply)
{
    QString reply_message = reply->readAll();
    QJsonDocument jDoc = QJsonDocument::fromJson(reply_message.toUtf8());
    QJsonObject jObj = jDoc.object();
    qDebug()<<jObj["message"].toString();
    qDebug()<<jObj["code"].toString();

    if(jObj["code"].toString().compare("200")==0)
    {
        QFile fprofile("fprofile.txt");
        if(fprofile.open(QFile::WriteOnly | QFile::Text))
        {
            QTextStream output(&fprofile);
            output << "0" <<"\n" << "0"<<"\n" << "0";
        }
        else
            qDebug()<<"could not open fprofile for reading";

        fprofile.close();
    }
}
