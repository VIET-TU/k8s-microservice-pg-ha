#!/bin/bash
set -e

echo "listen_addresses = '*'" >> /etc/postgresql/14/main/postgresql.conf

cat <<EOF > /etc/postgresql/14/main/pg_hba.conf
local   all             postgres                                peer
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             all                                     peer
# IPv4 local connections:
host    all             all             0.0.0.0/0               scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
host    replication     replicator      0.0.0.0/0               md5
EOF

service postgresql start

sleep 5

export PGPASSWORD="$POSTGRES_PASSWORD"
su - postgres -c "psql -c \"ALTER USER postgres PASSWORD '$POSTGRES_PASSWORD';\""

tail -f /var/log/postgresql/postgresql-14-main.log
