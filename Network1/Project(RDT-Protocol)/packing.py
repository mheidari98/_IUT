#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    packing.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

#!/usr/bin/python

import socket,sys,struct,os
from ctypes import *
from netaddr import IPNetwork,IPAddress
import binascii
import urlparse
import thread
import time
import random
import re
import fcntl
import signal
import binascii
import subprocess

# checksum functions is needed for calculation checksum
def checksum(msg):
    s = 0
     
    # loop taking 2 characters at a time
    for i in range(0, len(msg)-1, 2):
        w = ord(msg[i]) + (ord(msg[i+1]) << 8 )
        s = s + w
     
    s = (s>>16) + (s & 0xffff)
    #s = s + (s >> 16)
     
    #complement and mask to 4 byte short
    s = ~s & 0xffff
     
    return s

##########################################################################################
"""
Construct an IP header.
For a TCP packet, only source and destination IPs need to be set.
source_ip = str IP of sender
dest_ip   = str IP of receiver
ihl       = Internet Header Length. Default is 5 (20 bytes).
ver       = IP version. default is 4
pid       = ID of the packet. So that split packets may be reassembled in order.
offs      = Fragment offset if any. default 0
ttl       = Time To Live for the packet. default 255
proto     = Protocol for contained packet. default is TCP.
"""
def construct_ip_header(source_ip,dest_ip,ihl=5,ver=4,pid=0,offs=0,ttl=255,proto=socket.IPPROTO_RAW):
    ip_ihl = ihl
    ip_ver = ver
    ip_tos = 0
    ip_tot_len = 0  # kernel will fill the correct total length
    ip_id = pid     # Id of this packet
    ip_frag_off = offs
    ip_ttl = ttl
    ip_proto = proto
    ip_check = 0   # kernel will fill the correct checksum
    ip_saddr = socket.inet_aton ( source_ip )
    ip_daddr = socket.inet_aton ( dest_ip )
    
    ip_ihl_ver = (ip_ver << 4) + ip_ihl
    
    # the ! in the pack format string means network order
    ip_header = struct.pack('!BBHHHBBH4s4s' , ip_ihl_ver, ip_tos, ip_tot_len, ip_id, ip_frag_off, ip_ttl, ip_proto, ip_check, ip_saddr, ip_daddr)
    return ip_header

##########################################################################################
"""
Construct a TCP header.
source_ip = str IP of sender
dest_ip   = str IP of receiver
srcp      = source port number
dstp      = receiver port number
seq       = TCP sequence number: set a random number for first package and the ack number of previous received ACK package otherwise.
ackno     = TCP ack number: previous received seq + number of bytes received
flags     = TCP flags in an array with the structure [HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
user_data = string with the data to send
doff      = data offset, default 0
"""
def construct_tcp_header(source_ip,dest_ip,srcp,dstp,seq,ackno,flags,user_data="",doff=4):
    tcp_source = srcp   # source port
    tcp_dest = dstp     # destination port
    tcp_seq = seq
    tcp_ack_seq = ackno
    tcp_doff = doff
    #tcp flags
    #flags=[HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
    tcp_fin = flags[8]
    tcp_syn = flags[7]
    tcp_rst = flags[6]
    tcp_psh = flags[5]
    tcp_ack = flags[4]
    tcp_urg = flags[3]
    tcp_check = 0
    
    tcp_offset_res = (tcp_doff << 4) + 0
    tcp_flags = tcp_fin + (tcp_syn << 1) + (tcp_rst << 2) + (tcp_psh <<3) + (tcp_ack << 4) + (tcp_urg << 5)
    
    # the ! in the pack format string means network order
    tcp_header = struct.pack('!HHLLBBH' , tcp_source, tcp_dest, tcp_seq, tcp_ack_seq, tcp_offset_res, tcp_flags, tcp_check)
    
    # pseudo header fields
    source_address = socket.inet_aton( source_ip )
    dest_address = socket.inet_aton(dest_ip)
    placeholder = 0
    protocol = socket.IPPROTO_RAW
    tcp_length = len(tcp_header) + len(user_data)
    
    psh = struct.pack('!4s4sBBH' , source_address , dest_address , placeholder , protocol , tcp_length)
    psh = psh + tcp_header + user_data
    
    tcp_check = checksum(psh)
    
    # make the tcp header again and fill the correct checksum
    tcp_header = struct.pack('!HHLLBB' , tcp_source, tcp_dest, tcp_seq, tcp_ack_seq, tcp_offset_res, tcp_flags) + struct.pack('H' , tcp_check)
    return tcp_header

def construct_tcp_packet(ip_header,tcp_header,user_data=""):
    packet=''
    packet = ip_header + tcp_header + user_data
    return packet
