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
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d");
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# BEGIN_Backup" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
function start() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo -e "\033[0;31mใส่อีเมลของคุณ...    \033[0m"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
fi
cat << EOF >> /etc/crontab
# BEGIN_Backup
5 0 * * * root backup
# END_Backup
EOF
service cron restart
sleep 1
echo -e "\033[0;33mกรุณารอสักครู่...    \033[0m"
clear
echo -e "\033[0;32mสํารองข้อมูลอัตโนมัติแล้ว    \033[0m"
echo -e "\033[0;32mระบบจะสำรองข้อมูลทุกๆเทียงคืนโดยจะใช้เวลา 5 นาทีอย่างน้อย    \033[0m"
echo -e "\033[0;31mการสำรองข้อมูลอาจเสียหายได้หากระบบเกิดล้มกระทันหัน...    \033[0m"
exit 0
}
function stop() {
email=$(cat /home/email)
sed -i "/^$email/d" /home/email
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo -e "\033[0;33mกรุณารอสักครู่...    \033[0m"
clear
echo -e "\033[0;32mสํารองข้อมูลอัตโนมัติ    \033[0m"
echo -e "\033[0;32mได้ถูกปิดใช้งานแล้วตอนนี้    \033[0m"
exit 0
}

function gantipenerima() {
rm -rf /home/email
echo -e "\033[0;31mใส่อีเมลของคุณ...    \033[0m"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
}
function gantipengirim() {
echo -e "\033[0;31mใส่อีเมลของคุณ...    \033[0m"
read -rp "Email : " -e email
echo -e "\033[0;31mใส่รหัสผ่านอีเมลของคุณ...    \033[0m"
read -rp "Password : " -e pwdd
rm -rf /etc/msmtprc
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user $email
from $email
password $pwdd
logfile ~/.msmtp.log
EOF
}
function testemail() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
start
fi
email=$(cat /home/email)
echo -e "
อีเมลทดสอบครับ...
ไอพีเซิร์ฟเวอร์ : $IP
วันที่ : $date
[สคริปต์ TH-VPN]
[https://th-vpn.in.net]
" | mail -s "Email" $email
}
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "Status : $sts"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mStart Autobackup"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mStop Autobackup"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mเปลี่ยนอีเมลผู้รับ    "
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mเปลี่ยนอีเมลของผู้ส่ง   "
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mทดสอบส่งอีเมล    "
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;32mSelect Menu \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
1 | 01)
start
;;
2 | 02)
stop
;;
3 | 03)
gantipenerima
;;
4 | 04)
gantipengirim
;;
5 | 05)
testemail
;;
*)
echo -e "\n\033[1;31mไม่พบเมนู !\033[0m"
sleep 1
clear
menu
;;
esac
