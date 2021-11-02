# start minikube
minikube start --memory 3072 --cpus=2

# create a Kubernetes "service"
minikube kubectl -- apply -f cassandra-service.yaml

# create a Kubernetes "StatefulSet"
minikube kubectl -- apply -f cassandra-minikube_1node.yaml

# pause 90 seconds
# Need time to allow the Cassandra node(s) to come up
$notRunning = (minikube kubectl -- get statefulset cassandra | Select-String "0\/")
while($notRunning.length -gt 0)
{
    Write-Output "..."
    # checks whether or not there is a pod not in the "1/1" ready status every 20 seconds
    Start-Sleep -seconds 20
    $notRunning = (minikube kubectl -- get statefulset cassandra | Select-String "0\/")
}

# validate StatefulSet
minikube kubectl -- get statefulset cassandra

Write-Output "The port-forward command keeps this script running in the foreground.  Control-C will exit back to the prompt, but will also stop communication with the Cassandra container."

# port forward
minikube kubectl -- port-forward service/cassandra 9042:9042
