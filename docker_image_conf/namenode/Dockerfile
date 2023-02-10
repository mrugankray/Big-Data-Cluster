FROM bde2020/hadoop-namenode:2.0.0-hadoop3.2.1-java8

LABEL maintainer="mrugankray@gmail.com"
LABEL description="container with namenode, spark, airflow, flume & zepplin installed"

# set the env variables
ENV SPARK_HOME=/opt/spark
ENV PYSPARK_PYTHON=/root/anaconda/bin/python3.9
ENV ZEPPELIN_HOME=/opt/zeppelin
ENV AIRFLOW_HOME=~/airflow
ENV FLUME_HOME=/opt/flume
ENV PATH=/root/anaconda/bin:/opt/hadoop-3.2.1/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/spark/bin:/opt/spark/sbin:/opt/zeppelin/bin:/opt/flume/bin

# install packages in /opt
WORKDIR /opt

# installing mini conda
RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && mv Mini* miniconda.sh && bash miniconda.sh -b -u -p ~/anaconda && conda update conda -y && rm miniconda.sh && conda install conda-pack -y

# installing spark
RUN curl -O https://archive.apache.org/dist/spark/spark-3.2.2/spark-3.2.2-bin-hadoop3.2.tgz && tar xf spark-* && rm -rf spark*.tgz && mv spark-3.2.2-bin-hadoop3.2 spark && rm -rf spark-3.2.2-bin-hadoop3.2

# download spark jars
WORKDIR /opt/spark/jars

RUN curl -O https://repo1.maven.org/maven2/com/sun/jersey/jersey-client/1.19.4/jersey-client-1.19.4.jar && curl -O https://repo1.maven.org/maven2/com/sun/jersey/jersey-bundle/1.19.4/jersey-bundle-1.19.4.jar && curl -O https://repo1.maven.org/maven2/com/datastax/spark/spark-cassandra-connector-assembly_2.12/3.2.0/spark-cassandra-connector-assembly_2.12-3.2.0.jar && curl -O http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.49.tar.gz && tar -xf mysql-connector-java-5.1.49.tar.gz && rm -rf mysql-connector-java-5.1.49.tar.gz && curl -O https://jdbc.postgresql.org/download/postgresql-42.5.0.jar --insecure && curl -O https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.2.1/spark-sql-kafka-0-10_2.12-3.2.1.jar && curl -O https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/3.2.2/kafka-clients-3.2.2.jar && curl -O https://repo1.maven.org/maven2/org/apache/spark/spark-avro_2.12/3.2.2/spark-avro_2.12-3.2.2.jar && curl -O https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-0-10_2.12/3.2.2/spark-token-provider-kafka-0-10_2.12-3.2.2.jar && curl -O https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/2.11.1/commons-pool2-2.11.1.jar && curl -O https://repo1.maven.org/maven2/org/apache/avro/avro-mapred/1.11.1/avro-mapred-1.11.1.jar

# start spark standalone cluster
# WORKDIR /opt/spark/sbin

# install zepplin
WORKDIR /opt

RUN curl -O https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-netinst.tgz --insecure && tar -xf zeppelin-0.10.1-bin-netinst.tgz && rm -rf zeppelin*.tgz && mv zeppelin-0.10.1-bin-netinst zeppelin && rm -rf zeppelin-0.10.1-bin-netinst

# install python confluent kafka package
RUN conda install -c conda-forge python-confluent-kafka=1.9.2 -y && conda install fastavro=1.7.0 -y

# install airflow
RUN conda install apache-airflow=2.3.3 -y && conda install -c anaconda psycopg2=2.9.3 -y && conda install -c conda-forge apache-airflow-providers-apache-spark=3.0.0 -y && conda install -c conda-forge apache-airflow-providers-ssh=3.2.0 -y

WORKDIR /root/airflow

RUN airflow db init && \
    airflow users create \
    --username admin \
    --password admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@gmail.com

# install flume
WORKDIR /opt

RUN curl -O https://dlcdn.apache.org/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz --insecure && tar -xf apache-flume-1.11.0-bin.tar.gz && rm -rf apache-flume-1.11.0-bin.tar.gz && mv apache-flume-1.11.0-bin flume && rm -rf apache-flume-1.11.0-bin

# download flume jars
WORKDIR /opt/flume/lib

RUN rm -rf guava-11.0.2.jar && mv log4j-slf4j-impl-2.18.0.jar ../ && curl -O https://repo1.maven.org/maven2/com/google/guava/guava/31.1-jre/guava-31.1-jre.jar

# copy services file
WORKDIR /
COPY ./start_services.sh /

# install nano
RUN apt-get update && apt-get install nano -y

# start namenode, spark, airflow, zepplin
CMD ["/start_services.sh"]