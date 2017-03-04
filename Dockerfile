FROM node:alpine-7.7.1
MAINTAINER Marius Podwyszynski <marius.pod@gmail.com>

RUN mkdir -p /app && \
    cd /app && \
    curl -L https://github.com/etsy/statsd/tarball/master | tar -xz && \
    mv etsy-statsd-* statsd && \
    curl -o /app/statsd/backends/elasticsearch.js -L https://raw.githubusercontent.com/markkimsal/statsd-elasticsearch-backend/master/lib/elasticsearch.js

ADD config.js /app/

EXPOSE 8125/udp 8126

ENTRYPOINT [ "/app/statsd/bin/statsd", "/app/config.js" ]
