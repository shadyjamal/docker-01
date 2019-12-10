FROM debian
COPY /script.sh /
RUN apt-get update &&\
	apt-get upgrade -y &&\
	apt-get install -y wget bzip2 &&\
	wget https://files.teamspeak-services.com/releases/server/3.9.1/teamspeak3-server_linux_amd64-3.9.1.tar.bz2 -P /tmp &&\
	chmod +x /script.sh
ENTRYPOINT ["/script.sh"]
