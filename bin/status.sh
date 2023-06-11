sleep 5

rx_old=$(cat /sys/class/net/enp34s0/statistics/rx_bytes)
tx_old=$(cat /sys/class/net/enp34s0/statistics/tx_bytes)

void=#444b6a
black=#1e222a
green=#7eca9c
white=#abb2bf
grey=#282c34
blue=#7aa2f7
red=#d47d85
yellow=#e0af68
darkblue=#668ee3

while true 
do 
   case "$(ip addr | grep -o tun0 | tail -1)" in
     "") VPN="$(printf "^c$red^NO VPN")";;
     "tun0") VPN="$(printf "^c$green^VPN")";;
   esac
   case "$(xset -q|grep LED| awk '{ print $10 }')" in
     "00000000") KBD="EN" ;;
     "00001004") KBD="\x02HE" ;;
     *) KBD="unknown" ;;
   esac

   rx_now=$(cat /sys/class/net/enp34s0/statistics/rx_bytes)
   tx_now=$(cat /sys/class/net/enp34s0/statistics/tx_bytes)
   let rx_rate=($rx_now-$rx_old)/1024
   let tx_rate=($tx_now-$tx_old)/1024
   let temp=$(cat /sys/class/hwmon/hwmon1/temp1_input)/1000

   eval $(awk '/^cpu /{print "cpu_idle_now=" $5 "; cpu_total_now=" $2+$3+$4+$5 }' /proc/stat)
   cpu_interval=$((cpu_total_now-${cpu_total_old:-0}))
   let cpu_used="100 * ($cpu_interval - ($cpu_idle_now-${cpu_idle_old:-0})) / $cpu_interval"

   mem_used="$(free -m | head -2 | tail -1 | awk '{print $7}')"
   if [[ $(echo $mem_used " < 3000" | bc) -eq "1" ]]; then
      mem_used=$(printf "^c$black^ ^b$red^   $mem_used")
    else
      mem_used=$(printf "^c$void^   $mem_used")
   fi

   root_vol=$(df -h / | awk 'END {printf($5)}' | sed 's/Use%//') 
   files_vol=$(df -h /files | awk 'END {printf($5)}' | sed 's/Use%//') 
   if [[ $(echo ${root_vol//%} " > 80" | bc) -eq "1" ]]; then
      root_vol="$(echo "^c$black^^b$red^ 󰋊 ${root_vol}")"
   else
      root_vol="$(echo "^c$void^ 󰋊 ${root_vol}")"
   fi
   if [[ $(echo ${files_vol//%} " > 80" | bc) -eq "1" ]]; then
      files_vol="$(echo "^c$black^^b$red^  ${files_vol}")"
   else
      files_vol="$(echo "^c$void^ ${files_vol}")"
   fi

   vol="$(amixer -c 2 sget 'BEHRINGER UMC Output 1-2',1 | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
   if [[ $(echo $vol " > 80" | bc) -eq "1" ]]; then
      vol=$(echo "\x02"$vol)
   fi
   vol="^c$void^^b$black^  $vol%"

   if [[ $(echo $rx_rate " > 0" | bc) -eq "1" ]]; then
     rx_prate="$(printf "^c$yellow^󰛴 ${rx_rate}K")"
   else
     rx_prate="$(printf "^c$void^󰛴 ${rx_rate}K")"
   fi
   if [[ $(echo $tx_rate " > 0" | bc) -eq "1" ]]; then
     tx_prate="$(printf "^c$yellow^󰛶 ${tx_rate}K")"
   else
     tx_prate="$(printf "^c$void^󰛶 ${tx_rate}K")"
   fi

   if [[ $(echo $cpu_used " > 50" | bc) -eq "1" ]]; then
      cpu_pused="$(printf "^c$red^  %%${cpu_used}")"
   else
      cpu_pused="$(printf "^c$void^  %%${cpu_used}")"
   fi

   if [[ $(echo $temp " > 50" | bc) -eq "1" ]]; then
      temp="$(printf "^c$red^󰏈 ${temp}")"
   else
      temp="$(printf "^c$blue^󰏈 ${temp}")"
   fi

   updates="^c$void^ 󰚰"

   date="^c$black^ ^b$darkblue^ 󱑆 ^c$black^^b$blue^ $(date "+%a %d %b %H:%M")"
   taskbar_info=$(echo -e $updates $VPN "^b$grey^ " $rx_prate " " $tx_prate "^b$black^ " $cpu_pused$mem_used"Mb" " " $temp" "$root_vol" "$files_vol $vol "" $date "" $uptime "^c$void^^b$black^" $KBD " ") 
   xsetroot -name "$taskbar_info" 

   # reset old rates
   rx_old=$rx_now
   tx_old=$tx_now
   cpu_idle_old=$cpu_idle_now
   cpu_total_old=$cpu_total_now
   sleep 5
done
