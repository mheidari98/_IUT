#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    Bank.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

from raw_socket import *

def recive_penalty(raw_socket):

    penalty = raw_socket.recive_pkt(1024,16)
    file = open("files/balance.txt","r")  
    balance = file.read()
    if int(balance) < int(penalty):
        raw_socket.send_pkt('not enogh balance',[0,0,0,0,1,0,0,0,0])
    else:
        raw_socket.send_pkt('penalty was withdrawn',[0,0,0,0,1,0,0,0,0])
        file = open("files/balance.txt","w")
        file.write(str(int(balance)-int(penalty)))
        file.close()  

    raw_socket.recive_pkt(1024,16) 


def deposit_insurance(raw_socket):

    data = raw_socket.recive_pkt(1024,16)
    raw_socket.send_pkt('',[0,0,0,0,1,0,0,0,0])
    file = open("files/balance.txt","r")
    balance = file.read()
    balance = int(balance) + int(data) 
    file = open("files/balance.txt","w")
    file.write(str(balance))
    file.close()        

def withdraw_gas_cost(raw_socket):

    while 1:

        cost = raw_socket.recive_pkt(1024,16)
        if cost == 'end':
            raw_socket.send_pkt('',[0,0,0,0,1,0,0,0,0])
            break

        file = open("files/balance.txt","r")  
        balance = file.read()
        if int(balance) < int(cost):
            raw_socket.send_pkt('not enogh balance',[0,0,0,0,1,0,0,0,0])
        else:
            raw_socket.send_pkt('gas_cost was withdrawn',[0,0,0,0,1,0,0,0,0])
            file = open("files/balance.txt","w")
            file.write(str(int(balance)-int(cost)))
            file.close()  

        raw_socket.recive_pkt(1024,16) 


def main():

    src_ip = '192.168.1.14'

    insurance_socket = raw_socket(35355, src_ip, 0, 0, "bank" , "insurance")
    police_socket = raw_socket(44444, src_ip, 0, 0, "bank" , "police")
    driver_socket = raw_socket(50505, src_ip, 0, 0, "bank" , "driver")

    driver_socket.listen()
    driver_socket.accept()
    withdraw_gas_cost(driver_socket)
    driver_socket.recive_FIN()

    insurance_socket.listen()
    insurance_socket.accept()
    deposit_insurance(insurance_socket)
    insurance_socket.recive_FIN()


    police_socket.listen()
    police_socket.accept()
    recive_penalty(police_socket)
    police_socket.recive_FIN()


if __name__ == '__main__':
    main()
