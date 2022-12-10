#!/bin/bash

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
  $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME
fi

# start namenode in daemon mode
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start namenode

# start spark master & slave
start-master.sh && start-slave.sh spark://namenode:7077
# start zepplin
zeppelin-daemon.sh start
# remove old pid files
rm -rf /root/airflow/*.pid
# start airflow webserver & scheduler parallely, that is why `&` is used
airflow webserver -p 3000 -D --workers 1 & airflow scheduler -D