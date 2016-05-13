FROM ubuntu:latest:14.04.4
MAINTAINER skyfaith@topca.cn
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
VOLUME ["/data"]
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
