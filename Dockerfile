FROM node:7.7.1-slim
MAINTAINER Marius Podwyszynski <marius.pod@gmail.com>

RUN mkdir -p /app && \
    cd /app && \
    curl -L https://github.com/etsy/statsd/tarball/master | tar -xz && \
    mv etsy-statsd-* statsd && \
    apt-get update && apt-get install -y git && \
    npm install git://github.com/markkimsal/statsd-elasticsearch-backend.git

ENV CONFIG_URL https://raw.githubusercontent.com/mariuspod/statsd-elasticsearch/master/config.js
RUN curl -L -k $CONFIG_URL -o /app/config.js
RUN apt-get remove -y git && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8125/udp 8126
CMD [ "/app/statsd/bin/statsd", "/app/config.js" ]

