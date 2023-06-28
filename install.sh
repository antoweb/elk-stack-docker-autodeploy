#!/bin/bash

#Script testato solo wu Rocky 8

#Disabiito selinux

setenforce 0

sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config &> /dev/null
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux &> /dev/null

#Copio readme.txt in /opt/elk
mkdir /opt/elk
cp readme.txt /opt/elk/readme.txt

#Aggiorno il sistema
dnf update -y

#Installo docker e i container elk
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin rsyslog wget vim nc mlocate
updatedb
systemctl enable docker
systemctl start docker
systemctl start rsyslog
systemctl enable rsyslog

echo "set mouse-=a" >> ~/.vimrc
cd /opt/elk/
wget -O /opt/elk/8.2305.1.tar.gz https://github.com/deviantony/docker-elk/archive/refs/tags/8.2305.1.tar.gz
tar xvzf /opt/elk/8.2305.1.tar.gz -C /opt/elk
rm -f /opt/elk/8.2305.1.tar.gz
cd /opt/elk/docker-elk-8.2305.1/
docker compose up setup
docker compose up -d

#Invio qualche log a logstash
echo "Invio qualche log a logstash"
cat /var/log/messages | nc --send-only localhost 50000


#stampo istruzioni per installare winlogbeat su windows
echo "Di seguito le istruzioni per confogurare windows"
cat /opt/elk/readme.txt

hostname -I | grep -o '^[^ ]*' > ipaddress.txt
ipaddress=$(cat ipaddress.txt)

echo "Per aprire l'interfaccia di elk andare su http://$ipaddress:5601"
echo "La login di default è elastic con password changme
echo "La macchina verrà riavviata fra 60 secondi"
sleep 60

init 6
