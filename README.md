# elk-stack-docker-autodeploy
This repository provide a bash script to deploy a complete stack of Elk v. 8.2305.1 server in a Rocky 8 Linux server. It onclude also a readme for install and configure winlogbeat on a Windows Server

Pay attention to:

- The script will launch dnf update (comment this line if you dont want to update your server)
- The script disable selinux permanently
- At the end of the script the server will be rebooted (comment init 6 line if you dont want to rebbot)
