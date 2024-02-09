FROM ubuntu:22.04

RUN apt update
RUN apt install -y wget openjdk-21-jdk-headless openjdk-21-jre-headless openjdk-21-jre

ARG TRINO_VERSION=438
ENV STORAGE_ACCOUNT_NAME=
ENV STORAGE_ACCOUNT_KEY=
ENV HIVE_URL=thrift://localhost:9083

WORKDIR /opt/

RUN wget https://repo1.maven.org/maven2/io/trino/trino-server/${TRINO_VERSION}/trino-server-${TRINO_VERSION}.tar.gz -O ./trino.tar.gz
RUN tar -xzf trino.tar.gz
RUN rm trino.tar.gz

RUN mv trino-server-${TRINO_VERSION} trino-server
RUN chmod +x /opt/trino-server/bin/launcher.py

COPY etc/*.properties etc/*.config /opt/trino-server/etc/
COPY etc/catalog/* /opt/trino-server/etc/catalog/

COPY scripts/run_trino.sh /opt/run_trino.sh

RUN chmod +x /opt/run_trino.sh

CMD /opt/run_trino.sh
