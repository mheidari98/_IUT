/****************************************************************   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jun 2018 				
# 	Module Name:    network.cpp	
# 	Project Name:   IUT_Messenger	
#								
#								
****************************************************************/

#include "network.h"

Network::Network()
{
    net_manager = new QNetworkAccessManager(this);

    connect(net_manager, &QNetworkAccessManager::finished, this, &Network::server_reply);
}

Network::~Network()
{
    delete net_manager;
}

void Network::disconnect_manager()
{
    disconnect(net_manager, &QNetworkAccessManager::finished, this, &Network::server_reply);
    delete net_manager;
}

void Network::send_request(QString command, int arg_num, QString *arg_keys, QString *arg_values)
{
    QUrl url("http://api.softserver.org:1104/" + command);
    QUrlQuery query;

    for(int i=0;i<arg_num;i++)
         query.addQueryItem(arg_keys[i], arg_values[i]);

    url.setQuery(query);
    request.setUrl(url);
    net_manager->get(request);
}
