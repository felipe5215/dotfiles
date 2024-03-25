xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
xset r rate 250 35  # set keyboard repeat rate


dte(){
    date_output=$(date +"%A,%d/%m %I:%M")
    echo $date_output
}


mem(){
    mem=`free | awk '/Mem/ {printf "%d/%d\n", $3 / 1024.0, $2 / 1024.0 }'`
    echo "$mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "$cpu% "
}

while true; do
     xsetroot -name "$(cpu) $(mem) $(dte)"
     sleep 10s    # Update time every ten seconds
done &


exec dwm
