#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mChange Port OpenVPN"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mChange Port Wireguard"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mChange Port Vmess + Vless"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mChange Port Trojan"
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mChange Port Squid"
echo -e "\033[1;31m[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mChange Port SSTP"
echo -e "\033[1;31m[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mChange Port SSH WS NON TLS"
echo -e "\033[1;31m[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mChange Port SSH WS TLS / SSL"
echo -e "\033[1;31m[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;32mย้อนกลับ? \033[1;32m<\033[1;33m<\033[1;31m< "
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;32mSelect Menu \033[1;33m?\033[1;31m?\033[1;37m : "; read x
echo -e ""
case "$x" in
1 | 01)
portovpn
;;
2 | 02)
portwg
;;
3 | 03)
portvlm
;;
4 | 04)
porttrojan
;;
5 | 05)
portsquid
;;
6 | 06)
portsstp
;;
7 | 07)
portsshnontls
;;
8 | 08)
portsshws
;;
9 | 09)
menu
;;
*)
echo -e "\n\033[1;31mไม่พบเมนู !\033[0m"
sleep 1
clear
changeport
;;
esac
