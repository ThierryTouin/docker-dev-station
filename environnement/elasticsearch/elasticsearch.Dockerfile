#FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.3
#FROM docker.elastic.co/elasticsearch/elasticsearch:7.13.1
FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.2


RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-icu"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-kuromoji"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-smartcn"]
RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "analysis-stempel"]



