FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.3

MAINTAINER Thierry TOUIN <thierrytouin.pro@gmail.com>

RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-icu"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-kuromoji"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-smartcn"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-stempel"]



