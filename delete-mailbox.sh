#!/bin/bash
#list all user email in file account.txt
clear
echo "Retrieve Zimbra user account..."

USERS=`cat /tmp/account.txt`;

for ACCOUNT in $USERS; do
        NAME=`echo $ACCOUNT | awk -F@ '{print $1}'`;
                        echo -n "$ACCOUNT............................"
                        su - zimbra -c "/opt/zimbra/bin/zmmailbox -z -m $ACCOUNT emptyFolder /Inbox"
                                echo  "done"
done
echo "Sudah dihapus semua"