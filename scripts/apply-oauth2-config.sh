#!/bin/bash

# Script to apply OAuth2 configurations in the correct order

set -e

echo "Applying OAuth2 configurations for bioactives-dev environment..."

# Create namespace if it doesn't exist
kubectl create namespace traefikee --dry-run=client -o yaml | kubectl apply -f -

# Apply configurations in order
echo "1. Applying OAuth2 proxy configurations..."
kubectl apply -f kubernetes/traefikee/oauth2-proxy/configmap.yaml
kubectl apply -f kubernetes/traefikee/oauth2-proxy/deployment.yaml

echo "2. Applying middleware configuration..."
kubectl apply -f kubernetes/traefikee/middleware/oauth2-middleware.yaml

echo "3. Verifying deployments..."
kubectl rollout status deployment/oauth2-proxy -n traefikee

echo "4. Running verification tests..."
kubectl apply -f kubernetes/traefikee/tests/oauth2-verify.yaml
echo "Waiting for test pod to start..."
sleep 10
kubectl logs -f oauth2-verify -n traefikee

echo "Setup complete! Check the logs above for verification results."
