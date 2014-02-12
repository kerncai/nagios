#!/bin/bash

HOSTNAME=$1
HOSTSTATE=$2
NOTIFICATIONTYPE=$3 
CONTACTEMAIL=$4
HOSTADDRESS=$5
HOSTOUTPUT=$6

EMAIL=`mysql -uroot -p2012 -h10.10.8.35 ops_db -e "select '$HOSTNAME',email from user where id = (select user_id from item where label = '$HOSTNAME') union select '$HOSTNAME',email from user where id = (select owner_id from item where label = '$HOSTNAME')"|grep -vE 'label|email' |awk '{print$2 }'`

#/usr/bin/printf "%b" "$HOSTADDRESS\nInfo: $HOSTOUTPUT\npost time `date |awk '{print$4}'`" | /usr/bin/sendEmail -f IDC10@mon10-003.i.ajkdns.com -t $EMAIL -cc $CONTACTEMAIL -s mail.rt.i.ajkdns.com -u "$NOTIFICATIONTYPE Host Alert: $HOSTNAME is $HOSTSTATE"
/usr/bin/printf "$HOSTADDRESS\nInfo:$HOSTOUTPUT\npost time `date |awk '{print$4}'`" | /usr/bin/sendEmail -f idc10@mon10-003.i.ajkdns.com -t $EMAIL -cc $CONTACTEMAIL -s mail.rt.i.ajkdns.com -u "$NOTIFICATIONTYPE $HOSTNAME is $HOSTSTATE"
