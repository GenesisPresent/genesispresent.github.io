#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/licence) == "@TH-VPN" ]] && {
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"

if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
	group_name="nogroup"
elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
	group_name="nogroup"
fi
if [[ "$os" == "ubuntu" ]]; then
system="Ubuntu"
fi
if [[ "$os" == "debian" ]]; then
system="Debian"
fi

_system=$(printf '%-13s' "$system")
_hoje=$(date +'%d/%m/%Y')
_hora=$(printf '%(%H:%M:%S)T')
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
mb=$(printf '%-8s' "$(free -h | grep Mem | sed 's/\s\+/,/g' | cut -d , -f6)")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
_CY=$(wget -qO- ipinfo.io/country)
_IP=$(wget -qO- ipinfo.io/ip)

echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\E[44;1;37m             ⇱ TH-VPN PREMIUM SCRIPT ⇲              \E[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;31m[\033[1;32mระบบปฏิบัติการ\033[1;31m]      \033[1;31m[\033[1;32mหน่วยความจำแรม\033[1;31m]  \033[1;31m[\033[1;32mหน่วยประมวลผล\033[1;31m] \033[0m"
echo -e "\033[1;31mรุ่น\033[1;31m: \033[1;37m$_system   \033[1;31mแรม\033[1;31m:\033[1;37m$_ram   \033[1;31mแกน\033[1;31m:\033[1;37m $_core "
echo -e "\033[1;31mเดือน\033[1;31m: \033[1;37m$_hoje  \033[1;31m  แคช\033[1;31m: \033[1;37m$mb  \033[1;31m  เวอร์ชัน\033[1;31m:\033[1;37m $(uname -m)"
echo -e "\033[1;31mเวลา\033[1;31m: \033[1;37m$_hora    \033[1;31m  ภาพรวม\033[1;31m: \033[1;37m$_usor\033[1;31m การใช้งาน\033[1;31m: \033[1;37m$_usop"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;31m[\033[1;32m TH-VPN \033[1;31m] IP: \033[1;37m$_IP \033[1;33m$_CY \033[1;31mID: \033[1;37m$USER \033[1;31m[\033[1;37mv 1.0.0\033[1;31m]\033[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mจัดการ SSH & OpenVPN   "
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mจัดการ L2TP   "
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mจัดการ PPTP   "
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mจัดการ SSTP   "
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mจัดการ WIREGUARD   "
echo -e "\033[1;31m[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mจัดการ SHADOWSOCKS   "
echo -e "\033[1;31m[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mจัดการ SHADOWSOCKSR   "
echo -e "\033[1;31m[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mจัดการ VMESS   "
echo -e "\033[1;31m[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mจัดการ VLESS   "
echo -e "\033[1;31m[\033[1;36m10\033[1;31m] \033[1;37m• \033[1;33mจัดการ TROJAN GFW   "
echo -e "\033[1;31m[\033[1;36m11\033[1;31m] \033[1;37m• \033[1;33mจัดการ TROJAN GO   "
echo -e "\033[1;31m[\033[1;36m12\033[1;31m] \033[1;37m• \033[1;32mตั้งค่าระบบ   "
echo -e "\033[1;31m\033[1;31m[\033[1;36m13\033[1;31m] \033[1;37m• \033[1;31mออกจากเมนูสคริปต์? \033[1;32m<\033[1;33m<\033[1;31m<"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;32mSelect Menu \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
1 | 01)
clear
sshovpnmenu
;;
2 | 02)
clear
l2tpmenu
;;
3 | 03)
clear
pptpmenu
;;
4 | 04)
clear
sstpmenu
;;
5 | 05)
clear
wgmenu
;;
6 | 06)
clear
ssmenu
;;
7 | 07)
clear
ssrmenu
;;
8 | 08)
clear
vmessmenu
;;
9 | 09)
clear
vlessmenu
;;
10)
clear
trmenu
;;
11)
clear
trgomenu
;;
12)
clear
setmenu
;;
13)
clear
exit
;;
*)
echo -e "\n\033[1;31mไม่พบเมนู !\033[0m"
sleep 1
clear
menu
;;
esac
}