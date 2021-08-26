# mahdi heidari ( 9626903 )
#!/bin/bash

if [ $1 == "-r" ]
then
    cat $2;
elif [ $1 == "-m" ]
then
    for i in `seq $5 $6`; do
        touch $2$3$i"."$4
    done
fi
