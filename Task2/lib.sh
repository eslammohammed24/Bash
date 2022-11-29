#!/bin/bash

source ./Task2.sh

while [ ! -f ~/file.txt ]
do 
  sleep 2
  echo "File is not found"
done
  echo "File exist"