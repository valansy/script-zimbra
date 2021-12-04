WUSER=$1
TMPFILE='/tmp/tempcheck_user.txt'

/opt/zimbra/bin/zmprov -l gaa > $TMPFILE

for user in `cat $WUSER`;do
	grep $user $TMPFILE && echo "$user still exists" 
done
