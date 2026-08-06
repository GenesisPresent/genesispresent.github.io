#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'

	if [[ "$VERSION_ID" != 'VERSION_ID="9"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="10"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="18.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="20.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="24.04"' ]] ; then
		clear
    	echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
		echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
		echo -e "\033[0m"
		echo -e "\033[0;37mเวอร์ชัน OS ของคุณเป็นเวอร์ชันที่ยังไม่รองรับ    "
		echo -e "\033[0;37mสำหรับเวอร์ชันที่รองรับได้ จะมีดังนี้..."
		echo -e "\033[0m"
		echo -e "\033[0;37mUbuntu 18.04 - 20.04    "
		echo -e "\033[0;37mDebian 9 - 10    "
		echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
		echo -e "\033[0m"
		exit
	fi
else
	clear
    echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
	echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	echo -e "\033[0m"
	echo -e "\033[0;37mเวอร์ชัน OS ของคุณเป็นเวอร์ชันที่ยังไม่รองรับ    "
	echo -e "\033[0;37mสำหรับเวอร์ชันที่รองรับได้ จะมีดังนี้..."
	echo -e "\033[0m"
	echo -e "\033[0;37mUbuntu 18.04 - 20.04    "
	echo -e "\033[0;37mDebian 9 - 10    "
	echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
	echo -e "\033[0m"
	exit
	fi
	
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
read -p "Key : " passwds
echo -e "\033[0;37m✅ กำลังตรวจสอบ Key ในระบบสักครู่....        "
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
sleep 6
wget -q -O /usr/bin/key-thvpn https://genesispresent.github.io/key.txt
if ! grep -w -q $passwds /usr/bin/key-thvpn; then
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[0;37mKey : 🚨ของคุณไม่ถูกต้อง หรือ หมดอายุการใช้งานแล้ว        "
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"

HOSTNAME=$(hostname)
DATE=`date '+%d-%m-%Y %H:%M:%Sน.'`
IP01=$(wget -qO- ipv4.icanhazip.com)
CY01=$(wget -qO- ipinfo.io/country)

TOKEN="8198293903:AAH8RUcPjLb26VVxYNUPk7T7-8qT9IXT4Bk" 
ID="6814506999"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$ID -d text="ติดตั้งสคริปต์ 🔑(พรีเมี่ยม)🔑
🖥️ ติดตั้งด้วยชื่อ : $USER
💽 โฮสต์เซิร์ฟเวอร์ : $HOSTNAME
🔐 สคริปต์ถูกรันโดย :  http://$IP01:81 ($CY01)
📆 วันที่ : $DATE
🔑 คีย์ที่ติดตั้ง : $passwds
🚨เตือนคีย์ไม่ถูกต้อง!" > /dev/null

rm -rf /usr/bin/key-thvpn
rm -rf setup.sh*
exit
	
fi

if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
	group_name="nogroup"
elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
	group_name="nogroup"
else
	echo "ไม่รองรับในการติดตั้ง OS ปัจจุบันนี้....   "
	exit
fi

echo -e "Asia/Bangkok" >/etc/timezone
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime >/dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata >/dev/null 2>&1

[[ ! -d /etc/TH-VPN ]] && mkdir /etc/TH-VPN
echo -e 'by: @TH-VPN' >/usr/lib/TH-VPN 
cat /usr/lib/TH-VPN >/usr/lib/licence

# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Link Hosting Kalian Untuk Ssh Vpn
akbarvpn="genesispresent.github.io/ssh"
# Link Hosting Kalian Untuk Sstp
akbarvpnn="genesispresent.github.io/sstp"
# Link Hosting Kalian Untuk Ssr
akbarvpnnn="genesispresent.github.io/ssr"
# Link Hosting Kalian Untuk Shadowsocks
akbarvpnnnn="genesispresent.github.io/shadowsocks"
# Link Hosting Kalian Untuk Wireguard
akbarvpnnnnn="genesispresent.github.io/wireguard"
# Link Hosting Kalian Untuk Xray
akbarvpnnnnnn="genesispresent.github.io/xray"
# Link Hosting Kalian Untuk Ipsec
akbarvpnnnnnnn="genesispresent.github.io/ipsec"
# Link Hosting Kalian Untuk Backup
akbarvpnnnnnnnn="genesispresent.github.io/backup"
# Link Hosting Kalian Untuk Websocket
akbarvpnnnnnnnnn="genesispresent.github.io/websocket"
# Link Hosting Kalian Untuk Ohp
akbarvpnnnnnnnnnn="genesispresent.github.io/ohp"

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[0m"
echo -e "\033[0;32mกำลังตรวจสอบสคริปต์...    "
echo -e "\033[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
IZIN=$(wget -qO- ipinfo.io/ip);

rm -f setup.sh
clear
#if [ -f "/etc/xray/domain" ]; then
#echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
#echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
#echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
#echo -e "\033[0m"
#echo -e "\033[0;33mสคริปต์นี้ถูกติดตั้งไว้แล้วไม่สามารถติดตั้งซ้ำได้ครับ    "
#echo -e "\033[0m"
#echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
#exit 0
#fi
mkdir /var/lib/thvpn;
echo "IP=" >> /var/lib/thvpn/ipvps.conf
wget https://${akbarvpn}/cf.sh && chmod +x cf.sh && ./cf.sh
#install v2ray
wget https://${akbarvpnnnnnn}/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
#install ssh ovpn
wget https://${akbarvpn}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
wget https://${akbarvpnn}/sstp.sh && chmod +x sstp.sh && screen -S sstp ./sstp.sh
#install ssr
wget https://${akbarvpnnn}/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
wget https://${akbarvpnnnn}/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
#installwg
wget https://${akbarvpnnnnn}/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
#install L2TP
wget https://${akbarvpnnnnnnn}/ipsec.sh && chmod +x ipsec.sh && screen -S ipsec ./ipsec.sh
wget https://${akbarvpnnnnnnnn}/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Websocket
wget https://${akbarvpnnnnnnnnn}/edu.sh && chmod +x edu.sh && ./edu.sh
# Ohp Server
wget https://${akbarvpnnnnnnnnnn}/ohp.sh && chmod +x ohp.sh && ./ohp.sh

rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-xray.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://th-vpn.in.net

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://${akbarvpn}/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver

HOSTNAME=$(hostname)
DATE=`date '+%d-%m-%Y %H:%M:%Sน.'`
IP01=$(wget -qO- ipv4.icanhazip.com)
CY01=$(wget -qO- ipinfo.io/country)

TOKEN="8198293903:AAH8RUcPjLb26VVxYNUPk7T7-8qT9IXT4Bk" 
ID="6814506999"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$ID -d text="ติดตั้งสคริปต์ 🔑(พรีเมี่ยม)🔑
🖥️ ติดตั้งด้วยชื่อ : $USER
💽 โฮสต์เซิร์ฟเวอร์ : $HOSTNAME
🔐 สคริปต์ถูกรันโดย :  http://$IP01:81 ($CY01)
📆 วันที่ : $DATE
🔑 คีย์ที่ติดตั้ง : $passwds" > /dev/null

echo "============================================================================" | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2083"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Tr Go                   : 2087"  | tee -a log-install.txt
echo "============================================================================" | tee -a log-install.txt
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;33m             • \033[1;32mการติดตั้งเสร็จสมบูรณ์ \033[1;33m• \033[0m"
echo -e "\033[1;33m เปิดเมนูคำสั่ง: \033[1;32mmenu   \033[0m"
echo -e "\033[1;33m มีปัญหาอื่นๆ\033[1;31m(ติดต่อ\033[1;31m)\033[1;33m: \033[1;32mปัณณวิชญ์ นารีเดช   \033[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
rm -f $HOME/setup.sh* && cat /dev/null > ~/.bash_history && history -c
