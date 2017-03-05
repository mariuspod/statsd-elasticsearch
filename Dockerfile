FROM node:7.7.1-slim
MAINTAINER Marius Podwyszynski <marius.pod@gmail.com>

RUN mkdir -p /app && \
    cd /app && \
    curl -L https://github.com/etsy/statsd/tarball/master | tar -xz && \
    mv etsy-statsd-* statsd && \
    curl -o /app/statsd/backends/elastic.js -L https://raw.githubusercontent.com/markkimsal/statsd-elasticsearch-backend/master/lib/elasticsearch.js && \
    curl -o /app/statsd/backends/default_format.js -L https://raw.githubusercontent.com/markkimsal/statsd-elasticsearch-backend/master/lib/default_format.js && \
    curl -o /app/statsd/backends/regex_format.js -L https://raw.githubusercontent.com/markkimsal/statsd-elasticsearch-backend/master/lib/regex_format.js

ENV CONFIG_URL https://raw.githubusercontent.com/mariuspod/statsd-elasticsearch/master/config.js
RUN curl -L -k $CONFIG_URL -o /app/config.js
EXPOSE 8125/udp 8126
CMD [ "/app/statsd/bin/statsd", "/app/config.js" ]

