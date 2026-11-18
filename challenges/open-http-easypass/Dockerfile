FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    passwd \
    && rm -rf /var/lib/apt/lists/*

COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/setup.sh"]
