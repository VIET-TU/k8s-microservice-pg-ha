docker build -t my-postgres:14 . --no-cache
docker run --name my-postgres-container -e POSTGRES_PASSWORD=postgres -dp 5432:5432 my-postgres:14
psql -h localhost -p 5432 -U postgres

    sudo -i -u postgres psql postgres
     kubectl delete pod/postgres-0 --grace-period=0 --force

PGPASSWORD="postgres" psql -h postgres-0.postgres.default.svc.cluster.local -p 5432 -U postgres
PGPASSWORD="postgres" psql -h service/pgpool -p 5432 -U postgres



CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);


INSERT INTO users (name) VALUES ('administrator'); INSERT INTO users (name) VALUES ('elroy');

select * from users;

show pool_nodes;

$ sudo -i -u postgres psql postgres -c "SELECT * FROM pg_replication_slots
vi postgres-config.yaml
vi pgpool-config.yaml
vi postgres-pv.yaml
vi postgres-pvc.yaml
vi postgres-statefulset.yaml
vi postgres-services.yaml
vi pgpool-deployment.yaml


kubectl apply -f postgres-config.yaml
kubectl apply -f pgpool-config.yaml
kubectl apply -f postgres-pv.yaml
kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres-statefulset.yaml
kubectl apply -f postgres-services.yaml
kubectl apply -f pgpool-deployment.yaml

# https://chatgpt.com/share/4561a5a6-f25c-4143-bc7a-4617d7fc11a0

volumeMounts:
    - name: pvc
    mountPath: /var/lib/postgresql/14/main
    - name: config
    mountPath: /etc/postgresql/14/main/postgresql.conf
    subPath: postgresql.conf
    - name: config
    mountPath: /etc/postgresql/14/main/pg_hba.conf
    subPath: pg_hba.conf
    - name: scripts
    mountPath: /scripts

 kubectl logs pod/postgres-0 -c init-script-permissions