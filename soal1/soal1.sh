
#!bin/bash

#1a
syslog='syslog.log'

ERROR=$(grep 'ERROR' $syslog  | sed 's/^.*://')
INFO=$(grep 'INFO' $syslog | sed 's/^.*://')

#echo "$ERROR"
#echo "$INFO"

#1b
ERRORdetail=$(grep 'ERROR' $syslog  | sed 's/^.*R//' | sed 's/(.*//' | sort | uniq -c| sort -nr)

#echo "$ERRORdetail"

#1c

errorUser=$(grep  'ERROR'  $syslog | sed 's/^.*(//' | cut -d ")" -f1 | sort | uniq -c)

#echo "ERROR"
#echo "$errorUser"

infoUser=$(grep 'INFO' $syslog | sed 's/^.*(//' | cut -d ")" -f1 | sort | uniq -c)
#echo "INFO"
#echo "$infoUser"

#1d
echo "Error,Count" > error_message.csv
echo "$ERRORdetail" | while read list
do 
 error=$(echo $list | cut -d' ' -f2-)
 errorcount=$(echo $list | cut -d' ' -f 1)
 echo "$error,$errorcount" >> error_message.csv
done

#cat error_message.csv
