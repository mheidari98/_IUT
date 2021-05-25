#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    Driver.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

from raw_socket import *

class MAPS:
    def __init__(self, src, dest, pomp_exist , distance , speed_allowed):
        self.src = src
        self.dest = dest
        self.pomp_exist = pomp_exist
        self.distance = distance
        self.speed_allowed = speed_allowed

def parse_MAPS(maps):
    maps = maps.split('\n')
    array = []
    for line in maps:
        arg1 , pomp_exist , distance , speed_allowed = line.split(',')
        src, dest = arg1.split('-')
        array.append(MAPS(src, dest, pomp_exist , distance , speed_allowed))
    return array

def request_for_pathfile(raw_socket):

    user_data = 'Hello I need mapsfile'
    raw_socket.send_pkt(user_data, [0,0,0,0,1,0,0,0,0])
    pathfile = raw_socket.recive_pkt(1024, 16)
    raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
    return pathfile

def pay_gas_cost(raw_socket, cost):

    raw_socket.send_pkt(cost, [0,0,0,0,1,0,0,0,0])
    report = raw_socket.recive_pkt(1024,16)
    raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
    if report == 'not enogh balance':
        return 0
    else:
        return 1    

def send_state(raw_socket_police , raw_socket_insurance, raw_socket_gas, raw_socket_bank, path_array):
    
    file = open("files/path.txt","r")
    start_state = file.readline()
    raw_socket_police.send_pkt(start_state, [0,0,0,0,1,0,0,0,0])
    raw_socket_police.recive_pkt(1024,16)
    
    balance, gas_quota, start_gas, gas_consumption = start_state.split(',')

    raw_socket_gas.send_pkt(gas_quota, [0,0,0,0,1,0,0,0,0])
    raw_socket_gas.recive_pkt(1024,16)

    kilometer = 0
    counter = 0
    current_fuel = int(start_gas)

    for state in file:
        path, current_speed , accident_status = state.split(',')

        raw_socket_police.send_pkt(state, [0,0,0,0,1,0,0,0,0])
        raw_socket_police.recive_pkt(1024,16)

        if int(accident_status) == 2:
            raw_socket_insurance.send_pkt(state, [0,0,0,0,1,0,0,0,0])
            raw_socket_insurance.recive_pkt(1024,16)

        if path_array[counter].pomp_exist == 'True':
            raw_socket_gas.send_pkt(str(kilometer * int(gas_consumption)), [0,0,0,0,1,0,0,0,0])
            price = raw_socket_gas.recive_pkt(1024,16)
            raw_socket_gas.send_pkt('', [0,0,0,0,1,0,0,0,0])
            if price != '0':
                done = pay_gas_cost(raw_socket_bank, price)
            else:
                done = 0
                
            if done == 1:
                current_fuel += kilometer * int(gas_consumption)
                kilometer = 0


        kilometer += int(path_array[counter].distance)
        current_fuel -= kilometer * int(gas_consumption)
        counter += 1

    raw_socket_police.send_pkt("end", [0,0,0,0,1,0,0,0,0])
    Crack_List = raw_socket_police.recive_pkt(1024, 16)
    raw_socket_police.send_pkt('', [0,0,0,0,1,0,0,0,0])

    raw_socket_gas.send_pkt("end", [0,0,0,0,1,0,0,0,0])
    raw_socket_gas.recive_pkt(1024, 16)

    raw_socket_insurance.send_pkt("end", [0,0,0,0,1,0,0,0,0])
    raw_socket_insurance.recive_pkt(1024, 16)

    raw_socket_bank.send_pkt("end", [0,0,0,0,1,0,0,0,0])
    raw_socket_bank.recive_pkt(1024, 16)

    print(Crack_List)

def main():

    src_ip = '192.168.1.13'
    #------------------------------------
    police_port = 55555
    police_ip = '192.168.1.12'
    police_socket = raw_socket(41555, src_ip, police_port, police_ip, "driver" , "police")
    #------------------------------------
    insurance_port = 33333
    insurance_ip = '192.168.1.11' 
    insurance_socket = raw_socket(41444, src_ip, insurance_port, insurance_ip, "driver" , "insurance")
    #------------------------------------
    gas_port = 22333
    gas_ip = '192.168.1.10' 
    gas_socket = raw_socket(41333, src_ip, gas_port, gas_ip, "driver" , "gas station")
    #------------------------------------
    bank_port = 50505
    bank_ip = '192.168.1.14' 
    bank_socket = raw_socket(41222, src_ip, bank_port, bank_ip, "driver" , "bank")
    #------------------------------------
    police_socket.connect()
    insurance_socket.connect()
    gas_socket.connect()
    bank_socket.connect()

    maps = request_for_pathfile(police_socket)
    path_array = parse_MAPS(maps)
    send_state(police_socket ,insurance_socket, gas_socket, bank_socket ,path_array)

    police_socket.send_FIN()
    insurance_socket.send_FIN()
    gas_socket.send_FIN()
    bank_socket.send_FIN()
    print("finished")

if __name__ == '__main__':
    main()
