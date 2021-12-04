USERS=`cat /tmp/script/all_account.txt`
for x in $USERS;
	do zmmailbox -z -m $x -A createFolder /MAILBOX-LAMA; echo "membuat folder di account" $x
done
