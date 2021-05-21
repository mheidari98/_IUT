#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    raw_socket.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

#! /usr/bin/python

from __future__ import print_function
import socket,sys,struct,os
from ctypes import *
from netaddr import IPNetwork,IPAddress
from textwrap import wrap
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
import random 
from packing import *
import threading
import sys
from simplecrypt import encrypt, decrypt
from base64 import b64encode, b64decode
from getpass import getpass
from cryptography.fernet import Fernet  #faz2
from termcolor import colored, cprint   #for coloring

class raw_socket:
    
    def __init__(self, src_port, src_ip, dest_port, dest_ip , src_name , dest_name , MAX_pkt_size=100 ):

        self.sock = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
        self.seq_no = random.randrange(1, 100, 1)
        self.ack_no = 0
        self.src_port = src_port
        self.src_ip = src_ip
        self.dest_port = dest_port
        self.dest_ip = dest_ip
        
        self.src_name = src_name
        self.dest_name = dest_name
        
        self.MAX_pkt_size = MAX_pkt_size
        
        self.pack_id = random.randrange(1, 100, 1)
        
        self.set_timer = 0
        self.last_pkt_send = 0
        self.t = threading.Timer(20.0, self.timeout)  
        self.lock = threading.Lock()
        
        self.fragmented = False
 
    def timeout(self):
        self.lock.acquire()
        
        self.t.cancel()
        
        self.sock.sendto(self.last_pkt_send, (self.dest_ip , self.dest_port ))
        
        self.t = threading.Timer(20.0, self.timeout)
        self.t.start()
        
        self.lock.release()     
        print("--->TIMEOUT!")

    def listen(self):
        self.sock.bind((self.src_ip, self.src_port))
        print('listening...\n')

    def parse_receive_msg(self, raw_buffer):

        ip_header = struct.unpack('!BBHHHBBH4s4s',raw_buffer[:20])   
        tcp_header = struct.unpack('!HHLLBBH',raw_buffer[20:36])
        user_data = raw_buffer[36:]
        return ip_header , tcp_header , user_data

    def encrypt(self , msg, faz=1):
        if faz :
            cipher = encrypt(self.password, msg)
            user_data = b64encode(cipher) #encoded_cipher
        else:
            cipher_suite = Fernet(self.password)
            user_data = cipher_suite.encrypt( msg.encode("utf-8")) #encoded_text
        return user_data , msg
    
    def decrypt(self , msg, faz=1):
        if faz :
            cipher = b64decode(msg)
            user_data = decrypt(self.password, cipher) #plaintext
        else :
            cipher_suite = Fernet(self.password)    
            user_data = cipher_suite.decrypt(msg)  #decoded_text
        return user_data , msg
            
        
    def recive_pkt(self, byte, expected_flag):

        while 1:
            raw_buffer = self.sock.recv(byte)
            ip_header , tcp_header , user_data = self.parse_receive_msg(raw_buffer)

            dst_ip = socket.inet_ntoa(ip_header[9])
            dst_port = tcp_header[1]
            flag = tcp_header[5]
            #flags=[HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
            if self.src_ip == dst_ip and self.src_port == dst_port:
                if (flag == expected_flag) or (flag == expected_flag+8) or (flag == expected_flag+12): #and verify checksum
                    # Ack is not valid or if it is valid recived ack_no = seq_no
                    if ((flag / 16) % 2 == 0) or ((flag / 16) % 2 == 1 and tcp_header[3] == self.seq_no):
                        if tcp_header[2] == self.ack_no or not(self.ack_no):
                            if self.check_checksum( ip_header[8] ,ip_header[9] ,raw_buffer[20:36] , user_data):
                                break
                            else:
                                print("checkum wrong!!")
                        else :
                            print("recive repative pkt with seq={} , expected={}".format(tcp_header[2] , self.ack_no ))

        #stop timer
        if self.set_timer and self.set_timer == tcp_header[2]:
            self.lock.acquire()
            self.t.cancel()
            self.lock.release()
            self.set_timer = 0
        
        self.ack_no = tcp_header[2] + 1
        if flag == 2: #at the first of connection, sender send SYN
            self.dest_ip = socket.inet_ntoa(ip_header[8])
            self.dest_port = tcp_header[0]

        cipher_text = ''
        if user_data!='':
            user_data , cipher_text = self.decrypt(user_data)
        
        if not(self.fragmented) and (flag / 8) % 2: #if PSH flag = 1 means packet is a fragment of another pakhet
            print("============START defragment============")
            self.show_debug(1 , ip_header , tcp_header , user_data , cipher_text)
            self.fragmented = True
            user_data =  self.defragment(user_data, expected_flag, byte)
        else:
            self.show_debug(1 , ip_header , tcp_header , user_data , cipher_text)
        
        if self.fragmented :
            return user_data , flag
        
        
        return user_data

    def defragment(self, user_data, expected_flag, byte):
        recived_data = ''
        recived_data += user_data
        # if PSH flag = 1 maens packet is the last fragment 
        while True:
            self.send_pkt('',[0,0,0,0,1,0,0,0,0])
            msg ,flags = self.recive_pkt(byte, expected_flag)
            recived_data += msg
            if flags == expected_flag+12 :
                break
        self.fragmented = False
        print("recived_data after defragment = " , recived_data)
        print("============FINISH defragment============")
        return recived_data

    def send_pkt(self, user_data, flags):

        if len(user_data) > self.MAX_pkt_size:
            print("============START fragment============")
            self.fragment(user_data, flags)
            return 
        
        plain_text = ''
        if  user_data != '':
            user_data , plain_text = self.encrypt(user_data)
        
        tcp_header = construct_tcp_header(self.src_ip , self.dest_ip , self.src_port , self.dest_port ,self.seq_no ,self.ack_no ,flags,
                                      user_data,doff=4)
        ip_header = construct_ip_header(self.src_ip , self.dest_ip , ihl=5 , ver=4 , pid=self.pack_id ,offs=0,ttl=255 
                                    ,proto=socket.IPPROTO_RAW)
        packet = construct_tcp_packet(ip_header , tcp_header , user_data)
        self.sock.sendto(packet, (self.dest_ip , self.dest_port ))
        
        self.last_pkt_send = packet 
        
        #start timer
        if self.set_timer:
            self.lock.acquire()
            self.t.cancel()
            self.lock.release() 
        if not(user_data=='') :  #  or tcp_header[5]==16 ...
            self.set_timer = self.ack_no 
            self.t = threading.Timer(20.0, self.timeout)
            self.t.start()
            

        
        self.show_debug(0 , ip_header , tcp_header ,plain_text ,  user_data)
        self.seq_no += 1
        self.pack_id += 1

    def fragment(self, user_data, flags):
        #flags=[HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
        flags[5] = 1
        list =[]
        for i in range(0, len(user_data), self.MAX_pkt_size):
            list.append(user_data[i:i+self.MAX_pkt_size])
        for i in range (len(list)):
            if i == len(list)-1:
                flags[6] = 1
            self.send_pkt(list[i], flags)
            if i != len(list)-1:
                self.recive_pkt(1024, 16)
        print("============FINISH fragment============")

    def connect(self):

        #flags=[HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
        self.send_pkt('', [0,0,0,0,0,0,0,1,0])
        self.recive_pkt(1024, 18)
        self.password = str((self.seq_no - 1)*(self.ack_no-1))
        self.send_pkt('', [0,0,0,0,1,0,0,0,0])
        #print("pass = ", self.password)
        print('successfuly connected to ip:{} prt:{}'.format(self.dest_ip , self.dest_port))

    def accept(self):

        #flags=[HS,CWR,ECE,URG,ACK,PSH,RST,SYN,FIN]
        self.recive_pkt(1024, 2)
        self.send_pkt('', [0,0,0,0,1,0,0,1,0])
        self.password = str((self.seq_no - 1)*(self.ack_no-1))
        self.recive_pkt(1024, 16)
        #print("pass = ", self.password)
        print('successfuly connected to ip:{} prt:{}'.format(self.dest_ip , self.dest_port))

    def send_FIN(self):

        self.send_pkt('', [0,0,0,0,0,0,0,0,1])
        self.recive_pkt(1024, 17)
        self.send_pkt('', [0,0,0,0,1,0,0,0,0])
        self.sock.close()
        print('connestion closed successfuly !')

    def recive_FIN(self):

        self.recive_pkt(1024, 1)
        self.send_pkt('', [0,0,0,0,1,0,0,0,1])
        self.recive_pkt(1024, 16)
        self.sock.close()
        print('connestion closed successfuly !')
        
    def show_debug(self, mode , ip_header , tcp_header , user_data , encrypted_data):  #mode 0:send & 1:recv

        if mode:
            cprint("--------recive------------" )
            cprint("{} recive from {}".format(self.src_name , self.dest_name))
            cprint('ip header={}'.format(ip_header) , 'yellow')
            cprint('tcp header={}'.format(tcp_header) , 'yellow')  
            cprint('user data={}'.format(encrypted_data) , 'blue')
            cprint('decrypted msg={}'.format(user_data) , 'yellow')
        else:
            cprint("--------send------------")
            cprint("{} send to {}".format(self.src_name , self.dest_name))
            cprint('ip header={}'.format(struct.unpack('!BBHHHBBH4s4s',ip_header )) , 'red')
            cprint('tcp header={}'.format(struct.unpack('!HHLLBBH',tcp_header )) , 'red') 
            cprint('user data={}'.format(user_data) , 'red')
            cprint('encrypted msg={}'.format(encrypted_data) , 'blue')
        
    def check_checksum( self ,source_address ,dest_address ,tcp_header ,user_data ):
        # source_address = socket.inet_aton( src_ip )
        # dest_address = socket.inet_aton( dest_ip)
        placeholder = 0
        protocol = socket.IPPROTO_RAW
        tcp_length = len(tcp_header) + len(user_data)
        
        psh = struct.pack('!4s4sBBH' , source_address , dest_address , placeholder , protocol , tcp_length)
        psh = psh + tcp_header + user_data
        s = 0
        # loop taking 2 characters at a time
        for i in range(0, len(psh)-1, 2):
            w = ord(psh[i]) + (ord(psh[i+1]) << 8 )
            s = s + w
        
        s = (s>>16) + (s & 0xffff)
        #print("check sum = " , s )
        if s == 65535:  # or 0xFFFF = 0b1111111111111111
            return 1
        else:
            return 0



