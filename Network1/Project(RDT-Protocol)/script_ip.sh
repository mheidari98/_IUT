#!/bin/bash
sudo ifconfig $1:1 192.168.1.10 netmask 255.255.255.0 up
sudo ifconfig $1:2 192.168.1.11 netmask 255.255.255.0 up
sudo ifconfig $1:3 192.168.1.12 netmask 255.255.255.0 up
sudo ifconfig $1:4 192.168.1.13 netmask 255.255.255.0 up
sudo ifconfig $1:5 192.168.1.14 netmask 255.255.255.0 up