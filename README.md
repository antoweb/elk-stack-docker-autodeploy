# elk-stack-docker-autodeploy
This repository provide a bash script to deploy a complete stack of Elk v. 8.2305.1 server in a Rocky 8 Linux server. It onclude also a readme for install and configure winlogbeat on a Windows Server

Pay attention to:

- The script will launch dnf update (comment this line if you dont want to update your server)
- The script disable selinux permanently
- At the end of the script the server will be rebooted (comment out line 53 if you don't want to restart the server)
