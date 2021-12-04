#!/bin/bash
#list all user email in file account.txt

for fn in `cat /home/migrasi/account.txt`; do
        echo "the next file is $fn"
        eval "/opt/zimbra/bin/zmmailbox -z -m $fn -t 0 getRestURL "//?fmt=tgz" > /home/migrasi/export-mailbox/$fn.tgz "
done