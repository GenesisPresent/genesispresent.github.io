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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/thvpn/data-user-sstp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	    echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
        echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
        echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
		echo ""
		echo -e "\033[0;32mไม่มีข้อมูลในระบบ    \033[0m"
		echo ""
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
		exit 1
	fi

    echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
    echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
    echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	echo ""
	echo "     ลำดับ  วันหมดอายุ   ผู้ใช้งาน"
	grep -E "^### " "/var/lib/thvpn/data-user-sstp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
Client=$(grep -E "^###" /var/lib/thvpn/data-user-sstp | cut -d ' ' -f 2-3 | sed -n "$CLIENT_NUMBER"p)
user=$(grep -E "^###" /var/lib/thvpn/data-user-sstp | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p)
exp=$(grep -E "^###" /var/lib/thvpn/data-user-sstp | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p)
sed -i "/^### $user $exp/d" /var/lib/thvpn/data-user-sstp
sed -i '/^'"$user"'/d' /home/sstp/sstp_account
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo "Username  : $user"
echo "Expired   : $exp"
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"