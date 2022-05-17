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

