#/usr/bin/env bash

kubectl delete -f es_statefulset.yaml 
kubectl delete -f kibana.yaml 
kubectl delete -f es_svc.yaml 
kubectl delete -f fluentd.yaml 
for i in `seq 0 2`; do kubectl delete pvc -n kube-logging data-es-cluster-$i; done
for i in `seq 1 3`; do kubectl delete -f pv$i.yaml; done
for i in `seq 1 5`; do ssh root@kube-$i "hostname && rm -rf /mnt/data/efk??"; done
