# bigbang-dev

## Kubeconfig
Pull in kubeconfig from aws s3

```
aws s3 cp s3://bigbang-dev-1h4-rke2/rke2.yaml ~/.kube/config
```

## Disable PSPs (BB Requirement)

```
kubectl patch psp system-unrestricted-psp -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
kubectl patch psp global-unrestricted-psp -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
kubectl patch psp global-restricted-psp -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
```

## Project Repository

Create a work directory and clone the project repo. 

## GPG Key 

https://repo1.dso.mil/platform-one/big-bang/customers/template/-/tree/main/#create-gpg-encryption-key

