#!/bin/bash
yum update -y
yum install -y python3
yum install -y git
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl enable docker.service
systemctl start docker.service
curl -LO https://dl.k8s.io/release/v1.23.5/bin/linux/amd64/kubectl -o kubectl
chmod +x kubectl && mv kubectl /usr/bin/kubectl
ln -s /usr/bin/kubectl /usr/bin/k
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
mv kustomize /usr/bin/kustomize
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
cp /usr/local/bin/helm /usr/bin/helm 
curl -LO https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64
mv sops-v3.7.3.linux.amd64 /usr/bin/sops
chmod 755 /usr/bin/sops
curl -LO https://github.com/vmware-tanzu/velero/releases/download/v1.8.1/velero-v1.8.1-linux-amd64.tar.gz
tar -xvf velero-v1.8.1-linux-amd64.tar.gz
mv velero-v1.8.1-linux-amd64 /usr/bin/velero



