#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
echo -e " [INFO] Downloading Update File"
sleep 2
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/mwebmin "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-webmin.sh" && chmod +x /usr/bin/mwebmin
wget -q -O /usr/bin/menu-ss "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/menu-bot "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-bot.sh" && chmod +x /usr/bin/menu-bot
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-ssh.sh" && chmod +x /usr/bin/menu-ssh
wget -q -O /usr/bin/menu-set "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-set.sh" && chmod +x /usr/bin/menu-set
wget -q -O /usr/bin/menu-theme "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-theme.sh" && chmod +x /usr/bin/menu-theme
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -q -O /usr/bin/menu-ip "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-ip.sh" && chmod +x /usr/bin/menu-ip
wget -q -O /usr/bin/menu-tor "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-tor.sh" && chmod +x /usr/bin/menu-tor
wget -q -O /usr/bin/autoboot "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/autoboot.sh" && chmod +x /usr/bin/autoboot
wget -q -O /usr/bin/menu-tcp "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-tcp.sh" && chmod +x /usr/bin/menu-tcp
wget -q -O /usr/bin/rebootvps "https://raw.githubusercontent.com/arzvpn/arzxray/main/corn/rebootvps.sh" && chmod +x /usr/bin/rebootvps
wget -q -O /usr/bin/menu-dns "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-dns.sh" && chmod +x /usr/bin/menu-dns
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/info.sh" && chmod +x /usr/bin/info
wget -q -O /usr/bin/mspeed "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-speedtest.sh" && chmod +x /usr/bin/mspeed
wget -q -O /usr/bin/mbandwith "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/menu-bandwith.sh" && chmod +x /usr/bin/mbandwith
wget -q -O /usr/bin/limitspeed "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/limitspeed.sh" && chmod +x /usr/bin/limitspeed
wget -q -O /usr/bin/ceklim "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/ceklim.sh" && chmod +x /usr/bin/ceklim
wget -q -O /usr/bin/autokill "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/autokill.sh" && chmod +x /usr/bin/autokill
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/tendang.sh" && chmod +x /usr/bin/tendang
wget -q -O /usr/bin/delete "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/delete.sh" && chmod +x /usr/bin/delete
wget -q -O /usr/bin/about "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/about.sh" && chmod +x /usr/bin/about
wget -q -O /usr/bin/runupdate "https://raw.githubusercontent.com/arzvpn/arzxray/main/update/runupdate.sh" && chmod +x /usr/bin/runupdate
echo -e " [INFO] Update Successfully"
sleep 2
exit
