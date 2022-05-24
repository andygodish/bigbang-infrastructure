# bigbang-dev

## Project Repository

Create a work directory and clone the project repo. Make sure you are working from the correct branch. 

## GPG Key 

https://repo1.dso.mil/platform-one/big-bang/customers/template/-/tree/main/#create-gpg-encryption-key

Note the $fp variable and how it is used in later steps involving pushing encrypted data to your git repo. 

Summary: Using gpg to generate a key that will be used by sops for encryption. The multiline command generates a key named bigbang-dev-environment. This name is grepped for and assigend to a shell variable called $fp. This key is then implemented in the .sops.yaml file located in the bigbang directory. 

