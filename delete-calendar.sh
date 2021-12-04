#!/bin/bash
#list all user email in file account.txt
clear
echo "Retrieve Zimbra user account..."

USERS=`cat /tmp/script/account.txt`;

for ACCOUNT in $USERS; do
        NAME=`echo $ACCOUNT | awk -F@ '{print $1}'`;
                        echo -n "$ACCOUNT............................"
                        su - zimbra -c "/opt/zimbra/bin/zmmailbox -z -m $ACCOUNT emptyFolder /Calendar"
                                echo  "done"
done
echo "Sudah dihapus semua"