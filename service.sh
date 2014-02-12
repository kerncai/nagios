#!/bin/bash

HOSTNAME=$1
SERVICEOUTPUT=$2
HOSTADDRESS=$3
CONTACTEMAIL=$4
HOSTALIAS=$5
SERVICEDESC=$6
SERVICESTATE=$7
#EMAIL=`mysql -uchangedb -p2012zeusops -h10.10.8.35 ops_db -e"select a.label,b.email from item a ,user b where a.owner_id=b.id and label ='$HOSTNAME'"|grep -v "label"|awk '{print$2}'`
EMAIL=`mysql -uchangedb -p2012zeusops -h10.10.8.35 ops_db -e"select '$HOSTNAME',email from user where id = (select user_id from item where label = '$HOSTNAME') union select '$HOSTNAME',email from user where id = (select owner_id from item where label = '$HOSTNAME')"|grep -vE 'label|email' |awk '{print$2 }'`

#OWNER=`mysql -uchangedb -p2012zeusops -h10.10.8.35 ops_db -e"select a.label,b.user_name from item a ,user b where a.owner_id=b.id and label ='$HOSTNAME'"|grep -v "label"|awk '{print$2}'`

#USER=`mysql -uchangedb -p2012zeusops -h10.10.8.35 ops_db -e"select a.label,b.chinese_name from item a ,user b where a.user_id=b.id and label ='$HOSTNAME'"|grep -v "label"|awk '{print$2}'`


#echo mysql -uchangedb -p2012zeusops -h10.10.8.35 ops_db -e"select a.label,b.email from item a ,user b where a.owner_id=b.id and label ='$HOSTNAME'" >>/tmp/myhostname
#echo $EMAIL >> /tmp/myhostname

#/usr/bin/printf "%b" "Address: $HOSTADDRESS\nStatus:\n\n$SERVICEOUTPUT\npost time `date|awk '{print $4}'`" | /usr/bin/sendEmail -f IDC10@IDC10-003.i.ajkdns.com -t $EMAIL -cc $CONTACTEMAIL -s mail.rt.i.ajkdns.com -u "IDC10 Service: $HOSTALIAS/$SERVICEDESC is $SERVICESTATE"
/usr/bin/sendEmail -o message-header=GB2312 -f ops_server@mon10-003.i.ajkdns.com -t $EMAIL -cc $CONTACTEMAIL -s mail.rt.i.ajkdns.com -u "IDC10:$HOSTALIAS/$SERVICEDESC is $SERVICESTATE" -m "Address:$HOSTADDRESS\nStatus:\n$SERVICEOUTPUT\nOwner:$OWNER\nUser:$USER\npost time `date|awk '{print $4}'`"
#/usr/bin/printf "Address:$HOSTADDRESS\nStatus:\n$SERVICEOUTPUT\npost time `date|awk '{print $4}'`" | /usr/bin/sendEmail -f IDC10@IDC10-003.i.ajkdns.com -t $EMAIL -cc $CONTACTEMAIL -s mail.rt.i.ajkdns.com -u "IDC10:$HOSTALIAS/$SERVICEDESC is $SERVICESTATE"

