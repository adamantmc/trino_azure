export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
sed -i -e 's|storage_account_name|'"${STORAGE_ACCOUNT_NAME}"'|g' /opt/trino-server/etc/catalog/abfs.properties
sed -i -e 's|storage_account_key|'"${STORAGE_ACCOUNT_KEY}"'|g' /opt/trino-server/etc/catalog/abfs.properties
sed -i -e 's|hive_url|'"${HIVE_URL}"'|g' /opt/trino-server/etc/catalog/abfs.properties

export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
python3 /opt/trino-server/bin/launcher.py run
