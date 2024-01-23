wall $'\t#Architecture:' `uname -a` \
     $'\n\t#CPU physical:' `lscpu | awk '/Socket/ {print $2}'` \
     $'\n\t#vCPU:' `nproc` \
     $'\n\t#Memory Usage:' `free -m | awk 'NR==2 {printf "%d/%dMB (%.2f%%)", $3,$2,$3*100/$2}'` \
     $'\n\t#Disk Usage:' `df --block-size=G --total | awk '/total/ {printf "%d/%dGb (%d%%)", $3,$2,$5}'` \
     $'\n\t#CPU load:' `mpstat | awk '/all/ {printf "%.1f%%", 100-$13}'` \
     $'\n\t#Last boot:' `last reboot -n1 --time-format iso | awk '/reboot/ {$0=$5;split($0,arr,"T");date=arr[1];split(arr[2],time,":");printf "%s %d:%d"\
,date, time[1], time[2]}'` \
     $'\n\t#LVM use:' `awk '/\/dev\/mapper/ {} END{if (NR > 0) printf "yes"; else printf "no"}' /etc/fstab` \
     $'\n\t#Connections TCP:' `sudo netstat -t | sed -n '/ESTABLISHED/p' | wc -l; printf " ESTABLISHED"` \
     $'\n\t#User log:' `users | awk '{print NF}'` \
     $'\n\t#Network:' `ip a | awk '/link\/ether/ {mac=$2};/inet.+enp0s3$/ {$0=$2;FS="/";$0=$0;printf "IP " $1 " (" mac ")\n"}'` \
     $'\n\t#Sudo:' `sudo cat /var/log/sudo/sudo.log | echo $(wc -l)/2 | bc` 'cmd'
