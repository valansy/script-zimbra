FROM="zmmbox.jict.co.id"
TO="zmmbox2.jict.co.id"

for user in `zmprov -l gaa | grep -v "^\(admin@\|wiki@\|spam.*@\|ham.*@\|virus.*@\)"`;do
        echo "memindahkan $user" >> /tmp/movemailbox.log
        zmmboxmove -a $user -f $FROM -t $TO --sync >> /dev/null 2>&1
        echo "Menghapus yang lama $user" >> /tmp/movemailbox.log
        zmpurgeoldmbox -a $user -s $FROM >> /tmp/movemailbox.log
done

