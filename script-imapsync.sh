USERS=`cat /tmp/script/all_account.txt`

for x in $USERS;
	do imapsync --host1 202.152.1.66 --user1 $x --password1 'Denpasar123' --host2 199.97.25.200 --user2 $x  --authuser2 admin --password2 'W3y5kDR2' --regextrans2 's/Sent Items$/Sent/' --nofoldersizes --addheader  --regextrans2 "s/(.*)/MAILBOX-LAMA/"
	done
