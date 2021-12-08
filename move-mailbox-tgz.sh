#!/bin/bash

for fn in `cat account.txt`; do
    	echo "the next file is $fn"
	eval "/opt/zimbra/bin/zmmailbox -z -m $fn -t 0 getRestURL "//?fmt=tgz" > /tmp/test/$fn.tgz "
done
