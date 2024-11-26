# EKS Cluster Configuration with Microsoft Entra ID Authentication

This repository contains the Kubernetes configurations for implementing Microsoft Entra ID (Azure AD) authentication for applications running on EKS using Traefik and OAuth2 Proxy.

## Components

- **OAuth2 Proxy**: Handles authentication flow with Microsoft Entra ID
- **Traefik Middleware**: Integrates OAuth2 authentication with Traefik IngressRoutes
- **Kubernetes Resources**: Deployments, ConfigMaps, and Secrets for managing the authentication setup

## Directory Structure

```
kubernetes/
└── traefikee/
    ├── oauth2-proxy/
    │   ├── deployment.yaml    # OAuth2 proxy deployment configuration
    │   ├── configmap.yaml     # OAuth2 proxy configuration
    │   └── secret.yaml        # Sensitive configuration values
    └── middleware/
        └── oauth2-middleware.yaml  # Traefik middleware configuration
```

## Configuration

### Prerequisites

1. Microsoft Entra ID Application Registration
   - Register an application in Microsoft Entra ID
   - Configure redirect URIs: `https://bioactives-dev.iff.com/oauth2/callback`
   - Note down:
     - Client ID
     - Client Secret
     - Tenant ID

2. EKS Cluster Access
   - Ensure proper AWS credentials
   - Configure `kubectl` context

### Deployment

1. Update the secret values in `kubernetes/traefikee/oauth2-proxy/secret.yaml`
2. Apply the configurations:
   ```bash
   kubectl apply -f kubernetes/traefikee/oauth2-proxy/
   kubectl apply -f kubernetes/traefikee/middleware/
   ```

## Authentication Flow

1. User accesses protected application
2. Traefik middleware redirects to OAuth2 proxy
3. OAuth2 proxy initiates Microsoft Entra ID authentication
4. User authenticates with Microsoft credentials
5. OAuth2 proxy validates tokens and allows access
6. Traefik forwards request to application

## Maintenance

- Monitor OAuth2 proxy logs for authentication issues
- Regularly rotate client secrets
- Update configurations when adding new protected applications
