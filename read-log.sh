#!/bin/bash
echo "..:: [ Login bener dan sukses ] ::.."
grep -iE "sasl_method" /var/log/zimbra.log | sed -e "s/sasl_username=//g"| sed -e "s/client=//g"|awk '{print $9"\t\t"$7}'|column -t|sort -n | uniq -c
echo 
echo "__ [ Login salah ] __"
grep -iE "auth" /var/log/zimbra.log|grep -i "auth_zimbra"|grep -iE "fail"|awk '{print $7" "$8"_"$9}'|sort -n|uniq -c
echo
echo "Delay 10 detik"
sleep 10
echo "__ [ Login IMAP / POP3 ] __"
grep -iE "(imap|pop3)" /opt/zimbra/log/audit.log|sed -e "s/\[ip=/ip=/g"|awk '{split($5,a,";"); split($4,b,"-"); print $9"\t\t"b[1]"\t\t"a[2]"\t\t"$11}'|column -t|sort -n |uniq -c
echo
echo "Delay 10 detik"
sleep 10
echo "__ [ Login ActiveSync ] __"
grep -iE "\[qtp" /opt/zimbra/log/audit.log|grep -i "cmd=auth"|awk '{if ($9 ~ /cmd=Auth;/) { print $10"\t\t"$11"\t\t"$5"\t\t"$12 } else { split($5,a,";"); print $9"\t\t"$10"\t\t"a[2]} }'|column -t|sort -n|uniq -c|grep -ivE "( rv:| security| account=zimbra| T11b4)"

