#!/bin/bash
#list all user email in file account.txt

for fn in `cat /tmp/account.txt`; do
        echo "the next file is $fn"
        sudo su - zimbra -c  "/opt/zimbra/bin/zmmailbox -z -m $fn postRestURL '//?fmt=tgz&resolve=reset' /tmp/export-mailbox/$fn.tgz "

done