#!/bin/bash
echo installing k8s api and client...

kubectl create ns techtorialcademy
kubectl apply -f ./api.yaml

echo installing k8s api client pod...
kubectl run api-client \
  --namespace=techtorialcademy \
  --image=ethantechtorial/api-generator \
  --env="API_URL=http://api-service:5000" \
  --image-pull-policy IfNotPresent

echo "waiting for api and client to start (30-60secs)..."
kubectl wait --for=condition=available --timeout=300s deployment/api -n techtorialcademy
kubectl wait --for=condition=ready --timeout=300s pod/api-client -n techtorialcademy

kubectl get all -n techtorialcademy

echo k8s api and client install finished!
