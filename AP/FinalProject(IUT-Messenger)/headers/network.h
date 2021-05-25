/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    network.h
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#ifndef NETWORK_H
#define NETWORK_H


#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QUrl>
#include <QUrlQuery>
#include <QFile>
#include <QObject>
#include <QTextStream>

class Network : public QObject
{


    QNetworkRequest request;
    QJsonDocument jDoc;
    QJsonObject jObj;

public:
    Network();
    ~Network();
    void disconnect_manager();
    void send_request(QString command,int arg_num,QString* arg_keys,QString* arg_values);
    virtual void server_reply(QNetworkReply* reply)=0;
    QNetworkAccessManager* net_manager_server;
    QNetworkAccessManager* net_manager;

};

#endif // NETWORK_H
