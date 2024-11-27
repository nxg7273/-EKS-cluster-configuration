# Setting up OAuth2 Secrets for Bioactives Dev Environment

## Prerequisites
- Access to Microsoft Entra ID portal
- kubectl access to the cluster
- Proper permissions in the traefikee namespace

## Setup Instructions

1. Generate a secure 32-character cookie secret:
```bash
openssl rand -base64 32 | tr -- '+/' '-_'
```

2. Create the Kubernetes secret using kubectl (replace placeholders with actual values):
```bash
kubectl create secret generic oauth2-proxy-secret -n traefikee \
  --from-literal=OAUTH2_PROXY_CLIENT_ID="<CLIENT_ID>" \
  --from-literal=OAUTH2_PROXY_CLIENT_SECRET="<CLIENT_SECRET>" \
  --from-literal=OAUTH2_PROXY_COOKIE_SECRET="<GENERATED_COOKIE_SECRET>" \
  --from-literal=OAUTH2_PROXY_AZURE_TENANT="<TENANT_ID>"
```

3. Verify the secret:
```bash
kubectl get secret oauth2-proxy-secret -n traefikee
```

## Security Notes
- Never commit actual secret values to the repository
- Rotate secrets periodically following security best practices
- Ensure proper RBAC is configured for secret access
- Store actual secret values in a secure password manager or vault
