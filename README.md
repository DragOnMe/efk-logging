# Elasticsearch, Fluentd & Kibana logging on Kubernetes

EFKK


### Prerequisites

* A working kubernetes 1.14.x + with multiple nodes
* Kubectl is required
* Assumption: Hostnames are kube-1, kube-2, kube-3, ..., etc
* Runs without specific storage-class(uses hostPath for persistent volume)


### Installing

This will install the EFKK in kube-logging namespace.

```
$ git clone https://github.com/DragOnMe/efk-logging.git
$ cd efk-logging
$ ./deploy.sh
```


## Test elasticsearch

```bash
$ kubectl run --rm -it --restart=Never --image=alpine alpine-test
If you don't see a command prompt, try pressing enter.
/ # apk add curl
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/5) Installing ca-certificates (20190108-r0)
(2/5) Installing nghttp2-libs (1.35.1-r0)
(3/5) Installing libssh2 (1.8.2-r0)
(4/5) Installing libcurl (7.64.0-r2)
(5/5) Installing curl (7.64.0-r2)
Executing busybox-1.29.3-r10.trigger
Executing ca-certificates-20190108-r0.trigger
OK: 7 MiB in 19 packages
/ # 
/ # curl http://elasticsearch.kube-logging:9200/_cat/health
1560741863 03:24:23 spc.local green 3 3 105 54 0 0 0 0 - 100.0%
```

### Getting list of indices in elasticsearch

```bash
$ kubectl run --rm -it --restart=Never --image=alpine alpine-test
If you don't see a command prompt, try pressing enter.
/ # apk add curl
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/5) Installing ca-certificates (20190108-r0)
(2/5) Installing nghttp2-libs (1.35.1-r0)
(3/5) Installing libssh2 (1.8.2-r0)
(4/5) Installing libcurl (7.64.0-r2)
(5/5) Installing curl (7.64.0-r2)
Executing busybox-1.29.3-r10.trigger
Executing ca-certificates-20190108-r0.trigger
OK: 7 MiB in 19 packages
/ # 
/ # 
/ # curl http://elasticsearch.kube-logging:9200/_cat/indices?v
health status index                        uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   logstash-2019.06.14          romGIxfdRXmjLBxKO97o2w   5   1     354374            0    330.4mb        165.1mb
green  open   logstash-2019.06.10          GfoMWL4hRkmOkaH7YOORrQ   5   1     295589            0    236.4mb        118.1mb
green  open   kibana_sample_data_logs      Jel6ld0FQ967y-zW8ZyOzg   1   0      14005            0     11.5mb         11.5mb
green  open   kibana_sample_data_ecommerce FelvUB38RpqQvNqvFUGtWg   1   0       4675            0      4.8mb          4.8mb
green  open   logstash-2019.06.09          cml31JzXTRW8egY9QxcyiQ   5   1     184876            0    116.7mb         58.4mb
/ # pod "alpine-test" deleted
```

## Teardown

Caution: This will clear the EFKK and all the data on ES.

```bash
$ ./teardown.sh
```

