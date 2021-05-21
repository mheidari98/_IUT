#################################################################   
#								
# 								
# 	Creator Name:   Sara Baradaran, Mahdi Heidari		
# 	Create Date:    Jan 2020 				
# 	Module Name:    Police.py 				
# 	Project Name:   Reliable-Data-Transfer-Protocol 	
#								
#								
#################################################################

from raw_socket import *

#MAPS------------------------------------------------
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
#driver PATH------------------------------------------------
class PATH:
    def __init__(self, src, dest, current_speed , accident_status):
        self.src = src
        self.dest = dest
        self.current_speed = current_speed
        self.accident_status = accident_status
class car:
    def __init__(self, Card_Balance, Fuel_quota, initial_fuel, gas_per_km):
        self.Card_Balance = Card_Balance
        self.Fuel_quota = Fuel_quota
        self.initial_fuel = initial_fuel
        self.gas_per_km = gas_per_km
        self.array = []
        
    def add_path(self ,src ,dest , current_speed , accident_status):
        self.array.append(PATH(src, dest, current_speed , accident_status))
#------------------------------------------------

def send_pathfile(raw_socket):

    raw_socket.recive_pkt(1024, 16)
    file = open("files/maps.txt","r")
    user_data = file.read()
    maps_array = parse_MAPS(user_data)
    raw_socket.send_pkt(user_data, [0,0,0,0,1,0,0,0,0])
    raw_socket.recive_pkt(1024, 16)
    return maps_array

class penalty_list:
    def __init__(self, penalty , descript):
        self.penalty = penalty
        self.descript = descript
    

def recive_state(raw_socket , maps_array):

    penalty = 0
    penalty_array = []
    
    state = raw_socket.recive_pkt(1024, 16)
    Card_Balance, Fuel_quota, initial_fuel, gas_per_km = state.split(',')
    C = car(Card_Balance, Fuel_quota, initial_fuel, gas_per_km)
    raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
    
    state = raw_socket.recive_pkt(1024, 16)
    while state != "end":
        arg1, current_speed , accident_status = state.split(',')
        src ,dest = arg1.split('-')
        C.add_path(src ,dest , current_speed , accident_status )
        #----check speed----
        for item in maps_array:
            if item.src == src and item.dest == dest and int(current_speed) > int(item.speed_allowed) :
                penalty += 100
                descript = "Unauthorized speed : in path {} to {} speed={} | speed allowed={}".format(
                    src , dest , current_speed , item.speed_allowed )
                penalty_array.append(penalty_list('100' , descript))
                break
        #----check accident----
        if int(accident_status) == 1 :
            penalty += 200
            descript = "Accused in the accident : in path {} to {} speed={} ".format(
                src , dest , current_speed )
            penalty_array.append(penalty_list('200' , descript))
            
        raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
        
        state = raw_socket.recive_pkt(1024, 16)
    
    user_data = "--->Vehicle Crash List :\n"
    total_penalty = 0
    for item in penalty_array:
        msg = "{}\t{}\n".format(item.penalty , item.descript)
        user_data += msg
        total_penalty += int(item.penalty)
    user_data += "------->total penalty = {}\n".format(total_penalty)
    print(user_data)
    raw_socket.send_pkt(user_data, [0,0,0,0,1,0,0,0,0])
    raw_socket.recive_pkt(1024, 16)
    return total_penalty

def send_penalty(raw_socket, total_penalty):

    raw_socket.send_pkt(str(total_penalty), [0,0,0,0,1,0,0,0,0])
    balance_report = raw_socket.recive_pkt(1024,16)
    raw_socket.send_pkt('', [0,0,0,0,1,0,0,0,0])
    print(balance_report)


def main():

    src_ip = '192.168.1.12'

    bank_ip = '192.168.1.14'
    bank_port = 44444
    
    driver_sock = raw_socket(55555, src_ip, 0, 0, "police" , "driver")
    bank_socket = raw_socket(22222, src_ip, bank_port, bank_ip, "police" , "bank")
    driver_sock.listen()
    driver_sock.accept()
    
    maps_array = send_pathfile(driver_sock)
    
    total_penalty = recive_state(driver_sock , maps_array)
    
    driver_sock.recive_FIN()

    bank_socket.connect()
    send_penalty(bank_socket, total_penalty)
    bank_socket.send_FIN()
    

if __name__ == '__main__':
    main()
