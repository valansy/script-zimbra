/opt/zimbra/postfix/sbin/postqueue -p | egrep -v '^ *\(|-Queue ID-' \
| awk 'BEGIN { RS = "" } { if ($7 == "et6170012@hip.co.id") print $1} '| tr -d '*!' | /opt/zimbra/postfix/sbin/postsuper -d - 

