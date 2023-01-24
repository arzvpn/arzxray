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

function detailvmess(){
clear
MYIP=$(wget -qO- ipv4.icanhazip.com);
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo -e "\\E[0;41;36m     Check Detail XRAY Vmess     \E[0m"
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo ""
                echo "You have no existing clients!"
                clear
                exit 1
        fi

        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\\E[0;41;36m     Check Detail XRAY Vmess     \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo " Select the existing client to view the config"
        echo " Press CTRL+C to return"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "     No  User   Expired"
        grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
                if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                        read -rp "Select one client [1]: " CLIENT_NUMBER
                else
                        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
                fi
        done
user=$(cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
domain=$(cat /etc/xray/domain)
uuid=$(grep "},{" /etc/xray/config.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
clear
echo -e ""
echo -e "$COLOR1═════════════XRAY/VMESS═════════════${NC}"
echo -e "$COLOR1════════════════════════════════════${NC}"
echo -e "Remarks       : ${user}"
echo -e "Expired On    : $exp" 
echo -e "Domain        : ${domain}" 
echo -e "Port TLS      : 443" 
echo -e "Port none TLS : 80" 
echo -e "Port  GRPC    : 443" 
echo -e "id            : ${uuid}" 
echo -e "alterId       : 0" 
echo -e "Security      : auto" 
echo -e "Network       : ws" 
echo -e "Path          : /vmess" 
echo -e "Path WSS      : wss://yourbug/vmess" 
echo -e "ServiceName   : vmess-grpc" 
echo -e "$COLOR1════════════════════════════════════${NC}"
echo -e "Link TLS : "
echo -e "${vmesslink1}" 
echo -e "$COLOR1════════════════════════════════════${NC} "
echo -e "Link none TLS : "
echo -e "${vmesslink2}" 
echo -e "$COLOR1════════════════════════════════════${NC} "
echo -e "Link GRPC : "
echo -e "${vmesslink3}"
echo -e "$COLOR1════════════════════════════════════${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}"  
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vmess
}

function trialvmess(){
domain=$(cat /etc/xray/domain)
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "$COLOR1═════════════XRAY/VMESS═════════════${NC}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "id             : ${uuid}"
echo -e "alterId        : 0"
echo -e "Security       : auto"
echo -e "Network        : ws"
echo -e "Path           : /vmess"
echo -e "ServiceName    : vmess-grpc"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link TLS       : ${vmesslink1}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link none TLS  : ${vmesslink2}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link gRPC      : ${vmesslink3}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vmess
}
function delvmess(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •DELETE XRAY USER•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}             •Arz-VPN-STORE•                $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •DELETE XRAY USER•                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •DELETE XRAY USER•                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound Delete Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}
function renewvmess(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •RENEW VMESS USER•                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}"  
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •RENEW VMESS USER•                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/### $user/c\### $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •RENEW VMESS USER•                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1│${NC}   "
echo -e "$COLOR1│${NC}   Client Name : $user"
echo -e "$COLOR1│${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1│${NC}   Expired On  : $exp4"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}

function cekvmess(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            •VMESS USER ACTIVE•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo -e "$COLOR1│${NC} user : $akun";
echo -e "$COLOR1│${NC} $jum2";
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}

function addvmess(){
clear
source /var/lib/arzvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            •DETAIL VMESS ACCOUNT•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

read -rp "   Input Username : " -e user
      
if [ -z $user ]; then
echo -e "$COLOR1│${NC} [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            •DETAIL VMESS ACCOUNT•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
			read -n 1 -s -r -p "   Press any key to back on menu"
menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "$COLOR1═════════════XRAY/VMESS═════════════${NC}"
echo -e "$COLOR1════════════════════════════════════${NC}"
echo -e "Remarks       : ${user}"
echo -e "Expired On    : $exp" 
echo -e "Domain        : ${domain}" 
echo -e "Port TLS      : ${tls}" 
echo -e "Port none TLS : ${none}" 
echo -e "Port  GRPC    : ${tls}" 
echo -e "id            : ${uuid}" 
echo -e "alterId       : 0" 
echo -e "Security      : auto" 
echo -e "Network       : ws" 
echo -e "Path          : /vmess" 
echo -e "Path WSS      : wss://yourbug/vmess" 
echo -e "ServiceName   : vmess-grpc" 
echo -e "$COLOR1════════════════════════════════════${NC}" 
echo -e "$COLOR1════════════════════════════════════${NC}"
echo -e "Link TLS : "
echo -e "${vmesslink1}" 
echo -e "$COLOR1════════════════════════════════════${NC} "
echo -e "Link none TLS : "
echo -e "${vmesslink2}" 
echo -e "$COLOR1════════════════════════════════════${NC} "
echo -e "Link GRPC : "
echo -e "${vmesslink3}"
echo -e "$COLOR1════════════════════════════════════${NC}" 
echo -e "$COLOR1 Enjoy our Arz Auto Script Service${NC}" 
echo ""

read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}


clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             •VMESS MENU•              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[1]${NC} • CREATE VMESS ACCOUNT $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[2]${NC} • TRIAL VMESS $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[3]${NC} • RENEW VMESS $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[4]${NC} • DELETE VMESS $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[5]${NC} • CHECK USER ACTIVE $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[6]${NC} • DETAIL VMESS $NC"
echo -e " $COLOR1│$NC   ${COLOR1}[0]${NC} • BACK TO MENU $NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1╔═══════════════════ ≪ •❈• ≫ ═══════════════════╗${NC}"
echo -e "$COLOR1❚${NC}                •Arz-VPN-STORE•                $COLOR1❚$NC"
echo -e "$COLOR1╚═══════════════════ ≪ •❈• ≫ ═══════════════════╝${NC}" 
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addvmess ;;
02 | 2) clear ; trialvmess ;;
03 | 3) clear ; renewvmess ;;
04 | 4) clear ; delvmess ;;
05 | 5) clear ; cekvmess ;;
06 | 6) clear ; detailvmess ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vmess ;;
esac

       
