# bigbang-dev

## Project Repository

Create a work directory and clone the project repo. Make sure you are working from the correct branch. 

## GPG Key 

https://repo1.dso.mil/platform-one/big-bang/customers/template/-/tree/main/#create-gpg-encryption-key

Note the $fp variable and how it is used in later steps involving pushing encrypted data to your git repo. 

Summary: Using gpg to generate a key that will be used by sops for encryption. The multiline command generates a key named bigbang-dev-environment. This name is grepped for and assigend to a shell variable called $fp. This key is then implemented in the .sops.yaml file located in the platform directory. 

## TLS Certificate

platform/configmap.yaml contains info pertaining to the domain of your platform. By default, it is set to bigbang.dev. 

## Registry1 Pull Credentials

You'll need to use sops to update your secrets.enc.yaml file. 

```
sops secrets.enc.yaml

values.yaml: |-
    registryCredentials:
    - registry: registry1.dso.mil
      username: replace-with-your-iron-bank-user
      password: replace-with-your-iron-bank-personal-access-token
    istio:
    ...
```
## Configure fluxcd for GitOps

Update platform/base/kustomization.yaml to reference your forked git repository container BB 

Make sure the path is set correctly in the kustomization yaml since you are differing from the template repository. ie ./platform/dev

## Deploy

https://repo1.dso.mil/platform-one/big-bang/customers/template/-/tree/main/#deploy

Create a secret resource using the GPG key. There's a command in the docs that creates the secret based on a gpg cli command using /dev/stdin as a --from-file reference to the .asc

Flux needs an imagePullSecret: ` kubectl create secret docker-registry private-registry --docker-server=registry1.dso.mil --docker-username=<Your IronBank Username> --docker-password=<Your IronBank Personal Access Token> -n flux-system`

Flux will also needs git credentials 

 kubectl create secret generic private-git --from-literal=username=<Your Repo1 Username> --from-literal=password=<Your Repo1 Personal Access Token> -n bigbang

## TODO

Automate the creation of a ssh key and configuration for git repository. 