#!/bin/bash
#Script By Arz
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/arzvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m" 
COLOR1="$(cat /etc/arzvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/arzvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"                    
###########- END COLOR CODE -##########

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • MENU CHANGE PORT •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[1]${NC} • PORT SSH/SSL $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[2]${NC} • PORT SSH WEBSOCKET $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[3]${NC} • PORT XRAY $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[0]${NC} • BACK TO MENU $NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; portssl ;;
02 | 2) clear ; portws ;;
03 | 3) clear ; portxray ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
