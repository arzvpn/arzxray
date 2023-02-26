#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/arzvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m" 
COLOR1="$(cat /etc/arzvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/arzvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"                    
###########- END COLOR CODE -##########
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )

clear
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           SERVER INFORMATION           ${NC} $COLOR1│$NC"
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "\E[0;41;36m IP VPS        : $(curl -s ipinfo.io/ip ) \E[0m"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
if [ "$cekup" = "day" ]; then
echo -e "\E[0;41;36m SYSTEM UPTIME : $uphours $upminutes $uptimecek \E[0m"
else
echo -e "\E[0;41;36m SYSTEM UPTIME : $uphours $upminutes \E[0m"
fi
echo -e "\E[0;41;36m MEMORY USAGE  : $uram / $tram \E[0m"
echo -e "\E[0;41;36m OS VPS        : \E[0m"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-
echo -e "\E[0;41;36m ISP VPS       : $(curl -s ipinfo.io/org | cut -d " " -f 2-10 ) \E[0m"
echo -e "\E[0;41;36m REGION        : $(curl -s ipinfo.io/timezone ) "
echo -e "\E[0;41;36m DOMAIN        : $(cat /etc/xray/domain)"
echo -e "\E[0;41;36m DATE&TIME     : $( date -d "0 days" +"%d-%m-%Y | %X" )"
DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "\E[0;41;36m Expires In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""
if [ $exp \< 1000 ];
then
echo -e "\E[0;41;36m License     : ${GREEN}$sisa_hari$NC Days Tersisa \E[0m"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "\E[0;41;36m CLIENT NAME  : $Name \E[0m"
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}          SERVER PORT INFORMATION       ${NC} $COLOR1│$NC"       
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
esac
