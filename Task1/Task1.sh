#!/bin/bash
hour=$(date +%I)
PM_OR_AM=$(date +%p)
if [ -d "Reports" ]
then
   echo "reports directory exists"
else
   echo "reports directory not found.creating one"
   mkdir Reports
fi
for I in {1..12};
do
  touch Reports/report-$(date +%Y-%m-%d).xls/$I
done
if [ -f  "report-$(date +%Y-%m-%d).tar" ]
then
   echo "you have backup"
else
   tar -cf report-$(date +%Y-%m-%d).tar
fi

if [ $hour -lt 5 ] || [ $hour -eq 12 ] && [ "$PM_OR_AM" == "AM" ]
then
   mkdir /Backup
   mv report-$(date +%Y-%m-%d).tar /Backup
   echo "Backup finished"
else
  echo "Backup Failed"
fi
