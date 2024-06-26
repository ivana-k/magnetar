# docker ps -aq | xargs docker stop | xargs docker rm

export STAR_HOSTNAME=star
export STAR_PORT=11000
export STAR_HTTP_PORT=7777
export MAGNETAR_HOSTNAME=magnetar
export MAGNETAR_PORT=5000
export KUIPER_HOSTNAME=kuiper
export KUIPER_PORT=9001
export OORT_HOSTNAME=oort
export OORT_PORT=8000
export NATS_HOSTNAME=nats
export NATS_PORT=4222
export ETCD_HOSTNAME=etcd
export ETCD_PORT=2379
export AGENT_QUEUE_HOSTNAME=agent_queue
export AGENT_QUEUE_PORT=50052
export IAM_HOSTNAME=apollo
export IAM_PORT=8002

export NODES_NUM=2
export REGISTRATION_REQ_TIMEOUT_MILLISECONDS=1000
export MAX_REGISTRATION_RETRIES=5

export STAR_PORT_END=$(($STAR_PORT + $NODES_NUM - 1))

# port range for multiple star instances
# todo: each instance should have a dedicated volume
# we probably won't be able to use docker-compose anymore
# since it doesn't support this feature
if [ -z "$STAR_PORT" ]; then
  echo "$STAR_PORT is not set. Please set it and try again."
  exit 1
fi
if [ -z "$NODES_NUM" ]; then
  echo "$NODES_NUM is not set. Please set it and try again."
  exit 1
fi


export REGISTRATION_SUBJECT="register"
export REGISTRATION_REQ_TIMEOUT_MILLISECONDS=1000
export MAX_REGISTRATION_RETRIES=5

export NODE_ID_DIR_PATH="/etc/c12s"
export NODE_ID_FILE_NAME="nodeid"

export NEO4J_HOSTNAME=neo4j
export NEO4J_BOLT_PORT=7687
export NEO4J_HTTP_PORT=7474
export NEO4J_AUTH_ENABLED=false
export NEO4J_DBNAME=neo4j
export NEO4J_apoc_export_file_enabled=true
export NEO4J_apoc_import_file_enabled=true
export NEO4J_apoc_import_file_use__neo4j__config=true
export NEO4J_PLUGINS="[\"apoc\"]"

docker compose build
docker-compose up --scale star=${NODES_NUM}
