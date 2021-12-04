#!/bin/bash
echo "Masukkan Domain : "
read domain
echo "Masukkan Email Distribution List : "
read distlist
echo "Masukkan New Password : "
read password
echo ""
echo ""
echo "PROSES MERUBAH PASSWORD DIMULAI"

for i in `zmprov gdlm $distlist |grep -v '#' |grep $domain`; 
do 
	zmprov sp $i $password
	echo "Merubah Password $i"
done



