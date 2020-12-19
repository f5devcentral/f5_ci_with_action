#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"

#Utils
sudo apt-get install unzip

WantedBy=multi-user.target
EOF


#Install Dockers
sudo snap install docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Run  nginx
sleep 10
cat << EOF > docker-compose.yml
version: "3.7"
services:
  web:
    image: nginxdemos/hello
    ports:
    - "9000:9000"
    restart: always
    command: [nginx-debug, '-g', 'daemon off;']
    network_mode: "host"
  
  app:
    image: karthequian/gruyere:latest
    ports:
    - "80:8008"
EOF
sudo docker-compose up -d