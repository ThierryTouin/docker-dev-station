# FROM openjdk:8-jre-alpine
FROM ubuntu:cosmic

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    APPLICATION_SLEEP=0 \
    JAVA_OPTS=""


RUN \
  # configure the "user1" user
  groupadd user1 && \
  useradd user1 -s /bin/bash -m -g user1 -G sudo && \
  echo 'user1:user1' |chpasswd && \
  mkdir /home/user1/app && \
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  # install utilities
  apt-get install -y \
    wget \
    curl \
    htop \
    vim \
    git \
    zip \
    bzip2 \
    fontconfig \
    python \
    g++ \
    libpng-dev \
    build-essential \
    maven

# Add a user1 user to run our application so that it doesn't need to run as root
#RUN adduser -D -s /bin/sh user1
#WORKDIR /home/user1

#ADD entrypoint.sh entrypoint.sh
#RUN chmod 755 entrypoint.sh && chown user1:user1 entrypoint.sh
#USER user1

# expose the working directory, the Tomcat port, the BrowserSync ports
USER user1
#ENV PATH $PATH:/usr/bin:/home/user1/.yarn-global/bin:/home/user1/.yarn/bin:/home/user1/.config/yarn/global/node_modules/.bin
WORKDIR "/home/user1/app"
VOLUME ["/home/user1/app"]


EXPOSE 8080

# Keep container alive
CMD tail -f /dev/null
