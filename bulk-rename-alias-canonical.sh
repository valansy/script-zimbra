#!/bin/bash

# Author: Imam Omar Mochtar (imam.omar@jabetto.com)
# Func: rename alias and canonical address 
# Date: Sel Okt 30 16:20:26 WIB 2018

DOMAIN="btpn.com"
ZM="/opt/zimbra/bin/zmprov"
TMP_ATTRS="/tmp/jbt_attr_list"
SRC=$1

touch $TMP_ATTRS

function getAttrs(){
	$ZM ga $1 > $TMP_ATTRS 2> /dev/null
	if [ ! -s $TMP_ATTRS ]; then
		return 1
	fi
	#cat $TMP_ATTRS | grep zimbraMailAlias | grep -v '#' | awk '{ print $2 }' | sed '/^\s*$/d' > $TMP_ALIAS_LIST
	return 0
}

function delAlias(){
	echo "deleting alias $2 for account $1"
	$ZM raa $1 $2
}

function addAlias(){
	echo "adding alias $2 for account $1"
	$ZM aaa $1 $2
}

function setCanon(){
	echo "Set canonical address $2"
	$ZM ma $1 zimbraMailCanonicalAddress $2
}

if [ "$SRC"x == "x" ]; then
	echo "need first argument as source file !!!"
	exit 1
fi

for line in `cat $SRC`; do
	akun=`echo $line | cut -d\; -f1`@$DOMAIN
	alias=`echo $line | cut -d\; -f2`@$DOMAIN
	bakalias=`echo $line | cut -d\; -f2`.bak@$DOMAIN
	getAttrs $akun
	# jika akunnya tidak ada maka di skip
	if [ $? -ne 0 ]; then
		echo -e "xxx Account $akun is not found\n"
		continue
	fi
	echo "== $akun"
	# cek apakah alias yang dimaksud ada ?
	grep -e "^zimbraMailAlias: $alias" $TMP_ATTRS > /dev/null && delAlias $akun $alias
	# cek apakah alias dengan nama bak sudah ada ?
	grep -e "^zimbraMailAlias: $bakalias" $TMP_ATTRS > /dev/null || addAlias $akun $bakalias
	grep -e "^zimbraMailCanonicalAddress: $bakalias" $TMP_ATTRS > /dev/null || setCanon $akun $bakalias

	echo -e "\n"
done

echo "----- DONE ----"
