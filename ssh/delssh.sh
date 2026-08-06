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
read -p "Username SSH to Delete : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna
		clear
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
        echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
        echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	    echo ""
        echo -e "\033[0;32mผู้ใช้งาน $Pengguna ถูกลบแล้ว    \033[0m"
		echo ""
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
else
        clear
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
        echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
        echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	    echo ""
        echo -e "\033[0;33mผู้ใช้งาน $Pengguna ไม่มีในระบบ    \033[0m"
		echo ""
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
fi