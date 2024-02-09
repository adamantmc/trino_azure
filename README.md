# Trino on Azure Data Lake

This repository contains dockerfiles that setup Trino and a standalone Hive Metastore in order to support Azure Data Lake (gen2 storage account) queries.

## Quickstart

The `docker-compose.yml` file builds and sets up both Trino and the Hive Metastore.

### Prerequisites
The `credentials.env` file must be filled the name and the key of the storage account that we're going to query. 

### Running
We can start both Trino and the Hive Metastore via:

```bash
docker compose up -d --env-file ./credentials.env
```

The Trino UI can be accessed via `localhost:8080` (using the `admin` username and no password).

### Usage

We can use the [Trino CLI](https://trino.io/docs/current/client/cli.html) to access Trino. 

Note: since Trino's 8080 port is exposed in the dockerfile, we don't need to pass anything in the Trino executable.

The catalog configured for Azure access is named `abfs` ([abfs.properties](./trino/etc/catalog/abfs.properties)).

## Details

More information about the deployment of a standalone Hive Metastore and Trino can be found in the [Standalone Hive Metastore](./hive/README.md) and [Standalone Trino](./trino/README.md) READMEs respectively.
