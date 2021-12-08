#!/bin/bash

# Memastikan script harus dijalankan menggunakan user root
if [ "$(id -u)" != "0" ]; then
   echo "Script ini harus dijalankan menggunakan user root !!!" 1>&2
   exit 1
fi

#Memastikan package cfg2html sudah terinstall
if ! rpm -qa | grep cfg2html ; then
    echo "cfg2html belum terinstall, install cfg2html dahulu !!!" 1>&2

read -p "Apakah Anda Ingin install cfg2html (y/n)?" CONTa
if [ "$CONTa" == "y" ]; then
        wget https://www.cfg2html.com/cfg2html-6.30-1.git201607081048.noarch.rpm
        yum install psmisc -y
        rpm -Uvh cfg2html*rpm
fi
    exit 1
fi


Tanggal=`date | cut -d " " -f2,6 | tr -d '[[:space:]]'`
Hostname=`hostname`
PM='PM'
Path=`pwd`/$PM-$Hostname-$Tanggal
mkdir -p `pwd`/$PM-$Hostname-$Tanggal

cfg2html
mv /var/log/cfg2html/$Hostname* $Path
mv $Hostname* $Path

echo "Collecting History Root & Zimbra..........."
history > $Path/9.history-root.txt
su - zimbra -c 'history' > /tmp/9.history-zimbra.txt
mv /tmp/9.history-zimbra.txt $Path


echo "Collecting Crontab Root & Zimbra..........."
crontab -l > $Path/5.crontab-root.txt
su - zimbra -c 'crontab -l' > /tmp/5.crontab-zimbra.txt
mv /tmp/5.crontab-zimbra.txt $Path


echo "Collecting Firewall / Iptables Configuration..........."
iptables -nL > $Path/6.iptables-nl.txt
iptables -t nat -nL > $Path/6.iptables-nat-nl.txt

echo "Collecting Update Package..........."
yum list updates > $Path/7.updatelist.txt

echo "Check Version Zimbra..........."
su - zimbra -c 'zmcontrol -v' > /tmp/4.zimbra-version.txt
mv /tmp/4.zimbra-version.txt $Path

echo "Check Schedule Backup..........." #ini ngga command nya udah ngga ada
su - zimbra -c 'zmschedulebackup -s' > /tmp/8.zmschedulebackup-s.txt
mv /tmp/8.zmschedulebackup-s.txt $Path

su - zimbra -c 'zmschedulebackup -q' > /tmp/8.zmschedulebackup-q.txt
mv /tmp/8.zmschedulebackup-q.txt $Path

echo "Check DRBD..........."
cat /proc/drbd > $Path/11.drbd.txt

echo "Check Ldap Replication..........."
/opt/zimbra/libexec/zmreplchk > $Path/12.ldap-repl.txt

#echo "Check Quota mailbox..........."
#cp GetQuota.py /tmp/
#su - zimbra -c 'zmpython /tmp/GetQuota.py' > /tmp/13.GetQuota.csv
#mv /tmp/13.GetQuota.csv $Path

#echo "Check Quota getMbxSizeSortAsc..........."
#cp getMbxSizeSortAsc.py /tmp/
#su - zimbra -c 'zmpython /tmp/getMbxSizeSortAsc.py' > /tmp/13.getMbxSizeSortAsc.csv
#mv /tmp/13.getMbxSizeSortAsc.csv $Path

echo "-------> MONITORING CHECKING <-------"

echo "Check AKTIVITAS LOG OS..........."
cat /var/log/message > $Path/1..message.txt #ini ngga ada file nya
cat /var/log/messages > $Path/1..messages.txt 
cat /var/log/dmesg > $Path/1..dmesg.txt #ini ngga ada filenya
cat /var/log/zimbra.log > $Path/1..zimbra-log.txt
cat /var/log/maillog > $Path/1..maillog.txt


echo "Check AKTIVITAS LOG ZIMBRA..........."
cat /opt/zimbra/log/mailbox.log > $Path/2..mailbox-log.txt
cat /opt/zimbra/log/audit.log > $Path/2..audit-log.txt

echo "Check Zmqstat Queue..........."
/opt/zimbra/libexec/zmqstat > $Path/4..zmqstat-queue.txt


echo "-------> MANUAL CHECKING <-------"

echo "Check Space..........."
df -Th > $Path/1_df-th.txt

echo "Check RAM..........."
free -m > $Path/2_free-m.txt

echo "Check Uptime..........."
uptime > $Path/6_uptime.txt

echo "Collecting Listening Service..........."
netstat -tulpn > $Path/7_netstat-tulpn.txt

echo "Check rotasi log..........."
ls /opt/zimbra/log > $Path/8_opt-zimbra-log.txt
#cat /var/log/zimbra.log > $Path/8_zimbra-log.txt

echo "Check Status Zimbra..........."
su - zimbra -c 'zmcontrol status' > /tmp/12_zimbra-status.txt
mv /tmp/12_zimbra-status.txt $Path

echo "Check IP..........."
ifconfig > $Path/13_ifconfig.txt
route -n > $Path/13_route.txt
cat /etc/resolv.conf > $Path/13_resolv-conf.txt

echo "Check OS..........."
dmidecode -s system-product-name > $Path/14_OS-system.txt

echo "Check Mail Queues............"
su - zimbra -c 'mailq' > /tmp/4-zimbra-queue.txt
mv /tmp/4-zimbra-queue.txt $Path

echo "Check Config Local............"
su - zimbra -c 'zmlocalconfig -s' > /tmp/15_zimbra-config.txt
mv /tmp/15_zimbra-config.txt $Path

echo "Check Get Server............"
su - zimbra -c 'zmprov gs `zmhostname`' > /tmp/16_zimbra-get-server.txt
mv /tmp/16_zimbra-get-server.txt $Path

echo "Check Get All Config............"
su - zimbra -c 'zmprov gacf' > /tmp/17_zimbra-get-all-config.txt
mv /tmp/17_zimbra-get-all-config.txt $Path

mkdir $Path/2.cfg2html
mv $Path/$Hostname* $Path/2.cfg2html

mkdir $Path/COL
mkdir $Path/MON
mkdir $Path/MAN
mkdir $Path/SEC

mv $Path/1_* $Path/MAN
mv $Path/2_* $Path/MAN
mv $Path/3_* $Path/MAN
mv $Path/4_* $Path/MAN
mv $Path/5_* $Path/MAN
mv $Path/6_* $Path/MAN
mv $Path/7_* $Path/MAN
mv $Path/8_* $Path/MAN
mv $Path/9_* $Path/MAN
mv $Path/10_* $Path/MAN
mv $Path/11_* $Path/MAN
mv $Path/12_* $Path/MAN
mv $Path/12_* $Path/MAN
mv $Path/13_* $Path/MAN
mv $Path/14_* $Path/MAN
mv $Path/15_* $Path/MAN
mv $Path/16_* $Path/MAN
mv $Path/17_* $Path/MAN


mv $Path/1..* $Path/MON
mv $Path/2..* $Path/MON
mv $Path/3..* $Path/MON
mv $Path/4..* $Path/MON


mv $Path/1.* $Path/COL
mv $Path/2.* $Path/COL
mv $Path/3.* $Path/COL
mv $Path/4.* $Path/COL
mv $Path/5.* $Path/COL
mv $Path/6.* $Path/COL
mv $Path/7.* $Path/COL
mv $Path/8.* $Path/COL
mv $Path/9.* $Path/COL
mv $Path/10.* $Path/COL
mv $Path/11.* $Path/COL
mv $Path/12.* $Path/COL
mv $Path/13.* $Path/COL
mv $Path/14.* $Path/COL

mv $Path/4-* $Path/SEC


chmod -R 777 $Path

#tar -czvf $Path.tar $Path

echo "=======================SELESAI======================="
