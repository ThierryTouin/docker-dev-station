# FROM openjdk:8-jre-alpine
#FROM ubuntu:bionic 
#FROM ubuntu:cosmic
#FROM ubuntu:disco
FROM ubuntu:focal


MAINTAINER Thierry TOUIN <thierrytouin.pro@gmail.com>

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    APPLICATION_SLEEP=0 \
    JAVA_OPTS=""


RUN ["apt-get", "-y", "update"]
RUN ["apt-get", "-y", "install", "software-properties-common"]


# Create user1
RUN ["apt-get", "-y", "install", "sudo"]
RUN \
  # configure the "user1" user
  groupadd user1 && \
  useradd user1 -s /bin/bash -m -g user1 -G sudo && \
  echo 'user1:user1' |chpasswd && \
  mkdir /home/user1/app 

RUN ["mkdir", "/home/user1/hist"]
RUN ["chown", "-R", "user1:user1", "/home/user1/hist"]

RUN ["mkdir", "/home/user1/binaries"]

 
# INSTALL UTILITIES
RUN ["apt-get", "-y", "install", "wget"]
RUN ["apt-get", "-y", "install", "curl"]
RUN ["apt-get", "-y", "install", "htop"]
RUN ["apt-get", "-y", "install", "vim"]
RUN ["apt-get", "-y", "install", "git"]
RUN ["apt-get", "-y", "install", "zip"]
RUN ["apt-get", "-y", "install", "bzip2"]
RUN ["apt-get", "-y", "install", "fontconfig"]
RUN ["apt-get", "-y", "install", "python"]
RUN ["apt-get", "-y", "install", "g++"]
RUN ["apt-get", "-y", "install", "libpng-dev"]
RUN ["apt-get", "-y", "install", "build-essential"]
RUN ["apt-get", "-y", "install", "maven"]
RUN ["apt-get", "-y", "install", "telnet"]
RUN ["apt-get", "-y", "install", "jq"]
RUN ["apt-get", "-y", "install", "net-tools"]
RUN ["apt-get", "-y", "install", "iputils-ping"]
RUN ["apt-get", "-y", "install", "nmap"]

VOLUME ["/home/user1/hist"]
VOLUME ["/home/user1/app"]
VOLUME ["/home/user1/binaries"]

# Installation Open JDK 8
#RUN ["apt-get", "-y", "install", "openjdk-8-jdk"]

# NodeJs (basique installation)
RUN ["apt-get", "-y", "install", "nodejs"]

# Installation Open JDK 11
RUN ["apt-get", "-y", "install", "openjdk-11-jdk"]

# Installation Oracle JDK 8
RUN ["mkdir", "/opt/jdk"]
# # RUN wget --user=*** --password=******* --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz
#RUN ls /home/user1/binaries
COPY binaries/jdk-8u221-linux-x64.tar.gz /tmp

RUN ["tar", "-zvxf", "/tmp/jdk-8u221-linux-x64.tar.gz", "-C", "/opt/jdk"]
RUN ["update-alternatives", "--install", "/usr/bin/java", "java", "/opt/jdk/jdk1.8.0_221/bin/java", "100"]
RUN ["update-alternatives", "--install", "/usr/bin/javac", "javac", "/opt/jdk/jdk1.8.0_221/bin/javac", "100"]
RUN ["rm", "/tmp/jdk-8u221-linux-x64.tar.gz"]
RUN ["update-alternatives", "--set", "java", "/opt/jdk/jdk1.8.0_221/bin/java"]

## USER1
USER user1
WORKDIR "/home/user1/app"

EXPOSE 8080
EXPOSE 8005
EXPOSE 8009
EXPOSE 9200
EXPOSE 9300
EXPOSE 5005

# Keep container alive
CMD tail -f /dev/null
