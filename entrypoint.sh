#!/bin/bash
set -e

if [ -n "${CLUSTER_CONFIG}" ]; then

  printf "Applying cluster configuration from CLUSTER_CONFIG:\n"

  while read -r line
  do
    printf "$line\n" >> /tmp/nodes.tmp
  done <<< "$CLUSTER_CONFIG"

  while read -r line
  do
    eval echo $line
    eval echo $line >> nodes.conf
  done < /tmp/nodes.tmp
  
fi

if [ -n "${REDIS_CONFIG}" ]; then

  printf "Applying redis configuration from REDIS_CONFIG:\n"

  while read -r line
  do
    printf "$line\n" >> /tmp/redis.tmp
  done <<< "$REDIS_CONFIG"

  while read -r line
  do
    eval echo $line
    eval echo $line >> /etc/redis.conf
  done < /tmp/redis.tmp

  REDIS_CONFIG_FILE=/etc/redis.conf
fi

if [ "$1" = 'redis-server' ]; then
  chown -R redis .
  shift
  exec gosu redis redis-server $REDIS_CONFIG_FILE "$@"
fi

exec "$@"