#!/bin/bash
#list all user email in file account.txt

clear
echo "Retrieve Zimbra user account..."

USERS=`cat /tmp/account-sync.txt`;

for ACCOUNT in $USERS; do
        NAME=`echo $ACCOUNT | awk -F@ '{print $1}'`;
                        echo -n "$ACCOUNT............................"
                        eval "imapsync --host1 10.100.10.10 --user1 $ACCOUNT --authuser1 admin --password1 s@tkocomindoSUKSES2019 --authmech1 PLAIN --host2 10.100.10.13 --user2 $ACCOUNT --authuser2 admin --password2 s@tkocomindoSUKSES2019 --nofoldersizes --addheader"
                                echo  "done"
done
echo "Sudah syncronize semua"