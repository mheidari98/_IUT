#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    Insurance.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

from raw_socket import *

def recive_crash_report(raw_socket):
    insurance = 0
    while 1:
        state = raw_socket.recive_pkt(1024,16)
        raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
        if state != 'end':
            insurance += 500
        else:
            break    

    return insurance

def send_report_to_bank(raw_socket, insurance):

    raw_socket.send_pkt(str(insurance), [0,0,0,0,1,0,0,0,0])
    raw_socket.recive_pkt(1024,16)


def main():

    src_ip = '192.168.1.11'

    driver_socket = raw_socket(33333, src_ip, 0, 0, "insurance" , "driver")

    bank_port = 35355
    bank_ip = '192.168.1.14'
    bank_socket = raw_socket(42424, src_ip, bank_port, bank_ip, "insurance" , "bank")

    driver_socket.listen()
    driver_socket.accept()
    insurance = recive_crash_report(driver_socket)
    driver_socket.recive_FIN()

    bank_socket.connect()
    send_report_to_bank(bank_socket, insurance)
    bank_socket.send_FIN()


if __name__ == '__main__':
    main()
