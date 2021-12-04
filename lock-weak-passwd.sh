#!/bin/bash

ZMPROV="/opt/zimbra/bin/zmprov"
SCRIPT="`pwd`/scan_passwd.py"
LIST_WEAK_CMD="/opt/zimbra/bin/zmpython $SCRIPT dc=tnial,dc=mil,dc=id"

for email in `$LIST_WEAK_CMD`; do
	echo "Lock akun $email"
	$ZMPROV ma $email zimbraAccountStatus locked
done
