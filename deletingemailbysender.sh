#bin #bash

# BAIKNYA DI RND DULU !!!

for i in `su - zimbra -c 'zmprov -l gaa'`;
do
    for a in `cat list-sender.txt`; do
        echo " Mohon menunggu ... sedang mencari dan menghapus email spam pada Akun $i"
    for msg in `/opt/zimbra/bin/zmmailbox -z -m "$i" s -l 999 -t message "$a" | awk '{ if (NR!=1) {print}}' | grep mess | awk '{ print $2 }'`; do
        echo " Proses penghapusan email dengan no.id "$msg" pada Akun "$i" dari Akun Spammer $a BERHASIL"
        /opt/zimbra/bin/zmmailbox -z -m $i dm $msg
    done
    done
done
echo "  Selesai ... Mohon Diperiksa Kembali.";