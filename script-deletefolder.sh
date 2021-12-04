USERS=`cat /tmp/script/all_account.txt`
for x in $USERS;
	do zmmailbox -z -m $x -A deleteFolder /MAILBOX-LAMA; echo "menghapus folder di dalam account" $x
done
