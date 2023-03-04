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
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi

clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
rekk='xray'
becek='XRAY'
else
rekk='v2ray'
becek='V2RAY'
fi

ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}RUNNING${NC}"
else
ressh="${red}NOT RUNNING${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}RUNNING${NC}"
else
resst="${red}NOT RUNNING${NC}"
fi
sshws=$(service ws-dropbear status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
rews="${green}RUNNING${NC}"
else
rews="${red}NOT RUNNING${NC}"
fi

sshws2=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws2" = "active" ]; then
rews2="${green}RUNNING${NC}"
else
rews2="${red}NOT RUNNING${NC}"
fi

db=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$db" = "active" ]; then
resdb="${green}RUNNING${NC}"
else
resdb="${red}NOT RUNNING${NC}"
fi
 
v2r=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}RUNNING${NC}"
else
resv2r="${red}NOT RUNNING${NC}"
fi
vles=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$vles" = "active" ]; then
resvles="${green}RUNNING${NC}"
else
resvles="${red}NOT RUNNING${NC}"
fi
trj=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$trj" = "active" ]; then
restr="${green}RUNNING${NC}"
else
restr="${red}NOT RUNNING${NC}"
fi

ningx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ningx" = "active" ]; then
resnx="${green}RUNNING${NC}"
else
resnx="${red}NOT RUNNING${NC}"
fi

squid=$(service squid status | grep active | cut -d ' ' $stat)
if [ "$squid" = "active" ]; then
ressq="${green}RUNNING${NC}"
else
ressq="${red}NOT RUNNING${NC}"
fi
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • SERVER STATUS •               ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│${NC}  • SSH & VPN                        • $ressh"
echo -e " $COLOR1│${NC}  • SQUID                            • $ressq"
echo -e " $COLOR1│${NC}  • DROPBEAR                         • $resdb"
echo -e " $COLOR1│${NC}  • NGINX                            • $resnx"
echo -e " $COLOR1│${NC}  • WS DROPBEAR                      • $rews"
echo -e " $COLOR1│${NC}  • WS STUNNEL                       • $rews2"
echo -e " $COLOR1│${NC}  • STUNNEL                          • $resst"
echo -e " $COLOR1│${NC}  • XRAY-SS                          • $resv2r"
echo -e " $COLOR1│${NC}  • XRAY                             • $resv2r"
echo -e " $COLOR1│${NC}  • VMESS                            • $resv2r"
echo -e " $COLOR1│${NC}  • VLESS                            • $resvles"
echo -e " $COLOR1│${NC}  • TROJAN                           • $restr"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""
read -n 1 -s -r -p "  Press any key to back on menu" 
menu
