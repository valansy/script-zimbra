#!/bin/sh

#Screen screen
clear

LOCATION=`pwd`
LIST_DOMAIN="domain.txt"
ZMZCONF="/opt/zimbra/conf/zmztozmig.conf"

cat $LOCATION/$LIST_DOMAIN | while read DOMAIN; do
     echo " Replace domain file $ZMZCONF dan dirubah menjadi domain $DOMAIN"
     sed -i s/Domains=.*/Domains=$DOMAIN/g $ZMZCONF
     echo "Mulai Copy Data Mailbox"
     su - zimbra -c "/opt/zimbra/libexec/zmztozmig"

echo "Copy data Mailbox untuk Domain $DOMAIN sudah selesai"
done
