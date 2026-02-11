# FROM openjdk:8-jre-alpine
#FROM ubuntu:bionic 
#FROM ubuntu:cosmic
#FROM ubuntu:disco
#FROM ubuntu:focal
FROM ubuntu:noble

LABEL maintainer="Thierry TOUIN <thierrytouin.pro@gmail.com>"

# Set the Gradle version as a build argument
# ARG GRADLE_VERSION=6.8.3
# ARG GRADLE_VERSION=9.3.1
# ARG GRADLE_VERSION=8.5  
ARG GRADLE_VERSION=7.6.4



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
#RUN ["apt-get", "-y", "install", "python"]
RUN ["apt-get", "-y", "install", "g++"]
RUN ["apt-get", "-y", "install", "libpng-dev"]
RUN ["apt-get", "-y", "install", "build-essential"]
RUN ["apt-get", "-y", "install", "maven"]
RUN ["apt-get", "-y", "install", "telnet"]
RUN ["apt-get", "-y", "install", "jq"]
RUN ["apt-get", "-y", "install", "net-tools"]
RUN ["apt-get", "-y", "install", "iputils-ping"]

RUN ["apt-get", "-y", "install", "nmap","lsof"]

RUN ["apt-get", "-y", "install", "inotify-tools"]



VOLUME ["/home/user1/hist"]
VOLUME ["/home/user1/app"]
VOLUME ["/home/user1/binaries"]

# Installation Open JDK 8
#RUN ["apt-get", "-y", "install", "openjdk-8-jdk"]

# NodeJs (basique installation)
RUN ["apt-get", "-y", "install", "nodejs"]

# Installation Open JDK 11
# RUN ["apt-get", "-y", "install", "openjdk-11-jdk"]
# RUN update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java
# RUN update-alternatives --set javac /usr/lib/jvm/java-11-openjdk-amd64/bin/javac


# Installation Open JDK 17
RUN ["apt-get", "-y", "install", "openjdk-17-jdk"]
RUN update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
RUN update-alternatives --set javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac


# Installation Open JDK 21
# RUN ["apt-get", "-y", "install", "openjdk-21-jdk"]
# RUN update-alternatives --set java /usr/lib/jvm/java-21-openjdk-amd64/bin/java
# RUN update-alternatives --set javac /usr/lib/jvm/java-21-openjdk-amd64/bin/javac

# Installation Oracle JDK 8
#RUN ["mkdir", "/opt/jdk"]
#COPY binaries/jdk-8u221-linux-x64.tar.gz /tmp

#RUN ["tar", "-zvxf", "/tmp/jdk-8u221-linux-x64.tar.gz", "-C", "/opt/jdk"]
#RUN ["update-alternatives", "--install", "/usr/bin/java", "java", "/opt/jdk/jdk1.8.0_221/bin/java", "100"]
#RUN ["update-alternatives", "--install", "/usr/bin/javac", "javac", "/opt/jdk/jdk1.8.0_221/bin/javac", "100"]
#RUN ["rm", "/tmp/jdk-8u221-linux-x64.tar.gz"]
#RUN ["update-alternatives", "--set", "java", "/opt/jdk/jdk1.8.0_221/bin/java"]




# Set environment variables
ENV GRADLE_HOME=/opt/gradle/gradle-${GRADLE_VERSION}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Download and install Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget --no-check-certificate https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip && \
    ls /opt/gradle


RUN curl -L https://raw.githubusercontent.com/liferay/liferay-blade-cli/master/cli/installers/local | sh
RUN ln -s /root/jpm/bin/blade /usr/bin/

ENV ENV_PUID=1000
ENV ENV_PGID=1000


## USER1
USER user1
WORKDIR "/home/user1/app"

USER ${ENV_PUID}

EXPOSE 8080
EXPOSE 8005
EXPOSE 8009
EXPOSE 9200
EXPOSE 9300
EXPOSE 5005

# Keep container alive
CMD tail -f /dev/null
