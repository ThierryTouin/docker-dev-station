FROM alpine:latest

MAINTAINER Wouter Vernaillen <wouter@triberay.com>

RUN apk update \
  && apk upgrade \
  && apk add --no-cache curl openjdk8

ENV MOCKMOCK_URL=https://github.com/tweakers-dev/MockMock/blob/master/release/MockMock.jar?raw=true

RUN set -x \
  && curl -fSL "$MOCKMOCK_URL" -o MockMock.jar

CMD ["java","-jar","MockMock.jar"]
