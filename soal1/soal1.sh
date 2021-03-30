#!/bin/bash

#1.a)
errorinfo=$(grep -o "[INFO|ERROR].*" syslog.log)
#echo "$errorinfo"

#1.b) 
errorcount=$(grep -o "ERROR.*" syslog.log |sort -nr | cut -d "(" -f1 | uniq -c)
#uniq -c [count]
echo "$errorcount"

#1.c)
#Cara yg akan sama digunakan dengan 1.e
uinforegex=$(grep "INFO.*" syslog.log | cut -d "(" -f2 | cut -d ")" -f1| sort -nr | uniq -c)
uerroregex=$(grep "ERROR.*" syslog.log | cut -d "(" -f2 | cut -d ")" -f1 | sort -nr | uniq -c)
#echo "Ini untuk info"
#echo "$uinforegex"
#echo "Ini untuk Error"
#echo "$uerroregex"

#1.d)
grep -o "ERROR.*" syslog.log | sed 's/\<ERROR\>//g' | cut -d "(" -f1 | sort | uniq -c |
while read count msg
do
        echo $msg,$count
done | sort -nr -t, -k2 | sed '1i\Error,Count' > error_message.csv

#1.e)
echo "Username,INFO,ERROR" > user_statistic.csv

cut -d "(" -f2 syslog.log | cut -d ")" -f1 | sort -t , -k1 | uniq |
while read line;
do
        info=$(grep "INFO.*($line)" syslog.log | wc -l)
        error=$(grep "ERROR.*($line)" syslog.log | wc -l)
        echo -e "$line,$info,$error"
done >> user_statistic.csv
