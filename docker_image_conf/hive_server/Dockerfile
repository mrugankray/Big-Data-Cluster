FROM bde2020/hive:2.3.2-postgresql-metastore

LABEL maintainer="mrugankray@gmail.com"
LABEL description="container with hive-server & sqoop"

# set the env variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV HADOOP_VERSION=2.7.4
ENV HADOOP_URL=https://www.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz
ENV HADOOP_PREFIX=/opt/hadoop-2.7.4
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV HIVE_VERSION=2.3.2
ENV HIVE_HOME=/opt/hive
ENV HADOOP_HOME=/opt/hadoop-2.7.4
ENV SQOOP_HOME=/usr/lib/sqoop
ENV PATH=/root/anaconda/bin:/opt/hive/bin:/opt/hadoop-2.7.4/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/sqoop/bin:/usr/lib/sqoop/bin

# install packages in /usr/lib/sqoop
WORKDIR /

# downloading sqoop
RUN curl -O https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && tar -xf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && rm -rf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && mv sqoop-1.4.7.bin__hadoop-2.6.0 /usr/lib/sqoop

# install packages from apt-get
RUN apt-get update || (apt-get install nano -y --force-yes && apt-get install openssh-server -y --force-yes)

# download jars for sqoop
WORKDIR /usr/lib/sqoop/lib

RUN curl -O http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.49.tar.gz && tar -xf mysql-connector-java-5.1.49.tar.gz && rm -rf mysql-connector-java-5.1.49.tar.gz && curl -O https://jdbc.postgresql.org/download/postgresql-42.5.0.jar --insecure && curl -O jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar && curl -O https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar && curl -O https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/org-json-java/org.json-20120521.jar && curl -O https://repo1.maven.org/maven2/org/apache/hive/hive-common/2.3.2/hive-common-2.3.2.jar

# download hadoop mapreduce client
WORKDIR /usr/lib/sqoop

RUN curl -O https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-jobclient/3.2.1/hadoop-mapreduce-client-jobclient-3.2.1.jar

# copy services & make it executable
COPY ./startup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/startup.sh

# set default workdir to /
WORKDIR /

# start hive server & ssh server
ENTRYPOINT ["entrypoint.sh"]
CMD ["/bin/sh", "-c", "startup.sh"]