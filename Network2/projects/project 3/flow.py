'''
 Static Entry Pusher API :
    https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/1343518/Static+Entry+Pusher+API
'''
import httplib
import json
 
class StaticEntryPusher(object):
 
    def __init__(self, server):
        self.server = server
 
    def get(self, data):
        ret = self.rest_call({}, 'GET')
        return json.loads(ret[2])
 
    def set(self, data):
        ret = self.rest_call(data, 'POST')
        return ret[0] == 200
 
    def remove(self, objtype, data):
        ret = self.rest_call(data, 'DELETE')
        return ret[0] == 200
 
    def rest_call(self, data, action):
        path = '/wm/staticentrypusher/json'
        headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            }
        body = json.dumps(data)
        conn = httplib.HTTPConnection(self.server, 8080)
        conn.request(action, path, body, headers)
        response = conn.getresponse()
        ret = (response.status, response.reason, response.read())

        print ret

        conn.close()
        return ret
 
pusher = StaticEntryPusher('127.0.0.1')

flow1 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow_mod_1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.02",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"1",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->1,output=2"
    }
flow2 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow_mod_2",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.02",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"2",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->2,output=3"
    }
flow3 = {
    'switch':"00:00:00:00:00:00:00:03",
    "name":"flow_mod_3",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"2",
    "mpls_label":"2",

    "active":"true",
    
    "actions":"set_field=mpls_label->3,output=3"
    }
flow4 = {
    'switch':"00:00:00:00:00:00:00:02",
    "name":"flow_mod_4",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"2",
    "mpls_label":"1",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
flow5 = {
    'switch':"00:00:00:00:00:00:00:02",
    "name":"flow_mod_5",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"3",
    "mpls_label":"3",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
flow6 = {
    'switch':"00:00:00:00:00:00:00:04",
    "name":"flow_mod_6",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.04",
    "ipv4_dst":"10.0.0.05",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"1",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->6,output=5"
    }
flow7 = {
    'switch':"00:00:00:00:00:00:00:04",
    "name":"flow_mod_7",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.04",
    "ipv4_dst":"10.0.0.05",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"2",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->7,output=6"
    }
flow8 = {
    'switch':"00:00:00:00:00:00:00:06",
    "name":"flow_mod_8",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"5",
    "mpls_label":"7",

    "active":"true",
    
    "actions":"set_field=mpls_label->8,output=6"
    }
flow9 = {
    'switch':"00:00:00:00:00:00:00:05",
    "name":"flow_mod_9",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"5",
    "mpls_label":"6",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
flow10 = {
    'switch':"00:00:00:00:00:00:00:05",
    "name":"flow_mod_10",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"6",
    "mpls_label":"8",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
flow11 = {
    'switch':"00:00:00:00:00:00:00:07",
    "name":"flow_mod_11",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.07",
    "ipv4_dst":"10.0.0.08",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"1",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->11,output=8"
    }
flow12 = {
    'switch':"00:00:00:00:00:00:00:07",
    "name":"flow_mod_12",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.07",
    "ipv4_dst":"10.0.0.08",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"2",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->12,output=9"
    }
flow13 = {
    'switch':"00:00:00:00:00:00:00:09",
    "name":"flow_mod_13",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"8",
    "mpls_label":"12",

    "active":"true",
    
    "actions":"set_field=mpls_label->13,output=9"
    }
flow14 = {
    'switch':"00:00:00:00:00:00:00:08",
    "name":"flow_mod_14",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"8",
    "mpls_label":"11",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
flow15 = {
    'switch':"00:00:00:00:00:00:00:08",
    "name":"flow_mod_15",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"9",
    "mpls_label":"13",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }
 
pusher.set(flow1)
pusher.set(flow2)
pusher.set(flow3)
pusher.set(flow4)
pusher.set(flow5)

pusher.set(flow6)
pusher.set(flow7)
pusher.set(flow8)
pusher.set(flow9)
pusher.set(flow10)

pusher.set(flow11)
pusher.set(flow12)
pusher.set(flow13)
pusher.set(flow14)
pusher.set(flow15)
