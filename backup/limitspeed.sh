#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
MYIP=$(wget -qO- ipinfo.io/ip);
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/limit)
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
function start () {
echo -e "\033[0;33mตั้งค่าความเร็วอินเทอร์เน็ต    \033[0m"
read -p "Set maximum download rate (in Kbps): " down
read -p "Set maximum upload rate (in Kbps): " up
if [[ -z "$down" ]] && [[ -z "$up" ]]; then
echo > /dev/null 2>&1
else
echo -e "\033[0;32mเปิดใช้งานการตั้งค่าแล้ว    \033[0m"
sleep 0.5
wondershaper -a $NIC -d $down -u $up > /dev/null 2>&1
systemctl enable --now wondershaper.service
echo "start" > /home/limit
fi
}
function stop () {
wondershaper -ca $NIC
systemctl stop wondershaper.service
echo -e "\033[0;31mปิดใช้งานการตั้งค่าแล้ว    \033[0m"
sleep 0.5
echo > /home/limit
}
if [[ "$cek" = "start" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "Status : $sts"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mStart Limit"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mStop Limit"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;32mSelect Menu \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
1 | 01)
start
;;
2 | 02)
stop
;;
*)
echo -e "\n\033[1;31mไม่พบเมนู !\033[0m"
sleep 1
clear
menu
;;
esac

