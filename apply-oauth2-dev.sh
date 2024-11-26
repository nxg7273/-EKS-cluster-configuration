#!/bin/bash
set -e

echo "Applying OAuth2 proxy configurations for bioactives-dev..."

# Create namespace if it doesn't exist
kubectl get namespace traefikee || kubectl create namespace traefikee

# Apply configurations in order
echo "Applying OAuth2 proxy secrets..."
kubectl apply -f kubernetes/traefikee/oauth2-proxy/secrets.yaml

echo "Applying OAuth2 proxy configmap..."
kubectl apply -f kubernetes/traefikee/oauth2-proxy/configmap-secure.yaml

echo "Applying OAuth2 proxy deployment..."
kubectl apply -f kubernetes/traefikee/oauth2-proxy/deployment-dev.yaml

echo "Applying OAuth2 proxy service..."
kubectl apply -f kubernetes/traefikee/oauth2-proxy/service-dev.yaml

echo "Applying OAuth2 middleware..."
kubectl apply -f kubernetes/traefikee/middleware/oauth2-middleware-dev.yaml

echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/oauth2-proxy -n traefikee --timeout=60s

echo "OAuth2 proxy configuration completed successfully!"
