#!/bin/bash

client_num=$1
MAX_POINT=$2

xterm -e ./server $client_num $MAX_POINT &disown

sleep 3

for (( c=0; c<$1; c++))
do
    xterm -e ./client &disown
done