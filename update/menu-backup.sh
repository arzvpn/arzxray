# SCRIPT BY Arz

red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'

function backup(){ 
clear
IP=$(wget -qO- icanhazip.com);
date=$(date +"%Y-%m-%d")
clear
echo " VPS Data Backup By Arz "
sleep 1
echo ""
echo -e "[ ${green}INFO${NC} ] Please Insert Password To Secure Backup Data ."
echo ""
read -rp "Enter password : " -e InputPass
clear
sleep 1
if [[ -z $InputPass ]]; then
exit 0
fi
echo -e "[ ${green}INFO${NC} ] Processing . . . "
mkdir -p /root/backup
sleep 1
clear
echo " Please Wait VPS Data Backup In Progress . . . "
#cp -r /root/.acme.sh /root/backup/ &> /dev/null
#cp -r /var/lib/arzvpn-pro/ /root/backup/arzvpn-pro
#cp -r /etc/xray /root/backup/xray
cp -r /etc/xray/*.json /root/backup/ >/dev/null 2>&1
cp -r /home/vps/public_html /root/backup/public_html
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp -r /etc/crontab /root/backup/crontab &> /dev/null
cd /root
zip -rP $InputPass $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
clear
echo -e "\033[1;37mVPS Data Backup By Arz\033[0m
\033[1;37mTelegram : https://t.me/Store_Arz / @Store_Arz\033[0m"
echo ""
echo "Please Copy Link Below & Save In Notepad"
echo ""
echo -e "Your VPS IP ( \033[1;37m$IP\033[0m )"
echo ""
echo -e "Your VPS Data Backup Password : \033[1;37m$InputPass\033[0m"
echo ""
echo -e "\033[1;37m$link\033[0m"
echo ""
echo "If you want to restore data, please enter the link above"
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo ""
}

function restore(){
clear
echo ""
echo " This Feature Can Only Be Used According To VPS Data With This Autoscript"
echo " Please Insert VPS Data Backup Link To Restore The Data"
echo ""
read -rp " Password File: " -e InputPass
read -rp " Link File: " -e url
wget -O backup.zip "$url"
unzip -P $InputPass /root/backup.zip &> /dev/null
rm -f backup.zip
sleep 1
echo -e "[ ${green}INFO${NC} ] Start Restore . . . "
#cp -r /root/backup/.acme.sh /root/ &> /dev/null
#cp -r /root/backup/arzvpn-pro /var/lib/ &> /dev/null
#cp -r /root/backup/xray /usr/local/etc/ &> /dev/null
cp -r /root/backup/*.json /etc/xray/ >/dev/null
cp -r /root/backup/public_html /home/vps/ &> /dev/null
cp -r /root/backup/crontab /etc/ &> /dev/null
cp -r /root/backup/cron.d /etc/ &> /dev/null
rm -rf /root/backup
rm -f backup.zip
echo ""
echo -e "[ ${green}INFO${NC} ] VPS Data Restore Complete !"
echo ""
echo -e "[ ${green}INFO${NC} ] Restart All Service"
systemctl restart nginx
systemctl restart xray.service
service cron restart
sleep 0.5
clear
}

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •BACKUP MENU•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[1]${NC} • CREATE VMESS ACCOUNT $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[2]${NC} • TRIAL VMESS $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[0]${NC} • BACK TO MENU $NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; backup ;;
02 | 2) clear ; restore ;;
00 | 0) clear ; menu ;;
*) clear ; menu-backup ;;
esac
