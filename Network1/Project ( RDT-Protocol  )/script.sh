
#!/usr/bin/env bash

./script_ip.sh wlp3s0


konsole --noclose -e sudo python Police.py --profile "police" &disown
sleep 2
konsole --noclose -e sudo python Bank.py --profile "bank" &disown
sleep 2
konsole --noclose -e sudo python Insurance.py --profile "insurance" &disown
sleep 2
konsole --noclose -e sudo python Gas_Station.py --profile "insurance" &disown

sleep 2
konsole --noclose -e sudo python Driver.py --profile "driver" &disown

# for i in {1..($3)}; do
#     xterm -e ./client $1 $2 &disown
# done
