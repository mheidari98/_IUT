#!/bin/bash

fileFormat=$1
path=$2
textToSearch=$3
num=1
for i in $( grep -r $textToSearch $path --include $fileFormat -l ); do
	echo item $num: $i
	let num=num+1
done
