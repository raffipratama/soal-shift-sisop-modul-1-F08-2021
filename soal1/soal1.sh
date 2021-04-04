
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
echo "Name,Error_Count,Info_Count"
userDetail=$(grep -oP  '(?<=\().*(?=\))' $syslog | sort | uniq  )

for user in $userDetail
do
 ErrUser=$(grep -cP "ERROR.*($user)" $syslog)
 InfoUser=$(grep -cP "INFO.*($user)" $syslog)
 #echo "$user,$ErrUser,$InfoUser"
done

#1d
echo "Error,Count" > error_message.csv
echo "$ERRORdetail" | while read list
do 
 error=$(echo $list | cut -d' ' -f2-)
 errorcount=$(echo $list | cut -d' ' -f 1)
 echo "$error,$errorcount" >> error_message.csv
done

#cat error_message.csv

#1e

echo "Username,INFO,ERROR" > user_statistic.csv
echo "$userDetail" | while read userlist
do 
 countError=$(grep -cP "ERROR.*($userlist)" $syslog)
 countInfo=$(grep -cP "INFO.*($userlist)" $syslog)
 echo "$userlist,$countInfo,$countError" >> user_statistic.csv
done

#cat user_statistic.csv
