#!/bin/bash

#
# sed on path -> SON
#

#Przykład podania parametrów
#/root/testing/ neos 192.168.0.10 192.168.0.20

project=$1
neos_or_teneum=$2
before=$3
after=$4
mkdir -p "$project"backup/"$neos_or_teneum"/

cd $project

for dir in *
do
    if [[ $dir == "backup" ]]
    then
        continue
    else
        if [[ $neos_or_teneum == "neos" ]]
        then
            cd $project/$dir/$neos_or_teneum/
            cp *.smd "$project"backup/"$neos_or_teneum"/
            sed -i "s/$before/$after/g" *.smd 
        elif [[ $neos_or_teneum == "teneum_client" ]]
        then
            cd $project/$dir/$neos_or_teneum/
            cp *.app "$project"backup/"$neos_or_teneum"/
            sed -i "s/$before/$after/g" *.app
        else
            echo "lipa"
        fi
    fi
done