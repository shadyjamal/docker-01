#!/bin/sh

TS3_DIR="/opt/ts3server"

cd /tmp
tar -xjf teamspeak3-server_linux_amd64-3.9.1.tar.bz2
rm teamspeak3-server_linux_amd64-3.9.1.tar.bz2

# move it to the new DIR
mkdir $TS3_DIR
mv teamspeak3-server_linux_amd64/* $TS3_DIR
cd $TS3_DIR

#Accept the TS3 License
touch .ts3server_license_accepted

#Execute
./ts3server

#	How to build?

#docker build -t ex01 .

#	How to run 

#docker run -p 30033:30033 -p 10011:10011 -p 9987:9987/udp -it --rm ex01
