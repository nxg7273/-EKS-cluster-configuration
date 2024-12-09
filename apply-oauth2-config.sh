#!/bin/bash
set -e

# Check for required environment variables
if [ -z "$OAUTH2_CLIENT_SECRET" ]; then
    echo "Error: OAUTH2_CLIENT_SECRET environment variable is required"
    exit 1
fi

# Generate secure cookie secret
COOKIE_SECRET=$(openssl rand -base64 32 | tr -- '+/' '-_')

# Create base64 encoded secrets
COOKIE_SECRET_BASE64=$(echo -n "$COOKIE_SECRET" | base64)
CLIENT_SECRET_BASE64=$(echo -n "$OAUTH2_CLIENT_SECRET" | base64)

# Replace placeholders in secrets.yaml
sed -i "s|\${COOKIE_SECRET}|$COOKIE_SECRET_BASE64|" kubernetes/traefikee/oauth2-proxy/secrets.yaml
sed -i "s|\${CLIENT_SECRET}|$CLIENT_SECRET_BASE64|" kubernetes/traefikee/oauth2-proxy/secrets.yaml

echo "Configuration files prepared successfully"
