CLUSTER_NAME=${CLUSTER_NAME:-Theistareykjarbunga}
ETCD_HOST=10.20.2.4:2379
NETWORK_NAME=${CLUSTER_NAME}_net

docker network create -d overlay $NETWORK_NAME

  echo "Starting new node..."
  docker run -d -p 3306 --net=$NETWORK_NAME -e MYSQL_ALLOW_EMPTY_PASSWORD=1 -e DISCOVERY_SERVICE=$ETCD_HOST -e CLUSTER_NAME=${CLUSTER_NAME} perconalab/percona-xtradb-cluster --wsrep_sst_method=xtrabackup-v2 --wsrep_sst_auth="root:"
echo "Started $(docker ps -l -q)"

# --wsrep_cluster_address="gcomm://$QCOMM"
