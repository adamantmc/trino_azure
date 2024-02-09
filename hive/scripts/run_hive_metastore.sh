sed -i -e 's|storage_account_name|'"${STORAGE_ACCOUNT_NAME}"'|g' /opt/hive_metastore/conf/core-site.xml
sed -i -e 's|storage_account_key|'"${STORAGE_ACCOUNT_KEY}"'|g' /opt/hive_metastore/conf/core-site.xml

export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
/opt/hive_metastore/bin/start-metastore $@
