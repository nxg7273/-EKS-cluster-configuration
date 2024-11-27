# EKS Cluster Configuration

## OAuth2 Authentication Setup

This repository contains the Kubernetes configurations for OAuth2 authentication using Microsoft Entra ID in the bioactives-dev environment.

### Directory Structure
```
kubernetes/traefikee/
├── oauth2-proxy/
│   ├── configmap.yaml      # OAuth2 proxy configuration
│   ├── deployment.yaml     # OAuth2 proxy deployment
│   └── secret.yaml         # Secret template (values managed via kubectl)
├── middleware/
│   └── oauth2-middleware.yaml  # Traefik forward auth configuration
└── tests/
    └── oauth2-verify.yaml      # Verification test pod
```

### Setup Instructions

1. Follow the instructions in `docs/SECRETS.md` to set up required secrets
2. Apply the configurations:
```bash
kubectl apply -f kubernetes/traefikee/oauth2-proxy/
kubectl apply -f kubernetes/traefikee/middleware/
```

3. Verify the setup using the test pod:
```bash
kubectl apply -f kubernetes/traefikee/tests/oauth2-verify.yaml
kubectl logs -f oauth2-verify -n traefikee
```

### Security Notes
- All sensitive information is managed via Kubernetes secrets
- Environment-specific values are configured through environment variables
- Regular secret rotation is recommended
- Refer to `docs/SECRETS.md` for detailed security guidelines
