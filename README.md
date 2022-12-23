# Hi there, I'm [Mrugank][linkedin] 👋 

[![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UC_o2rxaj5w_CAl5y_V1nqNg?logo=youtube&logoColor=red&style=for-the-badge)][youtube] [![My Website](https://img.shields.io/website?style=for-the-badge&url=https%3A%2F%2Fmrayonline.web.app%2F)][website] [![LinkedIn](https://img.shields.io/website?color=blue&label=linkedin&logo=linkedin&logoColor=blue&style=for-the-badge&up_color=green&up_message=mrugank%20ray&url=https%3A%2F%2Fmrayonline.web.app%2F)][linkedin] [![Buy me coffee](https://img.shields.io/website?label=Buy%20Me%20coffee&style=for-the-badge&up_color=orange&up_message=mrugank%20ray&url=https%3A%2F%2Fwww.buymeacoffee.com%2Fmrugankray)][buy_me_coffee]

# Docker cluster
This project will create a docker cluster with Hadoop, HDFS, Hive, PySpark, Sqoop, Airflow, Flume, Postgres, Cassandra, Hue and Zepplin.

## Quick Start
To start the cluster run the following command from the project directory.
```
sudo docker-compose -f docker-compose.yaml up
```

## Access Hadoop Ecosystem
All hadoop technologies or frameworks are exposed to the Host. You can access these using the following urls.
1. Namenode UI: http://localhost:9870/dfshealth.html#tab-overview
2. Namenode(IPC port): http://localhost:9000
3. History server: http://localhost:8188/applicationhistory
4. Datanode: http://localhost:9864/
5. Nodemanager: http://localhost:8042/node
6. Resource manager: http://localhost:8088/
7. Hue: http://localhost:8888
8. Spark Master UI: http://localhost:8080
9. Spark Slave UI: http://localhost:8081
10. Spark Driver UI: http://localhost:4040(accessible only after a driver is started)
11. Zeppelin UI: http://localhost:8082
12. Airflow UI: http://localhost:3000

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

### Access docker containers
You can access a container by running this command 
```sh
sudo docker exec -it <container-name> /bin/bash
```
If this does not work replace `/bin/bash` with `/bin/sh`

### Access HDFS
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

### Run Hive Queries
You can run Hive queries using Hue.
A thrift server runs on the top of hiveserver 2. Hue has been set up to establish a connection with the thrift server, which executes your Hive queries. 

### Run PySpark
Spark is installed in `namenode`. You need to access namenode container & run `spark-submit` command to run spark jobs.

In this cluster You can run Spark in three modes:
|Mode | Command |
|--- |--- |
| Local | spark-submit [python-script-path] |
| [YARN](https://spark.apache.org/docs/latest/running-on-yarn.html) | spark-submit --master yarn --deploy-mode cluster [python-script-path]  |
| [Stand Alone](https://spark.apache.org/docs/latest/spark-standalone.html) | spark-submit --master spark://namenode:7077 --deploy-mode cluster [python-script-path] |

##### Run PySpark in zeppeline
For development purpose you can use [Zeppelin](https://zeppelin.apache.org/docs/latest/interpreter/spark.html) to run spark jobs. Select Spark Interpreter while creating a new script in zeppelin. Don't forget to add `%spark.pyspark` at the starting of the block/cell. Keep your spark related code in one block/cell. 
> Note: Zeppeline is configured to run spark jobs in local mode.

##### Schedule PySpark jobs in Airflow
You can schedule Spark Jobs from [Airflow](https://airflow.apache.org/docs/apache-airflow/stable/). You need [Spark Provider](https://airflow.apache.org/docs/apache-airflow-providers-apache-spark/stable/index.html) to schedule spark jobs which has already been installed. To run spark jobs in spark stand alone cluster set Host to `namenode` & port to `7077` while creating a spark connection in Airflow.

### Run Sqoop
[Sqoop](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html) is installed in hive-server container. Below is a sample command to import data using sqoop.
```sh
sqoop import --connect jdbc:postgresql://external_postgres_db/external --username external --password external --table <your-table-name> --target-dir <dir-in-hdfs> --m 1
```
You can set mapper as per your needs, Since we're in development env I suggest using 1 mapper.

Sqoop is configured to [store DB password](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_saved_jobs_and_passwords) when [sqoop job](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_saved_jobs) is created. It stores all the metadata in `$HOME/.sqoop`.

##### Schedule Sqoop jobs in Airflow
hive-server container houses an ssh server.
[SSHOperator](https://airflow.apache.org/docs/apache-airflow-providers-ssh/stable/_api/airflow/providers/ssh/operators/ssh/index.html) in Airflow may be used to log into the hive server and run a Sqoop job. To login to hive-server from airflow, set Host to `hive-server`, Username to `root` & Password to container's password while creating a ssh connection in Airflow.

Below is the command to set password in a container.
```sh
passwd root
```

## Run Airflow
In order to schedule jobs in Airflow, DAGs must be created.
Your DAG scripts must be kept in the project directory's `/dags` directory. Your scripts will automatically sync with the container, and you will be able to see your DAG via Airflow's user interface.

By default, SequentialExecutor is used to schedule jobs. This executor can only execute 1 task at once. If you want to schedule multiple jobs parallelly then You will have to configure Airflow to use other [executors](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html) such as LocalExecutor.

SequentialExecutor uses SQLite to store metadata. If you want to use other executor such as LocalExecutor, you might need to configure Airflow to use other DBs like Postgres. You can make use of Postgres that comes with this cluster.

##### Airflow creds
- username: admin
- password: admin
- firstname: admin
- lastname: admin
- role: Admin
- email: admin@gmail.com

## Run Flume Agents
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

## Configure Hadoop
You can configure resource allocation to each container by modifying `hadoop.env` in the project directory.

##### Configure YARN
- YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___mb: This determines the maximum memory allocation to YARN scheduler. By default it is set to `8GB`. You may increase it if you have more resources to spare. 
- YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___vcores: This determines the maximum number of core allocation to YARN scheduler. By default it is set to `4 cores`. You may increase it if you have more resources to spare.

##### Configure Nodemanager
- YARN_CONF_yarn_nodemanager_resource_memory___mb: This determines the maximum memory allocation to nodemanager. By default it is set to `16GB`. I suggest not to decrease it otherwise, the map-reduce jobs might get stuck due unavailability of resources.
- YARN_CONF_yarn_nodemanager_resource_cpu___vcores: This determines the maximum number of core allocation to nodemanager. By default it is set to `8 cores`. I suggest not to decrease it.

##### Configure Map Reduce
- MAPRED_CONF_mapreduce_map_memory_mb: This determines the maximum memory allocation to a mapper. By default it is set to `4GB`. You may increase it if you have more resources to spare. 
- MAPRED_CONF_mapreduce_reduce_memory_mb: This determines the maximum memory allocation to a reducer. By default it is set to `8GB`. You may increase it if you have more resources to spare. 

## Configure Hue
You can configure Hue server by modifying `hue-overrides.ini` in the project directory.

##### Configure Hue DB
Hue is configured to use postgres running in `huedb` container. Below is the default config.
```sh
engine=postgresql_psycopg2
host=huedb
port=5432
user=hue
password=hue
name=hue
```

##### Configure Hue to run Hive
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

## Configure Zeppelin
You can [configure](https://zeppelin.apache.org/docs/0.8.0/setup/operation/configuration.html) zeppelin by modifying `configs/zeppelin-env.sh` & `configs/zeppelin-site.xml` files.

##### Environment Variables
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

##### Configure Spark Interpreter
Follow the below steps
1. click on profile in the top right corner of the screen.
2. click on Interpreter.
3. scroll down until you see `spark` & click on edit.

## Configure Airflow
You can configure airflow by modifying `configs/namenode_airflow.cfg` in the project directory.

##### Config Variables
Below are variables that I've configured. You can leave other variables as it is.
| Variable | Value |
|--- |--- |
| dags_folder | /root/airflow/dags |
| sql_alchemy_conn | sqlite:////root/airflow/airflow.db |
| [executor](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html) | SequentialExecutor |

You can use other executors such as `LocalExecutor`. To use this executor you need to create a DB in a DB server, you can use the postgres server that runs in `external_postgres_db` container. Once the DB is created, set sql_alchemy_conn to postgresql+psycopg2://<username>:<password>@<IP/container-name>:5432/<db-name> & executor to LocalExecutor.

## Configure Sqoop
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

## Manage resources
I recommend using a workstation with at least 4 hyper-threaded cores & 8GB RAM to run this cluster. Additionally, I suggest against running any other programmes simultaneously because doing so could lead to resource shortages and other issues when using certain ports.

##### Reduce resource utilization 
1. If you aren't using Hive, I advise starting cluster without hue and huedb.
Simply comment them out in "docker-compose.yaml" before launching the cluster.
2. You can start the cluster without the external_pgadmin container if you do not need to execute SQL queries on Postgres.
3. If you don't need cassandra, launch the cluster without it. 

###### Spark & Zeppelin
1. when you run your PySpark code in zeppelin, it starts a spark driver code, this consumes a lot of resources, I recommend running `spark.stop()` & `sc.stop()` in the next block in zeppelin. This will stop the spark driver.
2. If it still hogs resources, you can login to `namenode` & run `zeppelin-daemon.sh stop`. This will stop zeppelin.

[website]: https://mrayonline.web.app
[youtube]: https://www.youtube.com/@mrugankray7623
[linkedin]: https://in.linkedin.com/in/mrugank-ray-543886149
[buy_me_coffee]: https://www.buymeacoffee.com/mrugankray