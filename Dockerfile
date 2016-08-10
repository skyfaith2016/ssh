FROM ubuntu:14.04
MAINTAINER skyfaith@topca.cn
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y openjdk-6-jdk

ENV TOMCAT_VERSION 8.0.35
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
RUN cd /tmp
RUN wget --quiet http://apache.rediris.es/tomcat/tomcat-8/v8.0.35/bin/apache-tomcat-8.0.35.tar.gz
tar xzvf /tmp/apache-tomcat-8.0.35.tar.gz -C /opt
mv /opt/apache-tomcat-8.0.35 /opt/tomcat
rm /tmp/tomcat.tgz
rm -rf /opt/tomcat/webapps/examples
rm -rf /opt/tomcat/webapps/docs
rm -rf /opt/tomcat/webapps/ROOT
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
VOLUME ["/opt/tomcat/webapps"]
EXPOSE 22 8080
CMD    ["/usr/sbin/sshd", "-D"]
