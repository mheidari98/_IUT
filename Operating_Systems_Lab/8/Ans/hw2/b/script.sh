#!/usr/bin/env bash

xterm -e ./server $1 $2 $3 &disown

sleep 2

for i in {1..($3)}; do
    xterm -e ./client $1 $2 &disown
done