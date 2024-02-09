export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
/opt/hive_metastore/bin/schematool -dbType derby -initSchema --verbose
