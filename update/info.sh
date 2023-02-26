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

BURIQ () {
    curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ipmini > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ipmini | grep $MYIP | awk '{print $2}')
Isadmin=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ipmini | grep $MYIP | awk '{print $5}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ipmini | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "Expires In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

clear
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           SERVER INFORMATION           ${NC} $COLOR1│$NC"
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 IP VPS        : $(curl -s ipinfo.io/ip ) ${NC}"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
if [ "$cekup" = "day" ]; then
echo -e "$COLOR1 SYSTEM UPTIME : $uphours $upminutes $uptimecek ${NC}"
else
echo -e "$COLOR1 SYSTEM UPTIME : $uphours $upminutes ${NC}"
fi
echo -e "$COLOR1 OS VPS        : ${NC}"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "$COLOR1 MEMORY USAGE  : $uram / $tram ${NC}"
echo -e "$COLOR1 ISP VPS       : $(curl -s ipinfo.io/org | cut -d " " -f 2-10 ) ${NC}"
echo -e "$COLOR1 REGION        : $(curl -s ipinfo.io/timezone ) ${NC}"
echo -e "$COLOR1 DOMAIN        : $(cat /etc/xray/domain)${NC}"
echo -e "$COLOR1 DATE&TIME     : $( date -d "0 days" +"%d-%m-%Y | %X" )${NC}"
if [ $exp \< 1000 ];
then
echo -e "$COLOR1 License     : ${GREEN}$sisa_hari$NC Days Tersisa ${NC}"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "$COLOR1 CLIENT NAME  : $Name ${NC}"
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}          SERVER PORT INFORMATION       ${NC} $COLOR1│$NC"       
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
esac
