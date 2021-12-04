#!/bin/bash

# Memastikan script harus dijalankan menggunakan user root
if [ "$(id -u)" != "0" ]; then
   echo "Script ini harus dijalankan menggunakan user root !!!" 1>&2
   exit 1
fi

#Memastikan package cfg2html sudah terinstall
if ! rpm -qa | grep cfg2html ; then
    echo "cfg2html belum terinstall, install cfg2html dahulu !!!" 1>&2
    exit 1
fi

#Memastikan package sosreport sudah terinstall
if ! rpm -qa | grep sos ; then
    echo "sosreport belum terinstall, install sosreport dahulu !!!" 1>&2
    exit 1
fi


Tanggal=`date | cut -d " " -f2,6 | tr -d '[[:space:]]'`
Hostname=`hostname`
Path=`pwd`/$Hostname-$Tanggal
mkdir -p `pwd`/$Hostname-$Tanggal
cfg2html
mv /var/log/cfg2html/* $Path
sosreport
mv /var/tmp/sosreport* $Path

read -p "Apakah Anda Ingin Menjalankan ZMDIAGLOG (y/n)?" CONT
if [ "$CONT" == "y" ]; then
  /opt/zimbra/libexec/zmdiaglog -a -j -z
fi
mv /opt/zimbra/data/tmp/zmdiaglog* $Path

echo "Collecting Crontab Root & Zimbra..........."
crontab -l > $Path/crontab-root.txt
su - zimbra -c 'crontab -l > /tmp/crontab-zimbra.txt'
mv /tmp/crontab-zimbra.txt $Path

echo "Collecting History Root & Zimbra..........."
history > $Path/history-root.txt
su - zimbra -c 'history > /tmp/history-zimbra.txt'
mv /tmp/history-zimbra.txt $Path

echo "Collecting Firewall / Iptables Configuration..........."
iptables -nL > $Path/iptables-nl.txt
iptables -t nat -nL > $Path/iptables-nat-nl.txt

echo "Collecting Update Package..........."
yum list updates > $Path/updatelist.txt

echo "Collecting Listening Service..........."
netstat -tulpn > $Path/netstat-tulpn.txt

echo "Check Version Zimbra..........."
su - zimbra -c 'zmcontrol -v' > /tmp/zimbra-version.txt
mv /tmp/zimbra-version.txt $Path

chmod -R 777 $Path
echo "=======================SELESAII======================="
