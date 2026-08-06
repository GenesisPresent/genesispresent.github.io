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
source /var/lib/thvpn/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
IP=$(wget -qO- ipinfo.io/ip);
sstp="$(cat ~/log-install.txt | grep -i SSTP | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Usernew : " -e user
		CLIENT_EXISTS=$(grep -w $user /var/lib/thvpn/data-user-sstp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
		    clear
	    	echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
            echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
            echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
			echo ""
			echo -e "ผู้ใช้งาน ${RED}${user}${NC} มีในระบบแล้ว    "
			echo ""
            echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
			exit 1
		fi
	done
read -p "Password : " pass
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat >> /home/sstp/sstp_account <<EOF
$user * $pass *
EOF
echo -e "### $user $exp">>"/var/lib/thvpn/data-user-sstp"
clear
cat <<EOF
============================
SSTP VPN
============================
IP/Host   : $IP
Domain    : $domain
Username  : $user
Password  : $pass
Port      : $sstp
Cert      : http://$IP:89/server.crt
Created   : $hariini
Expired   : $exp
============================
EOF