# Kubernetes Demo API

A simple Node.js API containerized with Docker and deployed to Kubernetes, demonstrating a basic DevOps workflow: build → containerize → push → deploy.

## Tech Stack

- **Node.js / Express** — API server
- **Docker** — containerization
- **Docker Compose** — local development
- **Kubernetes** — orchestration (Deployment + Service)
- **Docker Hub** — image registry

## Project Structure
kubernetes-demo/
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── Dockerfile
├── docker-compose.yaml
├── deploy.sh
├── index.js
├── package.json
└── .dockerignore
## Running Locally with Docker Compose

```bash
docker compose up --build
```

The API will be available at `http://localhost:3000`.

## Building and Pushing the Docker Image

```bash
# Build (handled automatically by docker compose, or manually):
docker build -t kubernetes-demo-api .

# Tag for Docker Hub
docker tag kubernetes-demo-api:latest laibamunir16/kubernetes-demo-api:latest

# Push to Docker Hub
docker push laibamunir16/kubernetes-demo-api:latest
```

Image is publicly available at:
[hub.docker.com/r/laibamunir16/kubernetes-demo-api](https://hub.docker.com/r/laibamunir16/kubernetes-demo-api)

## Deploying to Kubernetes

> Requires a running cluster (e.g. via [minikube](https://minikube.sigs.k8s.io/)).

```bash
# Start local cluster
minikube start --driver=docker

# Apply manifests
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Check status
kubectl get pods
kubectl get services
```

### Accessing the App

Since the Service type is `NodePort`, retrieve the URL with:

```bash
minikube service kubernetes-demo-api-service --url
```

> For cloud deployments (AWS/GCP/Azure), change the Service `type` to `LoadBalancer` in `k8s/service.yaml`.

## Kubernetes Resources

| File | Purpose |
|---|---|
| `k8s/deployment.yaml` | Runs 2 replicas of the API container, sets resource limits, and configures readiness/liveness health checks |
| `k8s/service.yaml` | Exposes the pods on a stable network address inside (and optionally outside) the cluster |

## Health Endpoints

The app exposes two endpoints used by Kubernetes probes:

- `GET /readyz` — readiness check (is the app ready to receive traffic?)
- `GET /healthz` — liveness check (is the app still running correctly?)

## Useful Commands

```bash
# View logs for a pod
kubectl logs <pod-name>

# Scale the deployment
kubectl scale deployment kubernetes-demo-api --replicas=3

# Delete all resources
kubectl delete -f k8s/deployment.yaml -f k8s/service.yaml

# Stop the cluster
minikube stop
```
