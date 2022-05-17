# bigbang-dev

## Infrastrucuture

Single node used for the bigbang quickstart demo. 

Modules controlled by terragrunt create a single node cluster in a private subnet behind a bastion host with a public IP. By default, a single AZ is used. 

Using local terraform state storage. S3 configurations are commented out in /terraform/infrastructure/terragrunt.hcl



