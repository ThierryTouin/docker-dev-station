#FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.3
#FROM docker.elastic.co/elasticsearch/elasticsearch:7.13.1
#FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.2
FROM docker.elastic.co/elasticsearch/elasticsearch:8.11.4

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel

HEALTHCHECK --interval=5s --timeout=2s --retries=5 --start-period=10s \
  CMD curl --silent --fail 127.0.0.1:9200/_cluster/health || exit 1

