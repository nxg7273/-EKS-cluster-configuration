# Microsoft Entra ID Integration for Bioactives Applications

This PR implements OAuth2 authentication using Microsoft Entra ID for all applications under bioactives-dev.iff.com.

## Changes
- Add OAuth2 proxy deployment configuration with Microsoft Entra ID provider settings
- Configure Traefik middleware for authentication integration
- Add ConfigMap with OAuth2 proxy settings
- Add secret template for sensitive configuration
- Add comprehensive documentation in README.md

## Implementation Details
- Uses oauth2-proxy with Microsoft Entra ID provider
- Implements secure cookie handling and session management
- Configures Traefik middleware for authentication flow
- Sets up proper header forwarding for authenticated requests

## Required Actions Before Deployment
1. Register application in Microsoft Entra ID
2. Update secret.yaml with:
   - Client ID
   - Client Secret
   - Tenant ID
   - Generate 32-character cookie secret

## Testing Instructions
1. Apply configurations:
   ```bash
   kubectl apply -f kubernetes/traefikee/oauth2-proxy/
   kubectl apply -f kubernetes/traefikee/middleware/
   ```
2. Access https://bioactives-dev.iff.com
3. Verify Microsoft Entra ID login flow
4. Confirm successful authentication and access

Link to Devin run: https://preview.devin.ai/devin/9af4971ccbe949599376872d50700fc1

