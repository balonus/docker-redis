# docker-redis

This redis image allows to pass redis configuration files contents via environment variables (in 12-factor way).

Supported variables:

- REDIS_CONFIG - if present will be saved into /etc/redis.conf that will be passed to redis-server command
- CLUSTER_CONFIG - if present will be saved into /data/nodes.conf

## How to run it?

```bash
docker run balon/redis:3.0.7 redis-server
```

This image includes EXPOSE 6379 (the redis default port), so standard container linking will make it automatically available to the linked containers.

## How to pass options via command line?

```bash
docker run balon/redis:3.0.7 redis-server --port 6000
```

This time redis will bind to custom port: 6000.
 
## How to pass options via environment variable?

```bash
docker run -e "REDIS_CONFIG=port\t7000\nsave\t\"\"" balon/redis:3.0.7 redis-server
```

or

```bash
docker run -e "REDIS_CONFIG=\
port\t7000\n\
save\t\"\"" \
balon/redis:3.0.7 redis-server
```

This time redis will bind to custom port: 7000 and have turned off snapshoting.

## How to pass clustering options via environment variable?

In similar way to REDIS_CONFIG there can be also passed contents of nodes.conf file which defines Redis 3.0 Cluster topology.
