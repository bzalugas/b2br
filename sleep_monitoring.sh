uptime -s | sleep $(awk '{$0=$2;FS=":";$0=$0; print ($2%10)*60}')
