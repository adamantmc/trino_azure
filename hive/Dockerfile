FROM ubuntu:22.04

RUN apt update
RUN apt install -y wget openjdk-17-jdk-headless openjdk-17-jre-headless openjdk-17-jre

ENV HADOOP_VERSION=3.3.0
ENV HIVE_METASTORE_VERSION=3.0.0
ENV STORAGE_ACCOUNT_NAME=
ENV STORAGE_ACCOUNT_KEY=

WORKDIR /opt/

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -O ./hadoop.tar.gz
RUN wget https://downloads.apache.org/hive/hive-standalone-metastore-${HIVE_METASTORE_VERSION}/hive-standalone-metastore-${HIVE_METASTORE_VERSION}-bin.tar.gz \
    -O ./hive.tar.gz

RUN tar -xzf hadoop.tar.gz
RUN tar -xzf hive.tar.gz

RUN mv apache-hive-metastore-${HIVE_METASTORE_VERSION}-bin hive_metastore
RUN mv hadoop-${HADOOP_VERSION} hadoop

COPY conf/core-site.xml /opt/hive_metastore/conf/core-site.xml
COPY conf/metastore-site.xml /opt/hive_metastore/conf/metastore-site.xml

ENV HADOOP_HOME=/opt/hadoop/
ENV HADOOP_OPTIONAL_TOOLS=hadoop-azure

COPY scripts/init_hive_metastore.sh /opt/init_hive_metastore.sh
COPY scripts/run_hive_metastore.sh /opt/run_hive_metastore.sh

RUN chmod +x /opt/init_hive_metastore.sh
RUN chmod +x /opt/run_hive_metastore.sh

# Fix 'java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkArgument'
# Keep this until this lands: https://issues.apache.org/jira/browse/HIVE-22915"
# Taken from https://github.com/naushadh/hive-metastore

RUN rm /opt/hive_metastore/lib/guava-19.0.jar && \
    cp /opt/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar /opt/hive_metastore/lib/

RUN /opt/init_hive_metastore.sh

CMD /opt/run_hive_metastore.sh
