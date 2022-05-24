# bigbang-dev

## Infrastrucuture

Single node used for the bigbang quickstart demo. 

Modules controlled by terragrunt create a single node cluster in a private subnet behind a bastion host with a public IP. By default, a single AZ is used. 

Using local terraform state storage. S3 configurations are commented out in /terraform/infrastructure/terragrunt.hcl

## RKE2-Server not Initially Starting - Fix

Flush iptables - Unsure if this is actually an issue. Need to verify. 



## Installing Kubernetes

Aiming for v1.21.10+rke2r2 based on needs of original project

```
cp /etc/rancher/rke2/config.yaml /tmp/config.yaml

/usr/bin/rke2-uninstall.sh

curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.21.10+rke2r2 sh -

mkdir -p /etc/rancher/rke2/

cp /tmp/config.yaml /etc/rancher/rke2

systemctl enable rke2-server

systemctl start rke2-server
```

