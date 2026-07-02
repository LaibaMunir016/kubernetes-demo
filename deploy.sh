set -e

NAME="kubernetes-demo-api"
USERNAME="laibamunir16"
IMAGE="$USERNAME/$NAME:latest"

echo "building docker image"
docker build -t $IMAGE .

echo "pushing image to dockerhub"
docker push $IMAGE

echo "Applying kubernetes manifest"
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "getting pods"
kubectl get pods

kubectl get services
kubestl get service $Name-service