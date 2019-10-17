FROM debian:latest

RUN    apt-get update  && apt-get upgrade -y && \
	   DEBIAN_FRONTEND=noninteractive apt-get install curl openssh-server ca-certificates postfix -y && \
	   DEBIAN_FRONTEND=noninteractive curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash && \
	   DEBIAN_FRONTEND=noninteractive apt-get install -y gitlab-ce && \
	   DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

WORKDIR /etc/gitlab

RUN		mkdir ssl 

# generate SSL certificates
RUN		openssl genrsa -out /etc/gitlab/ssl/gitlab.key 2048 && \
		openssl req -subj '/CN=192.168.99.100/O=My Company Name LTD./C=MA' -new -key /etc/gitlab/ssl/gitlab.key -out  /etc/gitlab/ssl/cert.csr && \
		openssl x509 -in /etc/gitlab/ssl/cert.csr -out /etc/gitlab/ssl/gitlab.crt -req -signkey /etc/gitlab/ssl/gitlab.key -days 365

# configure the gitlab.rb file
RUN 	sed -i '13s/http:\/\/gitlab.example.com/https:\/\/192.168.99.100/' gitlab.rb && \
		sed -i '1758s/#/ /' gitlab.rb && \
		sed -i '1758s/nil/false/' gitlab.rb && \
		echo "nginx['enable'] = true" >> gitlab.rb && \
		echo "nginx['redirect_http_to_https'] = true" >> gitlab.rb && \
		echo "nginx['redirect_http_to_https_port'] = 80" >> gitlab.rb && \
		echo "nginx['ssl_certificate'] = '/etc/gitlab/ssl/gitlab.crt'" >> gitlab.rb && \
		echo "nginx['ssl_certificate_key'] = '/etc/gitlab/ssl/gitlab.key'" >> gitlab.rb && \
		echo "gitlab_rails['gitlab_shell_ssh_port'] = 2222" >> gitlab.rb && \
		echo "Port 2222" >> /etc/ssh/sshd_config

WORKDIR /

RUN echo "/opt/gitlab/embedded/bin/runsvdir-start& gitlab-ctl reconfigure" > start.sh && \
	echo "service ssh restart" >> start.sh && \
	echo "echo 'Done!'" >> start.sh && \
	echo "tail -f /dev/null" >> start.sh && \
	chmod 777 start.sh

EXPOSE 80 443 2222
CMD ["sh", "start.sh"]


# How to build
#docker build -t ex03 .
# How to run 
#docker run -it -p 80:80 -p 443:443 -p 2222:2222 --privileged ex03
#	HTTPS clone
#git clone -c http.sslverify=false (IP Char):443<repo>.git

#SSH CLONE

#ssh-keygen -t ed25519 -C 'root@gitlab.com' -f id_ed25519
#copy it to gitlab
#env GIT_SSH_COMMAND='ssh -i id_ed25519' git clone ssh://git@192.168.99.100:2222/root/test.git

#SSH PUSH
#env GIT_SSH_COMMAND='ssh -i ../id_ed25519' git add . commit push
