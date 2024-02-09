# Trino Dockerfile

Dockerfile which builds an image with a standalone Trino server.

## Building

To build the Trino Server standalone image, simply run `docker build . trino_server_tandalone:latest`.

## Running

The Trino server can be started via:

```bash
docker run -d -e HIVE_URL={THRIFT_URL_TO_HIVE_METASTORE} -e STORAGE_ACCOUNT_NAME={YOUR_STORAGE_ACCOUNT_NAME} -e STORAGE_ACCOUNT_KEY="{YOUR_STORAGE_ACCOUNT_KEY}" trino_server_standalone:latest
```

This will start the Trino Server as well as a UI accessible at `http://localhost:8080/` (to access it, either expose the 8080 portor run using `--network=host`).

## Process

Deploying Trino as a standalone is documented at https://trino.io/docs/current/installation/deployment.html.

This image simply installs Java and adds the `abfs` catalog. The `abfs` catalog contains the URL to the Hive Metastore as well as the Azure Storage Account name and key (which are passed on runtime).
