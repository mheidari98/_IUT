#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    Gas_Station.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

from raw_socket import *

def driver_charge_gas(raw_socket):

    gas_quota = raw_socket.recive_pkt(1024,16)
    gas_quota = int(gas_quota)
    raw_socket.send_pkt('',[0,0,0,0,1,0,0,0,0])
    price = 0
    while 1:

        gas_amount = raw_socket.recive_pkt(1024,16)

        if gas_amount == 'end':
            raw_socket.send_pkt('',[0,0,0,0,1,0,0,0,0])
            break

        if gas_quota >= int(gas_amount):
            price = int(gas_amount) * 10
            gas_quota -= int(gas_amount)
        else:
            price = (gas_quota) * 10
            price += (int(gas_amount) - gas_quota) * 20
            gas_quota = 0 

        raw_socket.send_pkt(str(price),[0,0,0,0,1,0,0,0,0])
        raw_socket.recive_pkt(1024,16)

def main():

    src_ip = '192.168.1.10'
    src_port = 22333

    driver_socket = raw_socket(src_port, src_ip, 0, 0, "gas station" , "driver")

    driver_socket.listen()
    driver_socket.accept()
    driver_charge_gas(driver_socket)
    driver_socket.recive_FIN()


if __name__ == '__main__':
    main()
