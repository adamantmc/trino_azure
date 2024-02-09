# Hive Metastore Dockerfile

Dockerfile which builds an image with a standalone Hive Metastore configured to work with an Azure Data Lake Storage (gen2 storage account).

Credentials are passed in runtime via environmental values (see below in the [Running](#running) section).

## Building

To build the Hive Metastore standalone image, simply run `docker build . hive_metastore_standalone:latest`.

## Running

The Hive Metastore can be started via:

```bash
docker run -d -e STORAGE_ACCOUNT_NAME={YOUR_STORAGE_ACCOUNT_NAME} -e STORAGE_ACCOUNT_KEY="{YOUR_STORAGE_ACCOUNT_KEY}" hive_metastore_standalone:latest
```

This will start the Hive Metastore, which listens to port 9083 (`thrift://localhost:9083` for access via Thrift - to access it outside the Docker network, either expose the 9083 port or run using `--network=host`).

## Process

Deploying a Hive Metastore as a standalone requires two things:
1. The standalone Hive Metastore (https://downloads.apache.org/hive/hive-standalone-metastore-3.0.0/)
2. Hadoop

Hadoop is a Hive requirement - among others, it contains the Azure connectors.

The process goes as follows:
1. Download and extract Hive Standalone Metastore and Hadoop (version matching documented at https://hive.apache.org/general/downloads/)
2. Configuring Hive Metastore database - we use Derby which is embedded within Hive (we could also use an external RDMBS service)
    1. Configured via the [hive/conf/metastore-site.xml](conf/metastore-site.xml) file, which is copied over at `/opt/hive_metastore/conf/metastore-site.xml`
3. Setting `HADOOP_HOME` (env var) to the root of the Hadoop installation (`/opt/hadoop`)
4. Setting `HADOOP_OPTIONAL_TOOLS` (env var) to `hadoop-azure` (so as to load the optional Azure libs that connect to the storage account) 
5. Initializing the Hive Metastore database ([hive/scripts/init_hive_metastore.sh](scripts/init_hive_metastore.sh))
6. Filling hive/conf/core-site.xml with the storage account name and key and moving it under `/opt/hive_metastore/conf/core-site.xml`

The last step happens on runtime, where credentials are passed via env vars. The dockerfile specifies that the [hive/scripts/run_hive_metastore.sh](scripts/run_hive_metastore.sh) file is called when the container starts, which fills the core-site.xml with the required credentials.

The Hive Metastore is then started by running `/opt/hive_metastore/bin/start-metastore`.

Jave is required as well - the `JAVA_HOME` env var is set within the scripts (init_hive_metastore.sh and run_hive_metastore.sh).

## Acknowledgements

This work is based on the very clean and comprehensive scripts at https://github.com/naushadh/hive-metastore.

