#/usr/bin/env bash

kubectl apply -f es_svc.yaml 
for i in `seq 1 3`; do kubectl create -f pv$i.yaml; done
kubectl apply -f es_statefulset.yaml 
kubectl apply -f fluentd.yaml 
kubectl apply -f kibana.yaml 
kubectl rollout status -n kube-logging statefulset es-cluster 
