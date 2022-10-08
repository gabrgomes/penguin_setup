#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run with sudo"
    	exit
fi
# apt install curl
# echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
# curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x93C4A3FD7BB9C367" | sudo apt-key add
apt update
apt install -y python3-pip
pip3 install ansible
ansible-galaxy install -r requirements.yml 
echo "Complete setup by running 'ansible-playbook setup_penguin.yml'"
