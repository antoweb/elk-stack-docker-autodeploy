# elk-stack-docker-autodeploy
This repository provide a bash script to deploy a complete stack of Elk v. 8.2305.1 server in a Rocky 8 Linux server. It onclude also a readme for install and configure winlogbeat on a Windows Server

Installation:

- Copy all repository file to rocky linux machine
- Launch chmod +x install.sh
- launch comand: nohup ./install.sh > install_elk.log 2>&1 & (this will create a install_elk.log file to future troubleshooting in case of issues)
- Wait the completition of script
- Proceed to install agent winlogbeat/filebeat to windows or linux clients for foreward clients log to logstash server (see readme.txt)
Pay attention to:

- The script will launch dnf update (comment this line if you dont want to update your server)
- The script disable selinux permanently
- At the end of the script the server will be rebooted (comment out line 53 if you don't want to restart the server)
