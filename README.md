# minikube Cassandra steps

### install Minikube
https://minikube.sigs.k8s.io/docs/start/

### pre-requisites
 - w/ Powershell running as Administrator
 - Your Windows user added as a member of the `hyper-v administrators` security group

### start Minikube
    minikube start --memory 1024s --cpus=2

### check status of minikube
    minikube kubectl -- get pods -A

### create a Kubernetes "service"
service - A set of pods that perform the same task.

    minikube kubectl -- apply -f cassandra-service.yaml

### create a Kubernetes "StatefulSet"

    minikube kubectl -- apply -f cassandra-minikube_1node.yaml

### validate StatefulSet

    minikube kubectl -- get statefulset cassandra

### nodetool status

    minikube kubectl -- exec -it cassandra-0 -- nodetool status

### port forward

    minikube kubectl -- port-forward service/cassandra 9042:9042

Note that the `port-forward` runs in the foreground.
