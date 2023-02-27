# Hi there, I'm [Mrugank][linkedin] 👋 

[![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UC_o2rxaj5w_CAl5y_V1nqNg?logo=youtube&logoColor=red&style=for-the-badge)][youtube] [![My Website](https://img.shields.io/website?style=for-the-badge&url=https%3A%2F%2Fmrayonline.web.app%2F)][website] [![LinkedIn](https://img.shields.io/website?color=blue&label=linkedin&logo=linkedin&logoColor=blue&style=for-the-badge&up_color=green&up_message=mrugank%20ray&url=https%3A%2F%2Fmrayonline.web.app%2F)][linkedin] [![Buy me coffee](https://img.shields.io/website?label=Buy%20Me%20coffee&style=for-the-badge&up_color=orange&up_message=mrugank%20ray&url=https%3A%2F%2Fwww.buymeacoffee.com%2Fmrugankray)][buy_me_coffee]

## Table of Contents
1. [Overview](#overview)
2. [Applications](#applications)
3. [Running big data cluster](#running-big-data-cluster)
4. [Access docker containers](#access-docker-containers)
5. [Access hadoop ecosystem](#access-hadoop-ecosystem)
6. [Containers running in the cluster](#containers-running-in-the-cluster)
7. [Access HDFS](#access-hdfs)
8. [Access Postgres DB](#access-postgres-db)
9. [Access Kadmin](#access-kadmin)
10. [Run hive queries](#run-hive-queries)
11. [Run PySpark](#run-pyspark)
12. [Run sqoop](#run-sqoop)
13. [Run airflow](#run-airflow)
14. [Create Kafka Topic](#create-kafka-topic)
15. [Create Kafka Producer](#create-kafka-producer)
16. [Create Kafka Consumer](#create-kafka-consumer)
17. [Run flume agents](#run-flume-agents)
18. [Run queries in cassandra](#run-queries-in-cassandra)
19. [Available Jars](#available-jars)
20. [Configure hadoop](#configure-hadoop)
21. [Configure hue](#configure-hue)
22. [Configure zeppelin](#configure-zeppelin)
23. [Configure airflow](#configure-airflow)
24. [Configure sqoop](#configure-sqoop)
25. [Configure ssh server](#configure-ssh-server)
26. [Build Custom Docker Images](#build-custom-docker-images)
27. [Manage resources](#manage-resources)
28. [Dependencies](#dependencies)

## Overview
Today, there are many projects available that were created to deploy a Spark or Hadoop cluster, but they are either ineffective or resource-intensive, causing the system to freeze. 
This repository is created to simplify the deployment of these clusters on a local machine using Docker containers.

## Applications
This project will start a docker cluster which gives access to the following frameworks/technologies.
|Framework/Technology | Version |
|--- |--- |
| Hadoop | 3.2.1 |
| Mini-Conda | 4.12.0 |
| Python | 3.9 |
| Spark | 3.2.2(Built using scala 2.12)  |
| Airflow | 2.3.3 |
| Zeppelin | 0.10.1 |
| Hive | 2.3.2 |
| Hue | 4.6.0 |
| Sqoop | 1.4.7 |
| Confluent Kafka | 5.4.0-ce |
| Confluent Schema Registry | 5.4.0-ce |
| Confluent Control Center | 5.4.0 |
| Kadmin | 0.9.3 |
| Flume | 1.11.0 |
| Postgres | 15.1 |
| pgAdmin4 | 6.18 |
| Cassandra | 4.1.0 |

## Running big data cluster
To start the cluster run the following command from the project directory.

### Start basic cluster 
The basic cluster gives access to Hadoop, PySpark, Airflow, Flume and Zeppelin. It's a great place to start if you want to try out some of these tools without having to install them on your computer. 

##### On Linux
```sh
sudo docker-compose -f basic-hadoop-docker-compose.yaml up
```

##### On Windows 10
```sh
docker-compose -f basic-hadoop-docker-compose.yaml up
```
> Note: You need to install WSL 2 on windows to run this cluster.

### Start basic cluster + Hive + Hue + DB
This file starts the basic cluster, Hive, Hue, Postgres, pgAdmin & Cassandra. This is great for building batch processing pipelines.

##### On Linux
```sh
sudo docker-compose -f hive-sqoop-postgres-cassandra-docker-compose.yaml up
```

##### On Windows 10
```sh
docker-compose -f hive-sqoop-postgres-cassandra-docker-compose.yaml up
```
> Note: You need to install WSL 2 on windows to run this cluster.

### Start basic cluster + kafka + schema registry
This file starts the basic cluster, zookeeper, kafka broker & schema registry. This is great for building streaming pipelines.

##### On Linux
```sh
sudo docker-compose -f kafka-docker-compose.yaml up
```

##### On Windows 10
```sh
docker-compose -f kafka-docker-compose.yaml up
```
> Note: You need to install WSL 2 on windows to run this cluster.

### Start kafka cluster
This file starts a kafka cluster. This is great for getting started with kafka and schema registry.

##### On Linux
```sh
sudo docker-compose -f kafka-zookeper.yaml up
```

##### On Windows 10
```sh
docker-compose -f kafka-zookeper.yaml up
```
> Note: You need to install WSL 2 on windows to run this cluster.

### Start full cluster
This file starts all the framework/technology that are mentioned [here](#applications).

##### On Linux
```sh
sudo docker-compose -f all-docker-compose.yaml up
```

##### On Windows 10
```sh
docker-compose -f all-docker-compose.yaml up
```
> Note: You need to install WSL 2 on windows to run this cluster.

## Access docker containers
You can access a container by running this command 
```sh
sudo docker exec -it <container-name> /bin/bash
```
If this does not work replace `/bin/bash` with `/bin/sh`

## Access hadoop ecosystem
This is a list of technologies or frameworks are exposed to the Host. You can access these using the following urls.
|Application | Url |
|--- |--- |
| Namenode UI | http://localhost:9870/dfshealth.html#tab-overview |
| Namenode(IPC port) | http://localhost:9000 |
| History server | http://localhost:8188/applicationhistory |
| Datanode | http://localhost:9864/ |
| Nodemanager | http://localhost:8042/node |
| Resource manager | http://localhost:8088/ |
| Hue | http://localhost:8888 |
| Spark Master UI | http://localhost:8080 |
| Spark Slave UI | http://localhost:8081 |
| Spark Driver UI | http://localhost:4040 (accessible only after a driver is started) |
| Zeppelin UI | http://localhost:8082 |
| Airflow UI | http://localhost:3000 |
| pgAdmin UI | http://localhost:5000 |
| Zookeeper|  http://localhost:2181 |
| kafka broker | http://localhost:9092 |
| Schema Registry | http://localhost:8083 |
| Kadmin UI | http://localhost:8084/kadmin/ |
| Kafka Control Center | http://localhost:9021 |

## Containers running in the cluster
Below are containers running in the cluster.
|Container Name | Installed Frameworks/Tech | Description |
|--- |--- |--- |
| namenode | HDFS Namenode, Spark Master Node, Spark Slave Node, Zeppeline, Airflow, Flume & Python | It acts as a namenode & also has access to other framework/tech. |
| datanode | HDFS Datanode, Python | It acts as a datanode & python is installed. |
| resourcemanager | YARN, Python | It acts as YARN & python is installed. Default YARN scheduler is set to `CapacityScheduler`. |
| nodemanager | Nodemanager, Python | It acts as a nodemanager & python is installed. |
| historyserver | History Server | Tracking of past jobs are delegated to History server. |
| hive-server | Hive server 2, Sqoop | Hive server 2 runs on this container, You can also create & execute sqoop jobs from this container. |
| hive-metastore | Hive metastore | Hive metastore service runs here. It is used to store Hive ralated metadata |
| hive-metastore-postgresql | Postgres | Used by Hive metastore to store metadata. |
| hue | Hue Server | Hue server run here.|
| huedb | Postgres | Used by Hue server to store metadata. |
| external_postgres_db | Postgres | It's a relational DB where you can store your data. |
| external_pgadmin | pgAdmin | You can use this to access Postgres server running in external_postgres_db container. |
| cassandra | Cassandra | It's a non-relational column-oriented DB where you can store your data. |
| zookeeper | Confluent Zookeper | This container runs zookeeper which keeps track of kafka broker. |
| kafka-broker | Confluent Kafka Broker | This container runs a confluent kafka broker. |
| schema-registry | Confluent Schema Registry | This container runs confluent schema registry which you can use to store schemas. |
| kadmin | Kadmin | This container runs kadmin. You can use this application to produce & consume messages. It supports `AVRO` format data. |
| control-center | Confluent Control Center | This container runs confluent control center. Control center can be used to consume messages, look at broker status & create schemas in schema-registry. |

## Access HDFS
You can access HDFS from Hue or Namenode UI. 
> Note: Hue allows you to access file content on HDFS, however Namenode's UI does not support this. 

You can also access HDFS from inside the containers running hadoop such as `namenode`.

## Access Postgres DB
You can access Postgres server using pgAdmin. You can run SQL queries using the same.

##### Postgres creds
- user: external
- password: external
- db: external

##### pgAdmin creds
- email: pgadmin@xyz.com
- password: external

## Access Kadmin
To access this look at the [Access hadoop ecosystem](#access-hadoop-ecosystem) section. You can create producers and consumers on kadmin. It will ask you for Kafka Host and Kafka Schema Registry Url before creating a producer or consumer. You can set Kafka Host and  Kafka Schema Registry Url to `kafka-broker:29092` and `http://schema-registry:8083` respectively.

## Run hive queries
You can run Hive queries using Hue.
A thrift server runs on the top of hiveserver 2. Hue has been set up to establish a connection with the thrift server, which executes your Hive queries. 

## Run PySpark
Spark is installed in `namenode`. You need to access namenode container & run `spark-submit` command to run spark jobs.

In this cluster You can run Spark in three modes:
|Mode | Command |
|--- |--- |
| Local | spark-submit [python-script-path] |
| [YARN](https://spark.apache.org/docs/latest/running-on-yarn.html) | spark-submit --master yarn --deploy-mode cluster --archives [file_path] --queue default [python-script-path]  |
| [Stand Alone](https://spark.apache.org/docs/latest/spark-standalone.html) | spark-submit --master spark://namenode:7077 --deploy-mode cluster [python-script-path] |

##### Run PySpark in YARN mode
In this mode YARN takes care of scheduling spark job. You must create a compressed file that contains all of the packages if you're using any external packages, such as pandas.

Run the below command to create this compressed file
```sh
conda pack -f -o conda_env.tar.gz
```

The above command will create `conda_env.tar.gz` in the current directory. You can then pass the absolute path of the file in `--archives` flag.

> NOTE: You may choose not to add --archives flag if you're not using any external packages.

##### Run PySpark in zeppeline
For development purpose you can use [Zeppelin](https://zeppelin.apache.org/docs/latest/interpreter/spark.html) to run spark jobs. Select Spark Interpreter while creating a new script in zeppelin. Don't forget to add `%spark.pyspark` at the starting of the block/cell. Keep your spark related code in one block/cell. 
> Note: Zeppeline is configured to run spark jobs in local mode.

##### Schedule PySpark jobs in airflow
You can schedule Spark Jobs from [Airflow](https://airflow.apache.org/docs/apache-airflow/stable/). You need [Spark Provider](https://airflow.apache.org/docs/apache-airflow-providers-apache-spark/stable/index.html) to schedule spark jobs which has already been installed. To run spark jobs in spark stand alone cluster set Host to `namenode` & port to `7077` while creating a spark connection in Airflow.

## Run sqoop
[Sqoop](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html) is installed in hive-server container. Below is a sample command to import data using sqoop.
```sh
sqoop import --connect jdbc:postgresql://external_postgres_db/external --username external --password external --table <your-table-name> --target-dir <dir-in-hdfs> --m 1
```
You can set mapper as per your needs, Since we're in development env I suggest using 1 mapper.

Sqoop is configured to [store DB password](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_saved_jobs_and_passwords) when [sqoop job](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_saved_jobs) is created. It stores all the metadata in `$HOME/.sqoop`.

##### Schedule sqoop jobs in airflow
hive-server container houses an ssh server.
[SSHOperator](https://airflow.apache.org/docs/apache-airflow-providers-ssh/stable/_api/airflow/providers/ssh/operators/ssh/index.html) in Airflow may be used to log into the hive server and run a Sqoop job. To login to hive-server from airflow, set Host to `hive-server`, Username to `root` & Password to container's password while creating a ssh connection in Airflow.

Below is the command to set password in a container.
```sh
passwd root
```

## Run airflow
In order to schedule jobs in Airflow, DAGs must be created.
Your DAG scripts must be kept in the project directory's `/dags` directory. Your scripts will automatically sync with the container, and you will be able to see your DAG via Airflow's user interface.

By default, SequentialExecutor is used to schedule jobs. This executor can only execute 1 task at once. If you want to schedule multiple jobs parallelly then You will have to configure Airflow to use other [executors](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html) such as LocalExecutor.

SequentialExecutor uses SQLite to store metadata. If you want to use other executor such as LocalExecutor, you might need to configure Airflow to use other DBs like Postgres. You can make use of Postgres that comes with this cluster.

##### Airflow creds
| name | value |
|--- |--- |
| username | admin |
| password | admin |
| firstname | admin |
| lastname | admin |
| role | Admin |
| email | admin@gmail.com |

## Create Kafka Topic
You can create kakfka topic either from `CLI` or using `Kafka control center`. You can set the maximum value of replication factor to 1 as this cluster runs only one kafka broker.

##### CLI
To create kafka topic via CLI, you need to access `kafka-broker` container and then run the following command.
```sh
kafka-topics --bootstrap-server kafka-broker:29092 --create --topic <topic-name> --partitions <int> --replication-factor <int>
```

##### Kafka Control Center
This is an UI provided by Confluent. To access this look at the [Access hadoop ecosystem](#access-hadoop-ecosystem) section.

## Create Kafka Producer
You can create kakfka producer either from `CLI` or using `KAdmin`.

### CLI
##### Using kafka-broker container
To create a simple kafka producer via CLI, you need to access `kafka-broker` container and then run the following command.
```sh
kafka-console-producer --broker-list kafka-broker:29092 --topic <topic-name> --producer-property <key>=<value>
```
> Note: The above command creates a producer that sends data without a key.

##### Using schema-registry container
To create an avro producer via CLI, you need to access `schema-registry` container and then run the following command.
```sh
kafka-avro-console-producer \
--broker-list kafka-broker:29092 \
--topic <topic-name>  \
--property schema.registry.url=http://schema-registry:8083 \
--property value.schema='<avro-schema>'
```
> Note: This producer will not create a schema in schema-registry. It directly uses the schema that you've provided in the above command. Above command accepts schema of value.

### Kadmin
You can create a simple producer or avro producer using Kadmin.

## Create Kafka Consumer
You can create kakfka consumer either from `CLI` or using `KAdmin`.

### CLI
##### Using kafka-broker container
To create a simple kafka consumer via CLI, you need to access `kafka-broker` container and then run the following command.
```sh
kafka-console-consumer --bootstrap-server kafka-broker:29092 --topic <topic-name> --from-beginning --formatter kafka.tools.DefaultMessageFormatter --property print.timestamp=true --property print.key=true --property print.value=true
```
> Note: The above command creates a consumer which reads from the beginning.

##### Using schema-registry container
To create an avro consumer via CLI, you need to access `schema-registry` container and then run the following command.
```sh
kafka-avro-console-consumer \
--bootstrap-server kafka-broker:29092 \
--topic <topic-name> \
--from-beginning \
--property schema.registry.url=http://schema-registry:8083
```
> Note: The above command creates a consumer which reads from the beginning.

### Kadmin
You can create a simple consumer or avro consumer using Kadmin.

## Run flume agents
[Flume](https://flume.apache.org/FlumeUserGuide.html) is installed in `namenode`. To configure flume agents you need to configure `flume_config/flume.conf` file in the project directory. To start flume agents you need to access namenode & run the below command.
```sh
flume-ng agent --conf conf --conf-file /opt/flume/conf/flume.conf --name <agent-name> -Dflume.root.logger=INFO,console
```
Above command runs flume in the console.

You can also create a Flume service & manage it as a service too.

## Run queries in cassandra
Access cassandra container & run the below command to start executing cql queries.
```sh
cqlsh
```

## Available Jars
Here is a list of extra jar files available which can be used in "spark".
These jar files are located in `/opt/spark/jars/` in `namenode` container. 
| Group Id | Artifact Id | File Name | Version |
| ---| ---| ---| ---|
| com.sun.jersey | jersey-client | jersey-client-1.19.4.jar | 1.19.4 |
| com.sun.jersey | jersey-bundle | jersey-bundle-1.19.4.jar | 1.19.4 |
| com.datastax.spark | spark-cassandra-connector-assembly_2.12 | spark-cassandra-connector-assembly_2.12-3.2.0.jar | 3.2.0 |
| mysql | mysql-connector-java | mysql-connector-java-5.1.49.jar | 5.1.49 |
| org.apache.spark | spark-sql-kafka-0-10_2.12 | spark-sql-kafka-0-10_2.12-3.2.1.jar | 3.2.1 |
| org.apache.kafka | kafka-clients | kafka-clients-3.2.2.jar | 3.2.2 |
| org.apache.spark | spark-avro_2.12 | spark-avro_2.12-3.2.2.jar | 3.2.2 |
| org.apache.spark | spark-token-provider-kafka-0-10_2.12 | spark-token-provider-kafka-0-10_2.12-3.2.2.jar | 3.2.2 |
| org.apache.commons | commons-pool2 | commons-pool2-2.11.1.jar | 2.11.1 |
| org.apache.avro | avro-mapred | avro-mapred-1.11.1.jar | 1.11.1 |
| org.postgresql | postgresql | postgresql-42.5.0.jar | 42.5.0 |

## Configure hadoop
You can configure resource allocation to each container by modifying `hadoop.env` in the project directory.

##### Configure YARN
- YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___mb: This determines the maximum memory allocation to YARN scheduler. By default it is set to `8GB`. You may increase it if you have more resources to spare. 
- YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___vcores: This determines the maximum number of core allocation to YARN scheduler. By default it is set to `4 cores`. You may increase it if you have more resources to spare.

##### Configure nodemanager
- YARN_CONF_yarn_nodemanager_resource_memory___mb: This determines the maximum memory allocation to nodemanager. By default it is set to `16GB`. I suggest not to decrease it otherwise, the map-reduce jobs might get stuck due unavailability of resources.
- YARN_CONF_yarn_nodemanager_resource_cpu___vcores: This determines the maximum number of core allocation to nodemanager. By default it is set to `8 cores`. I suggest not to decrease it.

##### Configure map reduce
- MAPRED_CONF_mapreduce_map_memory_mb: This determines the maximum memory allocation to a mapper. By default it is set to `4GB`. You may increase it if you have more resources to spare. 
- MAPRED_CONF_mapreduce_reduce_memory_mb: This determines the maximum memory allocation to a reducer. By default it is set to `8GB`. You may increase it if you have more resources to spare. 

## Configure hue
You can configure Hue server by modifying `hue-overrides.ini` in the project directory.

##### Configure hue DB
Hue is configured to use postgres running in `huedb` container. Below is the default config.
```sh
engine=postgresql_psycopg2
host=huedb
port=5432
user=hue
password=hue
name=hue
```

##### Configure hue to run hive
Hue connects to the `hive-server` container using port `10000`. Below is the config for the same
```sh
[beeswax]

  # Host where HiveServer2 is running.
  # If Kerberos security is enabled, use fully-qualified domain name (FQDN).
  hive_server_host=hive-server
  
  # Port where HiveServer2 Thrift server runs on.
  hive_server_port=10000

  thrift_version=7
```

## Configure zeppelin
You can [configure](https://zeppelin.apache.org/docs/0.8.0/setup/operation/configuration.html) zeppelin by modifying `configs/zeppelin-env.sh` & `configs/zeppelin-site.xml` files.

##### Environment variables
Below are variables set in `zeppelin-env.sh` which is used by zeppelin.
| Variable | Value |
|--- |--- |
| JAVA_HOME | /usr/lib/jvm/java-8-openjdk-amd64/ |
| SPARK_MASTER | spark://namenode:7077 |
| ZEPPELIN_PORT | 8082 |
| SPARK_HOME | /opt/spark |
| HADOOP_CONF_DIR | /etc/hadoop |
| PYSPARK_PYTHON | /root/anaconda/bin/python3.9 |
| PYTHONPATH | /root/anaconda/bin/python3.9 |

##### Java properties
Java properties can be configured from `zeppelin-site.xml`. I've modified it's default config to expose the server externally. Below is the modified config.
```sh
<property>
  <name>zeppelin.server.addr</name>
  <value>0.0.0.0</value>
  <description>Server binding address</description>
</property>
```

##### Configure spark interpreter
Follow the below steps
1. click on profile in the top right corner of the screen.
2. click on Interpreter.
3. scroll down until you see `spark` & click on edit.

## Configure airflow
You can configure airflow by modifying `configs/namenode_airflow.cfg` in the project directory.

##### Config variables
Below are variables that I've configured. You can leave other variables as it is.
| Variable | Value |
|--- |--- |
| dags_folder | /root/airflow/dags |
| sql_alchemy_conn | sqlite:////root/airflow/airflow.db |
| [executor](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html) | SequentialExecutor |

You can use other executors such as `LocalExecutor`. To use this executor you need to create a DB instance in a DB server, you can use `external_postgres_db` container for the same. Once the DB is created, set sql_alchemy_conn to postgresql+psycopg2://<username>:<password>@[IP/container-name]:5432/[db-name] & executor to LocalExecutor.

##### Reload airflow
After configuring the variables, you need to initiate a new DB instance & restart airflow server & scheduler. 

Login to `namenode` by running this [command](#access-docker-containers) & run the below command to initiate a DB.
```sh
airflow db init && \
airflow users create \
    --username admin \
    --password admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@gmail.com
```

Run the below command to restart airflow server & scheduler. 
```sh
rm -rf ~/airflow/airflow-scheduler.pid && \
rm -rf ~/airflow/airflow-webserver-monitor.pid && \ 
rm -rf ~/airflow/airflow-webserver.pid && \
airflow webserver -p 3000 -D --workers 1 && \
airflow scheduler -D
```
> No need to run this the next time you start your cluster.

## Configure sqoop
You can configure sqoop by modifying `configs/hive_server/sqoop-site.xml` in the project directory.

##### Java properties
I’ve modified it’s default config so that it could save DB server password in the metastore. Below is the modified config.
```sh
<property>
    <name>sqoop.metastore.client.record.password</name>
    <value>true</value>
    <description>If true, allow saved passwords in the metastore.
    </description>
</property>
```

## Configure ssh server
A ssh server runs on hive-server container. You can configure it by modifying `configs/hive_server/sshd_config.conf` in the project directory. I've configured it to allow password authentication & login as root.

## Build Custom Docker Images
You can customize the images that is used in these docker YAML files. The directory `docker_image_conf` contains the Dockerfiles for creating images. 

## Manage resources
I recommend using a workstation with at least 4 hyper-threaded cores & 8GB RAM to run this cluster. Additionally, I suggest against running any other programmes simultaneously because doing so could lead to resource shortages and other issues when using certain ports.

##### Reduce resource utilization 
1. If you aren't using Hive, I advise starting the `basic cluster`.
2. You can start the cluster without the external_pgadmin container if you do not need to execute SQL queries on Postgres.
3. If you don't need cassandra, launch the cluster without it. 

##### Spark & zeppelin
1. when you run your PySpark code in zeppelin, it starts a spark driver code, this consumes a lot of resources, I recommend running `spark.stop()` & `sc.stop()` in the next block in zeppelin. This will stop the spark driver.
2. If it still hogs resources, you can login to `namenode` & run `zeppelin-daemon.sh stop`. This will stop zeppelin.

## Dependencies
- [Docker](https://docs.docker.com/):
    1. Install Docker on ubuntu: https://docs.docker.com/engine/install/ubuntu/
    2. Install Docker on windows: https://docs.docker.com/desktop/install/windows-install/

[website]: https://mrayonline.web.app
[youtube]: https://www.youtube.com/@mrugankray7623
[linkedin]: https://in.linkedin.com/in/mrugank-ray-543886149
[buy_me_coffee]: https://www.buymeacoffee.com/mrugankray