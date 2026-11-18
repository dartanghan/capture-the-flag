FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    passwd \
    && rm -rf /var/lib/apt/lists/*

COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 10051

ENTRYPOINT ["/usr/local/bin/setup.sh"]
