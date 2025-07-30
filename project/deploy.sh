#!/bin/bash

echo "Pulling latest code from GitHub..."
git pull origin main

echo "Applying Kubernetes manifests..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo " Waiting for pod to be ready..."
kubectl wait --for=condition=ready pod -l app=patient-api --timeout=60s

echo "Starting port-forward to access app at http://localhost:8080"
kubectl port-forward service/patient-api-service 8080:80
