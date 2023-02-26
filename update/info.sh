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
if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/arzvpn/permission/main/ipmini | grep $MYIP | awk '{print $3}')
fi

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "\033[1;96m  Expires in    : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

clear
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           SERVER INFORMATION           ${NC} $COLOR1│$NC"
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "\033[1;91m  IP VPS        : $(curl -s ipinfo.io/ip ) \e[0m"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
if [ "$cekup" = "day" ]; then
echo -e "\033[1;91m  SYSTEM UPTIME : $uphours $upminutes $uptimecek \e[0m"
else
echo -e "\033[1;91m  SYSTEM UPTIME : $uphours $upminutes \e[0m"
fi
echo -e "\033[1;91m  OS VPS        : \e[0m"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "\033[1;91m  MEMORY USAGE  : $uram / $tram \e[0m"
echo -e "\033[1;91m  ISP VPS       : $(curl -s ipinfo.io/org | cut -d " " -f 2-10 ) \e[0m"
echo -e "\033[1;91m  REGION        : $(curl -s ipinfo.io/timezone ) \e[0m"
echo -e "\033[1;91m  DOMAIN        : $(cat /etc/xray/domain)\e[0m"
echo -e "\033[1;91m  DATE&TIME     : $( date -d "0 days" +"%d-%m-%Y | %X" )\e[0m"
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}          AUTOSCRIPT INFORMATION        ${NC} $COLOR1│$NC"       
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "\033[1;96m  Owner        : Arz Vpn Store \e[0m"
echo -e "\033[1;96m  Contact      : Wa: 083117634078 \e[0m"
echo -e "\033[1;96m  Telegram     : t.me/Store_Arz \e[0m"
echo -e "\033[1;96m  Official     : t.me/arzvpn \e[0m"
echo -e "\033[1;96m  Type Script  : Multiport V2 \e[0m"
echo -e "\033[1;96m  Version SC   : $(cat /opt/.ver) \e[0m"
if [ $Exp \< 1000 ];
then
echo -e "\033[1;96m  License      : $sisa_hari$NC Days Tersisa \e[0m"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "\033[1;96m  CLIENT NAME  : $Name \e[0m"
echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}          SERVER PORT INFORMATION       ${NC} $COLOR1│$NC"       
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "\033[1;93m  >Port SSH Websocket       :80\e[0m"
echo -e "\033[1;93m  >Port SSH Websocket SSL   :443\e[0m"
echo -e "\033[1;93m  >Port SSH SSL             :222,777\e[0m"
echo -e "\033[1;93m  >Port OpenSSH             :22\e[0m"
echo -e "\033[1;93m  >Port SSH Dropbear        :109,143\e[0m"
echo -e "\033[1;93m  >Port Xray None TLS       :80\e[0m"
echo -e "\033[1;93m  >Port Xray TLS            :443\e[0m"
echo -e "\033[1;93m  >Port Vmess None TLS      :80\e[0m"
echo -e "\033[1;93m  >Port Vmess TLS           :443\e[0m"
echo -e "\033[1;93m  >Port Vmess GRPC          :443\e[0m"
echo -e "\033[1;93m  >Port Vless None TLS      :80\e[0m"
echo -e "\033[1;93m  >Port Vless TLS           :443\e[0m"
echo -e "\033[1;93m  >Port Vless GRPC          :443\e[0m"
echo -e "\033[1;93m  >Port Trojan WS           :443\e[0m"
echo -e "\033[1;93m  >Port Trojan GRPC         :443\e[0m"
echo -e "\033[1;93m  >Port ShadowSocks WS      :443\e[0m"
echo -e "\033[1;93m  >Port ShadowSocks GRPC    :443\e[0m"
echo -e "\033[1;97m  Service Support Change Port \e[0m"
echo -e ""
echo -e "\033[1;97mOrder AutoScript Lifetime wa.me/6283117634078\e[0m"
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
esac
