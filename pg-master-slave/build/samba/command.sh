echo "smbuser" | docker secret create smbuser -
echo "1234567" | docker secret create smbpassword -
kubectl create secret generic cifs-credentials  --from-literal=username=postgres  --from-literal=password=postgres
sudo mount -t cifs //192.168.72.103/data /mnt -o username=postgres,password=postgres

sudo mount -t cifs //192.168.72.103/postgres-2 /postgres-2 -o username=postgres,password=postgres,vers=3.0

helm repo add csi-driver-smb https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts
helm install csi-driver-smb csi-driver-smb/csi-driver-smb --namespace kube-system --version v1.15.0


docker service create \
  --name samba \
  --restart-condition any \
  --restart-max-attempts 10 \
  --restart-delay 10s \
  viettu123/samba

docker stack deploy -c docker-compose.yml your_stack_name

