FROM ubuntu:disco

MAINTAINER Thierry TOUIN <thierrytouin.pro@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    NODE_VERSION=12.x \
    NPM_VERSION=6.13.7 \
    IONIC_VERSION=5.0.1 \
    CORDOVA_VERSION=9.0.0

ENV ANDROID_HOME=/home/user1/android

#BASIC STUFF
# Configure the "user1" user
RUN apt-get update
RUN apt-get install sudo

RUN groupadd user1 
RUN useradd user1 -s /bin/bash -m -g user1 -G sudo 
#RUN adduser --disabled-password --gecos '' user1
RUN adduser user1 sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'user1:user1' |chpasswd
RUN mkdir /home/user1/app

RUN mkdir /home/user1/android

RUN ["apt-get", "-y", "install", "jq","wget", "unzip", "vim"]

RUN apt-get install -y software-properties-common build-essential git wget curl unzip ruby \
    && git config --global user.email "thierrytouin.pro@gmail.com" \
    && git config --global user.name "Thierry Touin" \
    && curl -sL https://deb.nodesource.com/setup_$NODE_VERSION -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs \
    && npm install -g npm@"$NPM_VERSION" \
    && npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION" 
    #&& gem install sass \
    #&& ionic start myApp sidemenu \

#JAVA STUFF
RUN ["apt-get", "-y", "install", "openjdk-8-jdk"]

# add script to install android
#COPY script/installAndroid.sh /tmp
#RUN mv /tmp/installAndroid.sh /home/user1

# expose the working directory, the Tomcat port, the BrowserSync ports
USER user1

#WORKDIR myApp
WORKDIR "/home/user1/app"
VOLUME ["/home/user1/app"]

EXPOSE 8100 8200 35729

# Keep container alive
CMD tail -f /dev/null

#CMD ["ionic", "lab"]
