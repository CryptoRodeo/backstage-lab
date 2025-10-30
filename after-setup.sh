#!/bin/bash
set -e

# ArgoCD
ARGOCD_SERVER_PORT=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.ports[0].nodePort}')
ARGOCD_ADMIN_CREDS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
ARGOCD_SA_TOKEN=$(kubectl get secret backstage-tekton-token -n backstage-tekton-pipelines -o jsonpath='{.data.token}' | base64 -d)

# Tekton
TEKTON_SA_TOKEN=$(kubectl get secret backstage-tekton-token -n backstage-tekton-pipelines -o jsonpath='{.data.token}' | base64 -d)

# Other
SERVICE_PORTS=$(kubectl get svc -A | grep -e 'jenkins.*' -e 'open-webui.*' -e 'ollama.*' | tr -s ' ' | cut -d ' ' -f 2,6 | column -s ' ' -t)
echo "------------------------------"
echo "Backstage Lab 🧪 - After Setup"
echo "------------------------------"
echo "🖥️ ArgoCD Server port ${ARGOCD_SERVER_PORT:-Not Found}"
echo
echo "🔓 ArgoCD Admin creds"
echo "Username: admin"
echo "Password: ${ARGOCD_ADMIN_CREDS:-Not Found}"
echo
echo "🔄 ArgoCD Service Account"
echo "Name: backstage-rollouts"
echo "🪙 Token"
echo
echo "${ARGOCD_SA_TOKEN:-Not Found}"
echo
echo "⚓ Service Ports"
echo "${SERVICE_PORTS:-Not Found}"
echo
echo "⚗️ Tekton Service Account:"
echo "Name: backstage-tekton"
echo "🪙 Token"
echo
echo "${TEKTON_SA_TOKEN:-Not Found}"
echo
echo "------------------------------"
