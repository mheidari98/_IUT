#!/usr/bin/python3

n=3
k=1

for i in range(1,(n*3+1),3):
    src = i
    dst = i+1
    mid = i+2

    x1 = f"""flow{k} = {{
    'switch':"00:00:00:00:00:00:00:0{src}",
    "name":"flow_mod_{k}",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.0{src}",
    "ipv4_dst":"10.0.0.0{dst}",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"1",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->{k},output={dst}"
    }}"""
    k+=1

    x2 = f"""flow{k} = {{
    'switch':"00:00:00:00:00:00:00:0{src}",
    "name":"flow_mod_{k}",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.0{src}",
    "ipv4_dst":"10.0.0.0{dst}",
    "priority":"32768",
    "in_port":"1",

    "ip_tos":"2",

    "active":"true",
    
    "actions":"push_mpls=0x8847,set_field=mpls_label->{k},output={mid}"
    }}"""
    k+=1


    x3 = f"""flow{k} = {{
    'switch':"00:00:00:00:00:00:00:0{mid}",
    "name":"flow_mod_{k}",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"{dst}",
    "mpls_label":"{k-1}",

    "active":"true",
    
    "actions":"set_field=mpls_label->{k},output={mid}"
    }}"""
    k+=1

    x4 = f"""flow{k} = {{
    'switch':"00:00:00:00:00:00:00:0{dst}",
    "name":"flow_mod_{k}",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"{dst}",
    "mpls_label":"{k-3}",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }}"""
    k+=1

    x5 = f"""flow{k} = {{
    'switch':"00:00:00:00:00:00:00:0{dst}",
    "name":"flow_mod_{k}",
    "eth_type":"0x8847",
    "priority":"32768",
    "in_port":"{mid}",
    "mpls_label":"{k-2}",

    "active":"true",
    
    "actions":"pop_mpls=0x0800,output=1"
    }}"""
    k+=1

    print(x1)
    print(x2)
    print(x3)
    print(x4)
    print(x5)



for i in range(1, 5*n+1):
    print(f"pusher.set(flow{i})")
