#!/bin/bash
set -e

echo "Deploying OAuth2 proxy configuration for bioactives-dev environment..."

# Create namespace if it doesn't exist
kubectl get namespace traefikee || kubectl create namespace traefikee

# Apply the configuration
kubectl apply -f kubernetes/traefikee/oauth2-proxy/bioactives-dev-config.yaml

echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/oauth2-proxy-dev -n traefikee --timeout=60s

echo "OAuth2 proxy configuration for bioactives-dev has been deployed successfully!"

# Display pod status
echo "Checking pod status..."
kubectl get pods -n traefikee -l app=oauth2-proxy-dev

# Display service status
echo "Checking service status..."
kubectl get service oauth2-proxy-dev -n traefikee
